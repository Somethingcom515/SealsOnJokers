function Card:soe_no_touching2(dissolve_colours, silent, dissolve_time_fac, no_juice)
    dissolve_colours = dissolve_colours or (type(self.destroyed) == 'table' and self.destroyed.colours) or nil
    dissolve_time_fac = dissolve_time_fac or (type(self.destroyed) == 'table' and self.destroyed.time) or nil
    local dissolve_time = 0.7*(dissolve_time_fac or 1)
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    if not no_juice then self:juice_up() end
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
    if not silent then 
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
                    play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                    play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.05*dissolve_time,
        func = (function() self:soe_no_touching() return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end

function Card:soe_no_touching()
    self.removed = true

    if self.area then self.area:remove_card(self) end
    if G.in_delete_run then goto skip_game_actions_during_remove end

    self:remove_from_deck()
    if self.joker_added_to_deck_but_debuffed then
        if self.edition and self.edition.card_limit then
            if self.ability.consumeable then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.edition.card_limit
            elseif self.ability.set == 'Joker' then
                G.jokers.config.card_limit = G.jokers.config.card_limit - self.edition.card_limit
            end
        end 
    end

    if not G.OVERLAY_MENU then
        if not SMODS.find_card(self.config.center.key, true)[1] then
            G.GAME.used_jokers[self.config.center.key] = nil
        end
    end

    ::skip_game_actions_during_remove::
    if G.playing_cards then
        for k, v in ipairs(G.playing_cards) do
            if v == self then
                table.remove(G.playing_cards, k)
                break
            end
        end
        for k, v in ipairs(G.playing_cards) do
            v.playing_card = k
        end
    end

    remove_all(self.children)

    for k, v in pairs(G.I.CARD) do
        if v == self then
            table.remove(G.I.CARD, k)
        end
    end
    Moveable.remove(self)
end

--- Thanks to thewintercomet on discord for the base of this code!
local oldcardsetedition = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
    if not (SMODS.find_card("j_soe_sealjoker2")[1] or SEALS.has_seal(self, 'soe_rainbowseal')) then
        return oldcardsetedition(self, edition, immediate, silent, delay)
    end

    SMODS.enh_cache:write(self, nil)
	-- Check to see if negative is being removed and reduce card_limit accordingly
	if (self.added_to_deck or self.joker_added_to_deck_but_debuffed or (self.area == G.hand and not self.debuff)) and self.edition and self.edition.card_limit then
		if self.ability.consumeable and self.area == G.consumeables then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.edition.card_limit
		elseif self.ability.set == 'Joker' and self.area == G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit - self.edition.card_limit
		elseif self.area == G.hand then
			if G.hand.config.real_card_limit then
				G.hand.config.real_card_limit = G.hand.config.real_card_limit - self.edition.card_limit
			end
			G.hand.config.card_limit = G.hand.config.card_limit - self.edition.card_limit
		end
	end

	local old_edition = self.edition and self.edition.key
	if old_edition then
		self.ignore_base_shader[old_edition] = nil
		self.ignore_shadow[old_edition] = nil

		local on_old_edition_removed = G.P_CENTERS[old_edition] and G.P_CENTERS[old_edition].on_remove
		if type(on_old_edition_removed) == "function" then
			on_old_edition_removed(self)
		end
	end

	local edition_type = nil
	if type(edition) == 'string' then
        if string.sub(edition, 1, 2) ~= 'e_' then
            edition = 'e_' .. edition
        end
		assert(G.P_CENTERS[edition], ("Edition \"%s\" is invalid."):format(edition))
		edition_type = string.sub(edition, 3)
	elseif type(edition) == 'table' then
		if edition.type then
			edition_type = edition.type
		else
			for k, v in pairs(edition) do
				if v then
					assert(not edition_type, "Tried to apply more than one edition.")
					edition_type = k
				end
			end
		end
	end

	if not edition_type or edition_type == 'base' then
		if self.edition == nil then -- early exit
			return
		end
		self.edition = nil -- remove edition from card
		self:set_cost()
		if not silent then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = not immediate and 0.2 or 0,
				blockable = not immediate,
				func = function()
					self:juice_up(1, 0.5)
					play_sound('whoosh2', 1.2, 0.6)
					return true
				end
			}))
		end
		return
	end

    if not self.soe_from_copy then
        self.ability.soe_editions = self.ability.soe_editions or {}
        table.insert(self.ability.soe_editions, edition_type)
    end

    local all_types = copy_table(SEALS.get_quantum_editions(self))
    local edition_table = {}
    
    if next(SEALS.get_quantum_editions(self)) then
        for _, ed_key in pairs(all_types) do
            local get_edition = G.P_CENTERS["e_"..ed_key]
            for k, v in pairs(get_edition.config) do
                if type(v) == 'table' then
                    edition_table[k] = copy_table(v)
                else
                    edition_table[k] = v
                end
                if k == 'card_limit' and (self.added_to_deck or self.joker_added_to_deck_but_debuffed or (self.area == G.hand and not self.debuff)) and G.jokers and G.consumeables then
                    if self.ability.consumeable and self.area == G.consumeables then
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit - v
                    elseif self.ability.set == 'Joker' and self.area == G.jokers then
                        G.jokers.config.card_limit = G.jokers.config.card_limit - v
                    elseif self.area == G.hand then
                        if G.hand.config.real_card_limit then
                            G.hand.config.real_card_limit = G.hand.config.real_card_limit - v
                        end
                        G.hand.config.card_limit = G.hand.config.card_limit - v
                    end
                end
            end
            local on_edition_removed = get_edition.on_remove
            if type(on_edition_removed) == "function" then
                on_edition_removed(self)
            end
        end
    end
    local other_get_edition = G.P_CENTERS["e_"..edition_type]
    self.edition = {}
    self.edition[edition_type] = true
    self.edition.type = edition_type
    local other_key = 'e_' .. edition_type
    self.edition.key = other_key
    if other_get_edition.override_base_shader or other_get_edition.disable_base_shader then
        self.ignore_base_shader[other_key] = true
    end
    if other_get_edition.no_shadow or other_get_edition.disable_shadow then
        self.ignore_shadow[other_key] = true
    end
    for k, v in pairs(edition_table) do
        self.edition[k] = v
    end
    local all_types = {edition_type}
    for k, v in ipairs(SEALS.get_quantum_editions(self)) do
        table.insert(all_types, v)
    end

    for _, ed_key in pairs(all_types) do
        local get_edition = G.P_CENTERS["e_"..ed_key]
        for k, v in pairs(get_edition.config) do
            if k == 'card_limit' and (self.added_to_deck or self.joker_added_to_deck_but_debuffed or (self.area == G.hand and not self.debuff)) and G.jokers and G.consumeables then
                if self.ability.consumeable then
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + v
                elseif self.ability.set == 'Joker' then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + v
                elseif self.area == G.hand then
                    local is_in_pack = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.config.center.draw_hand))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            if G.hand.config.real_card_limit then
                                G.hand.config.real_card_limit = G.hand.config.real_card_limit + v
                            end
                            G.hand.config.card_limit = G.hand.config.card_limit + v
                            if not is_in_pack and G.GAME.blind.in_blind then
                                G.FUNCS.draw_from_deck_to_hand(v)
                            end
                            return true
                        end
                    }))
                end
            end
        end
        local on_edition_applied = get_edition.on_apply
        if type(on_edition_applied) == "function" then
            on_edition_applied(self)
        end
    end

	if self.area and self.area == G.jokers then
		if self.edition then
			if not G.P_CENTERS['e_' .. (self.edition.type)].discovered then
				discover_card(G.P_CENTERS['e_' .. (self.edition.type)])
			end
		else
			if not G.P_CENTERS['e_base'].discovered then
				discover_card(G.P_CENTERS['e_base'])
			end
		end
	end

	if self.edition and not silent then
		local ed = G.P_CENTERS['e_' .. (self.edition.type)]
		G.CONTROLLER.locks.edition = true
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = not immediate and 0.2 or 0,
			blockable = not immediate,
			func = function()
				if self.edition then
					self:juice_up(1, 0.5)
					play_sound(ed.sound.sound, ed.sound.per, ed.sound.vol)
				end
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				G.CONTROLLER.locks.edition = false
				return true
			end
		}))
	end

	if delay then
		self.delay_edition = true
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()
				self.delay_edition = nil
				return true
			end
		}))
	end

	if G.jokers and self.area == G.jokers then
		check_for_unlock({ type = 'modify_jokers' })
	end

	self:set_cost()
