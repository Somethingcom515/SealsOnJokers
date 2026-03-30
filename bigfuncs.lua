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
        if not SMODS.find_card(self.config.center_key, true)[1] then
            G.GAME.used_jokers[self.config.center_key] = nil
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

local cache_context = SEALS.cache_context

function SEALS.calculate_quantum_editions(card, effects, context)
    if context.extra_edition or SMODS.extra_edition_calc_in_progress or not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return end
    local extra_editions = SEALS.get_quantum_editions(card)
    if not extra_editions[1] then return end
    context.extra_edition = true
    SMODS.extra_edition_calc_in_progress = true
    table.sort(extra_editions, function(a, b) return G.P_CENTERS[a].order < G.P_CENTERS[b].order end)
    for _, v in ipairs(extra_editions) do
        local center = G.P_CENTERS[v]
        local passed
        if center.calculate then
            cache_context(card, center)
            passed = G.soe_quantum_context_cache[v] == true
            if not passed then
                for _, vv in ipairs(G.soe_quantum_context_cache[v]) do
                    if context[vv] then passed = true; break end
                end
            end
        end
        if passed then
            local copy = SEALS.copy_card_but_not(card, v)
            copy.ability.extra_edition = v
            local edition = copy:calculate_edition(context)
            if edition then
                effects[#effects+1] = {edition = edition}
            end
        end
    end
    context.extra_edition = nil
    SMODS.extra_edition_calc_in_progress = nil
end

function SEALS.recalc_quantum_editions(card, from_get)
    if not G.deck then return end
    local old_editions = G.soe_old_editions[card] or {}
    local new_editions = from_get or SEALS.get_quantum_editions(card)
    local old, new, removed, added = {}, {}, {}, {}
    for _, v in ipairs(old_editions) do
        old[v] = (old[v] or 0) + 1
        new[v] = 0
    end
    for _, v in ipairs(new_editions) do
        new[v] = (new[v] or 0) + 1
    end
    for k, v in pairs(new) do
        if old[k] and old[k] > v then
            for _=1, old[k]-v do
                removed[#removed+1] = k
            end
        elseif not old[k] or old[k] < v then
            for _=1, v-(old[k] or 0) do
                added[#added+1] = k
            end
        end
    end
    local old_edition = card.edition
    if added[1] then
        for _, v in ipairs(added) do
            if v == 'e_soe_frozen' then card.ability.soe_has_e_soe_frozen = true end
            card.edition = nil
            card:set_edition(v, true, true)
        end
    end
    if removed[1] then
        for _, v in ipairs(added) do
            local edition = {
                [v:sub(3)] = true,
                type = v:sub(3),
                key = v
            }
            for k, v in pairs(G.P_CENTERS[v].config) do
                edition[k] = copy_table(v)
            end
            card.edition = edition
            card:set_edition(nil, true, true)
        end
    end
    card.edition = old_edition
end

local sc = SMODS.shallow_copy
function SEALS.get_quantum_editions(card)
    local editions = copy_table(card.ability.soe_quantum_editions) or {}
    local counts = {}
    if editions[1] then
        for _, v in ipairs(editions) do
            counts[v] = true
        end
    end
    if SEALS.counts_as_everything(card) then
        for _, v in ipairs(G.P_CENTER_POOLS.Edition) do
            local k = v.key
            if not counts[k] and k ~= 'e_base' and not (card.edition and card.edition.key == k) then
                editions[#editions+1] = k
            end
        end
    end
    if SEALS.has_seal(card, 'soe_rainbowseal') then
        editions[#editions+1] = not counts.e_foil and 'e_foil' or nil
        editions[#editions+1] = not counts.e_holo and 'e_holo' or nil
        editions[#editions+1] = not counts.e_polychrome and 'e_polychrome' or nil
    end
    SEALS.recalc_quantum_editions(card, sc(editions))
    G.soe_old_editions[card] = editions
    return editions
end

function SEALS.get_quantum_enhancements(card)
    local enhancements = copy_table(card.ability.soe_quantum_enhancements) or {}
    if SEALS.counts_as_everything(card) then
        local counts = {}
        if enhancements[1] then
            for _, v in ipairs(enhancements) do
                counts[v] = true
            end
        end
        for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
            local k = v.key
            if not counts[k] and card.config.center_key ~= k then
                enhancements[#enhancements+1] = k
            end
        end
    end
    return enhancements
end

function SEALS.calculate_quantum_enhancements(card, effects, context, joker, smods)
    if context.extra_enhancement or context.check_enhancement or SMODS.extra_enhancement_calc_in_progress or SEALS.extra_enhancement_check_in_progress or not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return end
    local extra_enhancements_list
    if joker then
        extra_enhancements_list = {joker}
    elseif smods then
        G.soe_normal_smods_quantum = true
        local extra_enhancements = SMODS.get_enhancements(card, true)
        G.soe_normal_smods_quantum = nil
        extra_enhancements_list = {}
        for k in pairs(extra_enhancements) do
            extra_enhancements_list[#extra_enhancements_list+1] = k
        end
    else
        extra_enhancements_list = SEALS.get_quantum_enhancements(card)
    end
    if not extra_enhancements_list[1] then return end
    context.extra_enhancement = true
    SMODS.extra_enhancement_calc_in_progress = true
    if not joker then table.sort(extra_enhancements_list, function(a, b) return G.P_CENTERS[a].order < G.P_CENTERS[b].order end) end
    for _, k in ipairs(extra_enhancements_list) do
        local center = G.P_CENTERS[k]
        cache_context(card, center)
        local passed = G.soe_quantum_context_cache[k] == true
        if not passed then
            for _, v in ipairs(G.soe_quantum_context_cache[k]) do
                if context[v] then passed = true; break end
            end
        end
        if passed then
            local copy = SEALS.copy_card_but_not(card, k)
            copy.ability.extra_enhancement = k
            local eval = eval_card(copy, context)
            if eval.playing_card or eval.enhancement or eval.end_of_round then
                effects[#effects+1] = eval
            end
        end
    end
    context.extra_enhancement = nil
    SMODS.extra_enhancement_calc_in_progress = nil
end

function SEALS.get_seals(card, extra_only)
    local seals = copy_table(card.ability.soe_quantum_seals) or {}
    local counts = {}
    if seals[1] then
        for _, v in ipairs(seals) do
            counts[v] = true
        end
    end
    if AKYRS and SMODS.find_card('j_akyrs_aikoyori')[1] then
        seals[#seals+1] = not counts.Red and 'Red' or nil
        seals[#seals+1] = not counts.Gold and 'Gold' or nil
    end
    if SEALS.counts_as_everything(card) then
        for _, v in ipairs(G.P_CENTER_POOLS.Seal) do
            local k = v.key
            if not counts[k] and k ~= 'soe_upgradedsoe_rainbowsealseal' then
                seals[#seals+1] = k
            end
        end
        return seals
    end
    if not extra_only and card.seal then table.insert(seals, 1, card.seal) end
    return seals
end

local oldsealdrawstepfunc = SMODS.DrawSteps.seal.func
SMODS.DrawSteps.seal.func = function(self, ...)
    local oldseal = self.seal
    if self.drawseal then
        if self.drawseal == 'none' then
            self.seal = nil
        else
            self.seal = self.drawseal
        end
    end
    oldsealdrawstepfunc(self, ...)
    self.seal = oldseal
end

function SEALS.calculate_quantum_seals(card, effects, context)
    if context.extra_seal or SMODS.extra_seal_calc_in_progress or not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return end
    local extra_seals_list = SEALS.get_seals(card, true)
    if not extra_seals_list[1] then return end
    context.extra_seal = true
    SMODS.extra_seal_calc_in_progress = true
    local old_seal = card.seal
    card.drawseal = old_seal or 'none'
    local old_ability_seal = copy_table(card.ability.seal)
    table.sort(extra_seals_list, function(a, b) return G.P_SEALS[a].order < G.P_SEALS[b].order end)
    for _, k in ipairs(extra_seals_list) do
        local center = G.P_SEALS[k]
        local passed
        if (k == 'Gold' or k == 'Blue' or center.original_mod) and center.calculate then
            cache_context(card, center)
            passed = G.soe_quantum_context_cache[k] == true
            if not passed then
                for _, v in ipairs(G.soe_quantum_context_cache[k]) do
                    if context[v] then passed = true; break end
                end
            end
        end
        if passed or not (k == 'Gold' or k == 'Blue' or center.original_mod) then
            card.seal = k
            card.ability.seal = {}
            local config = center.config
            if config then
                for k, v in pairs(config) do
                    card.ability.seal[k] = copy_table(v)
                end
            end
            card.ability.extra_seal = k
            local eval
            if SEALS.is_in_area(card, 'playing_cards') and (k == 'Gold' or k == 'Blue') then
                eval = {seals = SEALS.calculate_hardcoded_seals(card, context, k)}
            else
                eval = {seals = card:calculate_seal(context)}
            end
            if center.get_p_dollars then
                local p_dollars = center:get_p_dollars(card)
                if p_dollars and p_dollars ~= 0 then
                    if not eval.playing_card then eval.playing_card = {} end
                    eval.playing_card.p_dollars = p_dollars
                end
            end
            if eval.seals or eval.playing_card then
                effects[#effects+1] = eval
            end
        end
    end
    card.seal = old_seal
    card.drawseal = nil
    card.ability.seal = old_ability_seal
    context.extra_seal = nil
    SMODS.extra_seal_calc_in_progress = nil
end

function SEALS.calculate_hardcoded_seals(card, context, seal)
    if seal == 'Gold' and ((context.main_scoring and context.cardarea == G.play) or context.forcetrigger) then
        return {dollars = 3}
    end
    if seal == 'Blue' and ((context.playing_card_end_of_round and context.cardarea == G.hand and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger) then
        return {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet, func = function()
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if G.GAME.last_hand_played then
                        local _planet
                        for _, v in ipairs(G.P_CENTER_POOLS.Planet) do
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
end

function SEALS.get_quantum_jokers(card)
    local jokers = copy_table(card.ability.soe_jokers) or {}
    if (SEALS.config.omegasealplayingcardjokerenable or not SEALS.is_in_area(card, 'playing_cards')) and SEALS.counts_as_everything(card) then
        local counts = {}
        if jokers[1] then
            for _, v in ipairs(jokers) do
                counts[v] = true
            end
        end
        for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
            local k = v.key
            if not counts[k] and card.config.center_key ~= k and k ~= 'j_phanta_normalface' then
                jokers[#jokers+1] = k
            end
        end
    elseif card.config.center_key == 'j_soe_ascendedjoker' then
        local counts = {}
        if jokers[1] then
            for _, v in ipairs(jokers) do
                counts[v] = true
            end
        end
        for _, v in ipairs(G.P_CENTER_POOLS.Joker) do
            local k = v.key
            if not counts[k] and not v.original_mod then
                jokers[#jokers+1] = k
                if k == 'j_perkeo' then break end
            end
        end
    end
    return jokers
end

function SEALS.calculate_quantum_jokers(card, context, extra_jokers_list)
    if context.extra_joker or SMODS.extra_joker_calc_in_progress or not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return end
    extra_jokers_list = extra_jokers_list or SEALS.get_quantum_jokers(card)
    if not extra_jokers_list[1] then return end
    context.extra_joker = true
    SMODS.extra_joker_calc_in_progress = true
    local jokers_table = {}
    local triggered
    table.sort(extra_jokers_list, function(a, b) return G.P_CENTERS[a].order < G.P_CENTERS[b].order end)
    for _, k in ipairs(extra_jokers_list) do
        local center = G.P_CENTERS[k]
        local passed
        if center.original_mod and center.calculate then
            cache_context(card, center)
            passed = G.soe_quantum_context_cache[k] == true
            if not passed then
                for _, v in ipairs(G.soe_quantum_context_cache[k]) do
                    if context[v] then passed = true; break end
                end
            end
        end
        if passed or not center.original_mod then
            local copy = SEALS.copy_card_but_not(card, k)
            local my_pos, cards = card.rank, card.area and card.area.cards
            if cards then
                cards[my_pos] = copy
                copy.rank = my_pos
            end
            local joker, trigger = copy:calculate_joker(context)
            if cards then
                cards[my_pos] = card
            end
            local should = not (context.mod_probability or context.fix_probability) and card.config.center_key == 'j_soe_ascendedjoker'
            if joker == true then joker = {remove = true} end
            if type(joker) ~= 'table' then joker = nil end
            if joker then
                joker.card = card
                if should then
                    local oldprefunc = joker.pre_func
                    joker.pre_func = function()
                        SEALS.event(function()
                            card:set_sprites(center)
                            if center.soul_pos then
                                card.children.floating_sprite:set_sprite_pos(center.soul_pos)
                            else
                                card.children.floating_sprite = nil
                            end
                            return true
                        end)
                        if oldprefunc then oldprefunc() end
                    end
                end
                jokers_table[#jokers_table+1] = joker
            end
            if trigger then
                if not joker and should then
                    SEALS.event(function()
                        card:set_sprites(center)
                        if center.soul_pos then
                            card.children.floating_sprite:set_sprite_pos(center.soul_pos)
                        else
                            card.children.floating_sprite = nil
                        end
                        return true
                    end)
                end
                triggered = true
            end
        end
    end
    context.extra_joker = nil
    SMODS.extra_joker_calc_in_progress = nil
    if jokers_table[2] then
        return SMODS.merge_effects(jokers_table)
    elseif jokers_table[1] then
        return jokers_table[1]
    else
        return nil, triggered
    end
end

function SEALS.get_quantum_stickers(card)
    if SEALS.counts_as_everything(card) then
        local stickers = {}
        for _, v in ipairs(SMODS.Sticker.obj_buffer) do
            if not card.ability[v] and v ~= 'akyrs_concealed' then
                stickers[#stickers+1] = v
            end
        end
        return stickers
    end
    return copy_table(card.ability.soe_quantum_stickers) or {}
end

function SEALS.calculate_quantum_stickers(card, effects, context)
    if context.extra_sticker or SMODS.extra_sticker_calc_in_progress or not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return end
    local extra_stickers_list = SEALS.get_quantum_stickers(card)
    if not extra_stickers_list[1] then return end
    context.extra_sticker = true
    SMODS.extra_sticker_calc_in_progress = true
    table.sort(extra_stickers_list, function(a, b) return SMODS.Stickers[a].order < SMODS.Stickers[b].order end)
    for _, k in ipairs(extra_stickers_list) do
        local center = SMODS.Stickers[k]
        local passed
        if center.calculate then
            cache_context(card, center)
            passed = G.soe_quantum_context_cache[k] == true
            if not passed then
                for _, v in ipairs(G.soe_quantum_context_cache[k]) do
                    if context[v] then passed = true; break end
                end
            end
        end
        if passed then
            local copy = SEALS.copy_card_but_not(card, k)
            copy.ability.extra_sticker = k
            local sticker = copy:calculate_sticker(context, k)
            if sticker then
                effects[#effects+1] = {sticker = sticker}
            end
        end
    end
    context.extra_sticker = nil
    SMODS.extra_sticker_calc_in_progress = nil
end

local oldsmodsiseternal = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
    local stickers = SEALS.get_quantum_stickers(card)
    if stickers and stickers[1] then
        for _, v in ipairs(stickers) do
            if v == 'eternal' then return true end
        end
    end
    return oldsmodsiseternal(card, trigger)
end

--local oldsmodscalculatequantumenhancements = SMODS.calculate_quantum_enhancements
function SMODS.calculate_quantum_enhancements(card, effects, context)
    if SMODS.optional_features.quantum_enhancements then--[[ oldsmodscalculatequantumenhancements(card, effects, context) end]]
        SEALS.calculate_quantum_enhancements(card, effects, context, nil, true)
    end
    SEALS.calculate_quantum_enhancements(card, effects, context)
    SEALS.calculate_quantum_editions(card, effects, context)
    SEALS.calculate_quantum_seals(card, effects, context)
    SEALS.calculate_quantum_stickers(card, effects, context)
end

function SEALS.safe_set_ability(card, center)
    local oldcenter = card.config.center
    local config = center.config
    local ability = card.ability
    card.config.center = center
    card.config.center_key = center.key
    if ability.bonus and oldcenter.config.bonus then
        ability.bonus = ability.bonus - oldcenter.config.bonus
    end
    local new_ability = {
        'name', center.name,
        'effect', center.effect,
        'set', center.set,
        'mult', config.mult or 0,
        'h_mult', config.h_mult or 0,
        'h_x_mult', config.h_x_mult or 0,
        'h_dollars', config.h_dollars or 0,
        'p_dollars', config.p_dollars or 0,
        't_mult', config.t_mult or 0,
        't_chips', config.t_chips or 0,
        'x_mult', config.Xmult or config.x_mult or 1,
        'h_chips', config.h_chips or 0,
        'x_chips', config.x_chips or 1,
        'h_x_chips', config.h_x_chips or 1,
        'repetitions', config.repetitions or 0,
        'h_size', config.h_size or 0,
        'd_size', config.d_size or 0,
        'extra_value', 0,
        'type', center.config.type or '',
        'order', center.order,
        'perma_bonus', 0,
        'perma_x_chips', 0,
        'perma_mult', 0,
        'perma_x_mult', 0,
        'perma_h_chips', 0,
        'perma_h_x_chips', 0,
        'perma_h_mult', 0,
        'perma_h_x_mult', 0,
        'perma_p_dollars', 0,
        'perma_h_dollars', 0,
        'perma_repetitions', 0,
        'card_limit', 0,
        'extra_slots_used', 0,
    }
    for i=1, 66, 2 do
        ability[new_ability[i]] = copy_table(new_ability[i+1])
    end
    ability.bonus = (ability.bonus or 0) + (center.config.bonus or 0)
    for k, v in pairs(config) do
        if k ~= 'bonus' then
            ability[k] = copy_table(v)
        end
    end
    if center.consumeable then
        ability.consumeable = center.config
    else
    	ability.consumeable = nil
    end
    if ability.name == 'Invisible Joker' then
        ability.invis_rounds = 0
    end
    if ability.name == 'To Do List' then
        local _poker_hands = {}
        for _, v in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(v) and v ~= ability.to_do_poker_hand then
                _poker_hands[#_poker_hands+1] = v
            end
        end
        ability.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed((card.area and card.area.config.type == 'title') and 'false_to_do' or 'to_do'))
    end
    if ability.name == 'Caino' then
        ability.caino_xmult = 1
    end
    if ability.name == 'Yorick' then
        ability.yorick_discards = ability.extra.discards
    end
    if ability.name == 'Loyalty Card' then
        ability.burnt_hand = 0
        ability.loyalty_remaining = ability.extra.every
    end
    ability.hands_played_at_create = G.GAME.hands_played
    if center.set_ability and type(center.set_ability) == 'function' then center:set_ability(card) end
    if Yorick then ability.immutable = {yorick_amount = 1} end
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