end

function SEALS.calculate_quantum_editions(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end

    context.extra_edition = true
    local extra_editions = SEALS.get_quantum_editions(card)
    table.sort(extra_editions, function(a, b) return G.P_CENTERS["e_"..a].order < G.P_CENTERS["e_"..b].order end)
    local old_edition = card.edition and copy_table(card.edition) or nil
    for i, v in ipairs(extra_editions) do
        local ed_key = "e_"..v
        if G.P_CENTERS[ed_key] then
            local cardedition = {
                [v] = true,
                type = v,
                key = ed_key
            }
            for k, v in pairs(G.P_CENTERS[ed_key].config) do
                cardedition[k] = copy_table(v)
            end
            card.edition = cardedition
            card.ability.extra_edition = ed_key
            G.GAME.triggered_edition = {card.sort_id, ed_key}
            local eval = {edition = card:calculate_edition(context)}
            G.GAME.triggered_edition = nil
            if eval.edition then
                table.insert(effects, eval)
            end
        end
    end
    
    card.edition = old_edition
    context.extra_edition = nil
end

function SEALS.get_quantum_editions(card)
    if (card.ability.soe_editions and #card.ability.soe_editions >= 2) or SEALS.has_seal(card, 'soe_rainbowseal') then
        local quantumeditions = copy_table(card.ability.soe_editions or {})
        for i, v in ipairs(quantumeditions) do
            if v == (card.edition or {}).type then
                table.remove(quantumeditions, i)
                break
            end
        end
        if SEALS.has_seal(card, 'soe_rainbowseal') then
            for i, v in ipairs({"foil", "holo", "polychrome"}) do
                if v ~= (card.edition or {}).type then
                    table.insert(quantumeditions, v)
                end
            end
        end
        return quantumeditions
    end
    return {}
end

function SEALS.get_enhancements(card, extra_only)
    if not card then return {} end
    local enhancements = copy_table(card.ability.soe_quantum_enhancements or {})
    if not extra_only and card.config.center.key ~= "c_base" then table.insert(enhancements, 1, card.config.center.key) end
    return enhancements
end

function SEALS.calculate_quantum_enhancements(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end
    context.extra_enhancement = true
    local old_ability = copy_table(card.ability)
    local old_center = card.config.center
    local old_center_key = card.config.center_key
    local extra_enhancements_list = SEALS.get_enhancements(card, true)
    table.sort(extra_enhancements_list, function(a, b) return G.P_CENTERS[a].order < G.P_CENTERS[b].order end)
    for _, k in ipairs(extra_enhancements_list) do
        SEALS.safe_set_ability(card, G.P_CENTERS[k])
        card.ability.extra_enhancement = k
        G.GAME.triggered_enhancement = {card.sort_id, k}
        local eval = eval_card(card, context)
        G.GAME.triggered_enhancement = nil
        if next(eval) then
            table.insert(effects, eval)
        end
    end
    card.ability = old_ability
    card.config.center = old_center
    card.config.center_key = old_center_key
    context.extra_enhancement = nil
end

function SEALS.get_seals(card, extra_only)
    if not card or not card.ability then return {} end
    local seals = copy_table(card.ability.soe_quantum_seals or {})
    if AKYRS and SMODS.find_card('j_akyrs_aikoyori')[1] and Card.is(card, Card) then seals[#seals+1] = 'Red'; seals[#seals+1] = 'Gold' end
    if not extra_only then table.insert(seals, 1, card.seal) end
    return seals
end

local oldsealdrawstepfunc = SMODS.DrawSteps["seal"].func
SMODS.DrawSteps["seal"].func = function(self, layer)
    local oldseal = self.seal
    if self.drawseal then self.seal = self.drawseal ~= 'none' and self.drawseal or nil end
    local g = oldsealdrawstepfunc(self, layer)
    self.seal = oldseal
    return g
    --[[
    if self.ability.quantum_seals then
        local cardseal = self.drawseal or self.seal
        local seal = G.P_SEALS[cardseal] or {}
        if type(seal.draw) == 'function' then
            seal:draw(self, layer)
        elseif cardseal then
            G.shared_seals[cardseal].role.draw_major = self
            G.shared_seals[cardseal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if cardseal == 'Gold' then G.shared_seals[cardseal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
        end
    else
        oldsealdrawstepfunc(self, layer)
    end
    ]]
end

function SEALS.calculate_quantum_seals(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end
    context.extra_seal = true
    local old_seal = card.seal
    card.drawseal = old_seal or 'none'
    local old_ability_seal = copy_table(card.ability.seal)
    local extra_seals_list = SEALS.get_seals(card, true)
    table.sort(extra_seals_list, function(a, b) return G.P_SEALS[a].order < G.P_SEALS[b].order end)
    for _, k in ipairs(extra_seals_list) do
        SEALS.safe_set_seal(card, k)
        card.ability.extra_seal = k
        local eval
        if card.playing_card and (k == 'Gold' or k == 'Blue') then
            eval = {seals = SEALS.calculate_hardcoded_seals(card, context)}
        else
            eval = {seals = card:calculate_seal(context)}
        end
        if G.P_SEALS[k].get_p_dollars then
            local p_dollars = G.P_SEALS[k]:get_p_dollars(card)
            if p_dollars and p_dollars ~= 0 then
                if not eval.playing_card then eval.playing_card = {} end
                eval.playing_card.p_dollars = p_dollars
            end
        end
        if next(eval) then
            table.insert(effects, eval)
        end
    end
    card.seal = old_seal
    card.drawseal = nil
    card.ability.seal = old_ability_seal
    context.extra_seal = nil
end

function SEALS.calculate_hardcoded_seals(card, context)
    if card.seal == 'Blue' and ((context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger) then
        return {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet, func = function()
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if G.GAME.last_hand_played then
                        local _planet
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        SMODS.add_card({ key = _planet, key_append = 'blusl' })
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)
            }))
        end}
    end
    if card.seal == 'Gold' and ((context.main_scoring and context.cardarea == G.play) or context.forcetrigger) then
        return {dollars = 3, card = card}
    end
end

function SEALS.get_quantum_jokers(card)
    return copy_table(card.ability.soe_jokers or {})
end

function SEALS.get_quantum_stickers(card)
    for k, v in pairs(card.ability.soe_quantum_stickers or {}) do
        if not card.ability[k] then
            card.ability.soe_quantum_stickers[k] = nil
        end
    end
    return copy_table(card.ability.soe_quantum_stickers or {})
end

function SEALS.calculate_quantum_stickers(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end
    context.extra_stickers = true
    for k, v in pairs(SEALS.get_quantum_stickers(card)) do
        if card.ability[k] then
            for i=1, v do
                card.ability.extra_sticker = k
                local eval = {sticker = card:calculate_sticker(context, k)}
                card.ability.extra_sticker = nil
                if eval.sticker then
                    table.insert(effects, eval)
                end
            end
        end
    end
    context.extra_stickers = nil
end

function SEALS.safe_set_ability(self, center, dontsave)
    if not self or not center then return nil end
    local oldcenter = self.config.center
    local config
    if not dontsave then
        G.GAME.soe_savedjokervalues = G.GAME.soe_savedjokervalues or {}
        G.GAME.soe_savedjokervalues[self.sort_id] = G.GAME.soe_savedjokervalues[self.sort_id] or {}
        G.GAME.soe_savedjokervalues[self.sort_id][oldcenter.key] = copy_table(self.ability)
        config = G.GAME.soe_savedjokervalues[self.sort_id][center.key] or center.config
    else
        config = center.config
    end
    self.config.center = center
    for k, v in pairs(G.P_CENTERS) do
        if center == v then self.config.center_key = k end
    end
    if self.ability and oldcenter and oldcenter.config.bonus then
        self.ability.bonus = self.ability.bonus - oldcenter.config.bonus
    end
    local new_ability = {
        name = center.name,
        effect = center.effect,
        set = center.set,
        mult = config.mult or 0,
        h_mult = config.h_mult or 0,
        h_x_mult = config.h_x_mult or 0,
        h_dollars = config.h_dollars or 0,
        p_dollars = config.p_dollars or 0,
        t_mult = config.t_mult or 0,
        t_chips = config.t_chips or 0,
        x_mult = config.Xmult or config.x_mult or 1,
        h_chips = config.h_chips or 0,
        x_chips = config.x_chips or 1,
        h_x_chips = config.h_x_chips or 1,
    }
    self.ability = self.ability or {}
    for k, v in ipairs({new_ability, config}) do
        for kk, vv in pairs(v) do
            self.ability[kk] = copy_table(vv)
        end
    end
    if center.consumeable then 
        self.ability.consumeable = center.config
    else
    	self.ability.consumeable = nil
    end
    if self.ability.name == "Invisible Joker" then 
        self.ability.invis_rounds = 0
    end
    if self.ability.name == 'To Do List' then
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(k) then _poker_hands[#_poker_hands+1] = k end
        end
        local old_hand = self.ability.to_do_poker_hand
        self.ability.to_do_poker_hand = nil

        while not self.ability.to_do_poker_hand do
            self.ability.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed((self.area and self.area.config.type == 'title') and 'false_to_do' or 'to_do'))
            if self.ability.to_do_poker_hand == old_hand then self.ability.to_do_poker_hand = nil end
        end
    end
    if self.ability.name == 'Caino' then 
        self.ability.caino_xmult = 1
    end
    if self.ability.name == 'Yorick' then 
        self.ability.yorick_discards = self.ability.extra.discards
    end
    if self.ability.name == 'Loyalty Card' then 
        self.ability.burnt_hand = 0
        self.ability.loyalty_remaining = self.ability.extra.every
    end
end

function SEALS.safe_set_seal(self, _seal)
    self.seal = nil
    if _seal then
        self.seal = _seal
        self.ability.seal = {}
        for k, v in pairs(G.P_SEALS[_seal].config or {}) do
            self.ability.seal[k] = copy_table(v)
        end
    end
end

if not Card.unapply_to_run then
    function Card:unapply_to_run(center) -- (Sic)
        local center_table = {
            name = center and center.name or self and self.ability.name,
            extra = self and self.ability.extra or center and center.config.extra,
        }
        local obj = center or self.config.center
        if obj.unredeem and type(obj.unredeem) == "function" then
            obj:unredeem(self)
            return
        end

        if center_table.name == "Overstock" or center_table.name == "Overstock Plus" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(-center_table.extra)
                    return true
                end,
            }))
        end
        if center_table.name == "Tarot Merchant" or center_table.name == "Tarot Tycoon" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.tarot_rate = G.GAME.tarot_rate / center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Planet Merchant" or center_table.name == "Planet Tycoon" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.planet_rate = G.GAME.planet_rate / center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Hone" or center_table.name == "Glow Up" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.edition_rate = G.GAME.edition_rate / center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Magic Trick" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.playing_card_rate = 0
                    return true
                end,
            }))
        end
        if center_table.name == "Crystal Ball" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit - center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Clearance Sale" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.discount_percent = 0
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then
                            v:set_cost()
                        end
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Liquidation" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.discount_percent = G.P_CENTERS.v_clearance_sale.config.extra
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then
                            v:set_cost()
                        end
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Reroll Surplus" or center_table.name == "Reroll Glut" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + self.ability.extra
                    G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + self.ability.extra)
                    return true
                end,
            }))
        end
        if center_table.name == "Seed Money" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.interest_cap = 25 --note: does not account for potential deck effects
                    return true
                end,
            }))
        end
        if center_table.name == "Money Tree" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.used_vouchers.v_seed_money then
                        G.GAME.interest_cap = 50
                    else
                        G.GAME.interest_cap = 25
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Grabber" or center_table.name == "Nacho Tong" then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - center_table.extra
            ease_hands_played(-center_table.extra)
        end
        if center_table.name == "Paint Brush" or center_table.name == "Palette" then
            G.hand:change_size(-center_table.extra)
        end
        if center_table.name == "Wasteful" or center_table.name == "Recyclomancy" then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - center_table.extra
            ease_discard(-center_table.extra)
        end
        if center_table.name == "Antimatter" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        G.jokers.config.card_limit = G.jokers.config.card_limit - center_table.extra
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Hieroglyph" or center_table.name == "Petroglyph" then
            ease_ante(center_table.extra)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + center_table.extra

            if center_table.name == "Hieroglyph" then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + center_table.extra
                ease_hands_played(center_table.extra)
            end
            if center_table.name == "Petroglyph" then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + center_table.extra
                ease_discard(center_table.extra)
            end
        end
    end
end