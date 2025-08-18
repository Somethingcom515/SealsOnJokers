local cryptidyeohna = false
if SEALS.find_mod("Cryptid") then
    cryptidyeohna = true
end

function SEALS.create_fake_card(reference, key, reasonforcreation, juicecard, isseal, isconsumeable, dontsave)
    local center = G.P_CENTERS[key]
    local ability
    local cardformessages = juicecard or reference
    if reasonforcreation then
        if (reasonforcreation == "calculate" or reasonforcreation == "use") and not dontsave then
            if isseal then
                ability = reference.ability.seal.savedvalues[key]
            else
                ability = reference.ability.savedvalues[key]
            end
        elseif reasonforcreation == "add_to_deck" or reasonforcreation == "remove_from_deck" or dontsave then
            ability = center.config
        end
    end
    if ability then
        ability.set = center.set
        ability.name = center.name
        ability.consumeable = isconsumeable and center.config or nil
    end
    local fake_card = {
        ability = ability or reference.ability,
        config = {
            center = center,
        },
        sealsfakecard = true,
        sealsmessagecard = cardformessages,
        T = copy_table(reference.T),
        VT = copy_table(reference.VT),
        children = reference.children,
        states = copy_table(reference.states),
        role = {
            role_type = 'Major', --Major dictates movement, Minor is welded to some major
            offset = {x = 0, y = 0}, --Offset from Minor to Major
            major = nil,
            draw_major = reference,
            xy_bond = 'Strong',
            wh_bond = 'Strong',
            r_bond = 'Strong',
            scale_bond = 'Strong'
        },
        alignment = {
            type = 'a',
            offset = {x = 0, y = 0},
            prev_type = '',
            prev_offset = {x = 0, y = 0},
        },
        base_cost = reference.base_cost,
        area = reference.area,
        CT = reference.CT,
        ambient_tilt = 0.2,
        tilt_var = {mx = 0, my = 0, dx = 0, dy = 0, amt = 0},
        params = reference.params,
        sell_cost = reference.sell_cost,
        cost = reference.cost,
        unique_val = reference.unique_val,
        zoom = true,
        discard_pos = {
            r = 0,
            x = 0,
            y = 0,
        },
        facing = 'front',
        sprite_facing = 'front',
        click_timeout = 0.3,
        original_T = copy_table(reference.T),
    }
    fake_card.ability.extra_value = reference.ability.extra_value or 0
    fake_card.ability.cry_prob = reference.ability.cry_prob or 1
    for k, v in pairs(Card) do
        if type(v) == "function" then
            fake_card[k] = v
        end
    end
    fake_card.juice_up = function(self, scale, rot_amount)
        return cardformessages:juice_up(scale, rot_amount)
    end
    fake_card.remove = function(self)
        return nil
    end
    return fake_card
end

function SEALS.recursive_extra(table_return_table, index)
    if #table_return_table == 0 then return nil elseif #table_return_table == 1 then return table_return_table[1] end
    if not index then index = 1 end
    local ret = table_return_table[index]
    if index <= #table_return_table then
        local function getDeepest(tbl)
            tbl = tbl or {}
            while tbl.extra do
                tbl = tbl.extra
            end
            return tbl
        end
        local prev = getDeepest(ret)
        prev.extra = SEALS.recursive_extra(table_return_table, index + 1)
    end
    return ret
end

function SEALS.recursive_extra_for_non_jokers(table_return_table, index)
    if #table_return_table == 0 then return nil elseif #table_return_table == 1 then return table_return_table[1] end
    if not index then index = 1 end
    local ret = table_return_table[index]
    if index <= #table_return_table then
        ret.extra = SEALS.recursive_extra_for_non_jokers(table_return_table, index + 1)
    end
    return ret
end

function SEALS.get_allinone_jokers()
    local pooltocollect = {}
    local mod_whitelist = {
        Ascensio = true,
        Neato_Jokers = true,
        GSBFDI = true,
        TOGAPack = true,
        ortalab = true,
        paperback = true,
        extracredit = true,
        --MoreFluff = true,
        familiar = true,
    }
    local rarity_whitelist = {
        [1] = true,
    }
    for k, v in pairs(G.P_CENTERS) do
        if v.set == "Joker" then
            if rarity_whitelist[v.rarity] then
                table.insert(pooltocollect, v.key)
            end
        end
    end
    return pooltocollect
end

function SEALS.become_all_jokers_theoretically(context, card, usage, dt)
    local pooltocollect = {}

    -- Get the joker keys.
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        -- or (v.mod.id == "paperback") or (v.mod.id == "jen" and v.key ~= "j_jen_gourmand" and v.rarity == "cry_exotic")
        if (v.mod and ((v.mod.id == "ortalab" and v.key ~= "j_ortalab_grave_digger" and v.key ~= "j_ortalab_futuristic") or (v.mod.id == "Cryptid" and v.key ~= "j_cry_curse_sob" and (v.rarity == 3 or v.rarity == 4 or v.rarity == "cry_epic" or v.rarity == "cry_exotic") and v.key ~= "j_cry_error") or (v.mod.id == "Neato_Jokers") or (v.mod.id == "GSBFDI") or (v.mod.id == "TOGAPack") or (v.mod.id == "GSPhanta" and v.key ~= "j_phanta_shackles") or (v.mod.id == "Ascensio"))) then
            table.insert(pooltocollect, v.key)
        end
    end
    --pooltocollect = G.P_JOKER_RARITY_POOLS[3]
    if usage == "calculate" then
        return SEALS.get_some_jokers_returns_combined(context, card, pooltocollect)
    elseif usage == "add_to_deck" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_add_to_deck(v, false, card, not center.mod)
        end
    elseif usage == "remove_from_deck" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_remove_from_deck(v, false, card, not center.mod)
        end
    elseif usage == "update" then
        for k, v in pairs(pooltocollect) do
            if v.key then v = v.key end
            local center = G.P_CENTERS[v]
            SEALS.run_joker_update(v, dt, card, not center.mod)
        end
    end
end

local function find_matching_tables(effect, return_values)
    local matching_tables = {}
    if type(effect) == "table" then
        for key, _ in pairs(effect) do
            for table_name, sub_table in pairs(return_values) do
                for _, sub_value in pairs(sub_table) do
                    if key == sub_value then
                        table.insert(matching_tables, table_name)
                    end
                end
            end
        end
    end
    return matching_tables
end

if cryptidyeohna then
    local oldadvancedfindjoker = Cryptid.advanced_find_joker
    function Cryptid.advanced_find_joker(name, rarity, edition, ability, non_debuff, area)
        local jokers = oldadvancedfindjoker(name, rarity, edition, ability, non_debuff, area)
        if next(SMODS.find_card('j_soe_allinone')) then
            if name or rarity then
                for k, v in pairs(SMODS.find_card('j_soe_allinone')) do
                    table.insert(jokers, v)
                end
            end
        end
        if next(SMODS.find_card('j_soe_newinfinifusion')) then
            if name or rarity then
                for k, v in pairs(SMODS.find_card('j_soe_newinfinifusion')) do
                    for k, v in pairs(v.ability.extra.currentjokers) do
                        if G.P_CENTERS[v].rarity == rarity or G.P_CENTERS[v].name == name then
                            table.insert(jokers, v)
                            break
                        end
                    end
                end
            end
        end
        if (name or rarity) and G.jokers and G.jokers.cards then
            for k, v in pairs(G.jokers.cards) do
                for k, v in pairs(v.ability.soe_jokers or {}) do
                    if G.P_CENTERS[v].rarity == rarity or G.P_CENTERS[v].name == name then
                        table.insert(jokers, v)
                        break
                    end
                end
            end
        end
        return jokers
    end
end

local order = {"dollars", "chips", "mult", "xchips", "xmult", "echips", "emult", "eechips", "eemult", "eeechips", "eeemult", "hyperchips", "hypermult"}
local return_values = {
    mult = {"mult", "h_mult", "mult_mod"},
    chips = {"chips", "h_chips", "chip_mod"},
    xmult = {"x_mult", "x_mult_mod", "xmult", "xmult_mod", "Xmult", "Xmult_mod"},
    xchips = {"x_chips", "x_chip_mod", "xchips", "xchip_mod", "Xchips", "Xchip_mod"},
    emult = {"e_mult", "e_mult_mod", "emult", "emult_mod", "Emult", "Emult_mod"},
    echips = {"e_chips", "e_chip_mod", "echips", "echip_mod", "Echips", "Echip_mod"},
    eemult = {"ee_mult", "ee_mult_mod", "eemult", "eemult_mod", "EEmult", "EEmult_mod"},
    eechips = {"ee_chips", "ee_chip_mod", "eechips", "eechip_mod", "EEchips", "EEchip_mod"},
    eeemult = {"eee_mult", "eee_mult_mod", "eeemult", "eeemult_mod", "EEEmult", "EEEmult_mod"},
    eeechips = {"eee_chips", "eee_chip_mod", "eeechips", "eeechip_mod", "EEEchips", "EEEchip_mod"},
    hypermult = {"hyper_mult", "hyper_mult_mod", "hypermult", "hypermult_mod", "Hypermult", "Hypermult_mod"},
    hyperchips = {"hyper_chips", "hyper_chip_mod", "hyperchips", "hyperchip_mod", "Hyperchips", "Hyperchip_mod"},
}
local function sort_returns(effect)
    local sealsort = find_matching_tables(effect, return_values)
    for i, value in ipairs(order) do
        for _, seal in ipairs(sealsort) do
            if value == seal then
                return i
            end
        end
    end
    return -1
end

function SEALS.change_sprite(key, card, event)
    if event then
        G.E_MANAGER:add_event(Event({
            func = function()
                local center = G.P_CENTERS[key]
                local atlas = G.ASSET_ATLAS[center.atlas] or G.ASSET_ATLAS["Joker"]
                card.children.center.atlas = atlas
                card.children.center:set_sprite_pos(center.pos)
                if card.children.floating_sprite and type(card.children.floating_sprite) == "table" then
                    card.children.floating_sprite.atlas = atlas
                    if center.soul_pos then
                        card.children.floating_sprite:set_sprite_pos(center.soul_pos)
                    else
                        card.children.floating_sprite:set_sprite_pos({x = 1000, y = 1000})
                    end
                end
                if card.children.floating_sprite2 and type(card.children.floating_sprite2) == "table" then
                    card.children.floating_sprite2.atlas = atlas
                    if center.soul_pos and center.soul_pos.extra then
                        card.children.floating_sprite2:set_sprite_pos(center.soul_pos.extra)
                    else
                        card.children.floating_sprite2:set_sprite_pos({x = 1000, y = 1000})
                    end
                end
                return true
            end
        }))
    else
        local center = G.P_CENTERS[key]
        local atlas = G.ASSET_ATLAS[center.atlas] or G.ASSET_ATLAS["Joker"]
        card.children.center.atlas = atlas
        card.children.center:set_sprite_pos(center.pos)
        if card.children.floating_sprite and type(card.children.floating_sprite) == "table" then
            card.children.floating_sprite.atlas = atlas
            if center.soul_pos then
                card.children.floating_sprite:set_sprite_pos(center.soul_pos)
            else
                card.children.floating_sprite:set_sprite_pos({x = 1000, y = 1000})
            end
        end
        if card.children.floating_sprite2 and type(card.children.floating_sprite2) == "table" then
            card.children.floating_sprite2.atlas = atlas
            if center.soul_pos and center.soul_pos.extra then
                card.children.floating_sprite2:set_sprite_pos(center.soul_pos.extra)
            else
                card.children.floating_sprite2:set_sprite_pos({x = 1000, y = 1000})
            end
        end
    end
end

function SEALS.get_some_jokers_returns_combined(context, card, list)
    local effects_table = {}
    for k, v in pairs(list) do
        if type(v) == "table" and v.key then v = v.key end
        local center = G.P_CENTERS[v]
        local effect = SEALS.get_joker_return(v, context, card, not center.mod)
        if effect and type(effect) == 'table' and card.config.center.key == "j_soe_allinone" then
            effect.sealsfakekey = v
            effect.sealscard = card
            effect.func = function()
                card.ability.extra.currentjoker = G.P_CENTERS[v]
            end
        end
        if (effect and not effect.repetitions) or card.config.center.key ~= "j_soe_allinone" then
            effects_table[#effects_table+1] = effect
        end
        table.sort(effects_table, function(a, b)
            local a_sort = sort_returns(a)
            local b_sort = sort_returns(b)
            if a_sort == -1 and b_sort == -1 then return b_sort > a_sort end
            if a_sort == -1 then return true end
            if b_sort == -1 then return false end
            return a_sort < b_sort
        end)
    end
    return SEALS.recursive_extra(effects_table, 1)
end

function SEALS.run_joker_add_to_deck(key, from_debuff, card, isvanilla)
    local center = G.P_CENTERS[key]
    if center then
        local fake_card = SEALS.create_fake_card(card, key, "add_to_deck")
        if center.add_to_deck and type(center.add_to_deck) == "function" and not isvanilla then
            center:add_to_deck(fake_card, from_debuff)
        end
        if isvanilla then
            return SEALS.run_vanilla_joker_add_to_deck(key, from_debuff, fake_card)
        end
    end
end

function SEALS.run_joker_remove_from_deck(key, from_debuff, card, isvanilla)
    local center = G.P_CENTERS[key]
    if center then
        local fake_card = SEALS.create_fake_card(card, key, "remove_from_deck")
        if center.remove_from_deck and type(center.remove_from_deck) == "function" and not isvanilla then
            center:remove_from_deck(fake_card, from_debuff)
        end
        if isvanilla then
            return SEALS.run_vanilla_joker_remove_from_deck(key, from_debuff, fake_card)
        end
    end
end

function SEALS.run_joker_update(key, dt, card, isvanilla)
    local center = G.P_CENTERS[key]
    if center then
        local fake_card = SEALS.create_fake_card(card, key, "remove_from_deck")
        if center.update and type(center.update) == "function" and not isvanilla then
            center:update(fake_card, dt)
        end
        if isvanilla then
            return SEALS.run_vanilla_joker_update(key, dt, fake_card)
        end
    end
end

function SEALS.get_joker_return(key, context, card, isvanilla, juicecard)
    local center = G.P_CENTERS[key]
    if center then
        card.ability.savedvalues = card.ability.savedvalues or {}
        card.ability.savedvalues[key] = card.ability.savedvalues[key] or copy_table(center.config)
        local fake_card = SEALS.create_fake_card(card, key, "calculate", juicecard)
        if card.config.center.key == "j_soe_allinone" then
            card.ability.extra.currentjoker = center
        end
        if center.calculate and type(center.calculate) == "function" and not isvanilla then
            return center:calculate(fake_card, context), fake_card
        end
        if isvanilla then
            return SEALS.get_vanilla_joker_return(key, context, fake_card), fake_card
        end
    end
end

function SEALS.get_seal_return(key, context, card, isvanilla, juicecard)
    local center = G.P_SEALS[key]
    if center then
        card.ability.seal.savedvalues = card.ability.seal.savedvalues or {}
        card.ability.seal.savedvalues[key] = card.ability.seal.savedvalues[key] or copy_table(center.config)
        local fake_card = SEALS.create_fake_card(card, "c_base", "calculate", juicecard, true)
        if center.calculate and type(center.calculate) == "function" and not isvanilla then
            return center:calculate(fake_card, context), fake_card
        end
        if isvanilla then
            return SEALS.get_vanilla_joker_return(key, context, fake_card), fake_card
        end
    end
end

function SEALS.get_seal_dollars(key, card, isvanilla, juicecard)
    local center = G.P_SEALS[key]
    if center then
        card.ability.seal.savedvalues = card.ability.seal.savedvalues or {}
        card.ability.seal.savedvalues[key] = card.ability.seal.savedvalues[key] or copy_table(center.config)
        local fake_card = SEALS.create_fake_card(card, "c_base", "calculate", juicecard, true)
        if center.get_p_dollars and type(center.get_p_dollars) == "function" and not isvanilla then
            return center:get_p_dollars(fake_card), fake_card
        end
        if isvanilla then
            return SEALS.get_vanilla_joker_return(key, context, fake_card), fake_card
        end
    end
end

local oldcardevalstatustext = card_eval_status_text
function card_eval_status_text(card, eval_type, amt, percent, dir, extra)
    if card == nil then return nil end
    if card.sealsfakecard and card.sealsmessagecard then
        local oldcard = card
        card = card.sealsmessagecard
        local v = oldcard.config.center.key
        if card.config.center.key == "j_soe_allinone" then
            SEALS.change_sprite(v, card, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.extra.currentjoker = G.P_CENTERS[v]
                    return true
                end
            }))
        end
    end
    return oldcardevalstatustext(card, eval_type, amt, percent, dir, extra)
end

local oldsmodscalcindeff = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if effect.sealsfakekey and effect.sealscard then
        SEALS.change_sprite(effect.sealsfakekey, effect.sealscard, true)
    end
    return oldsmodscalcindeff(effect, scored_card, key, amount, from_edition)
end

G.FUNCS.soe_reroll_card = function(e)
    local card = e.config.ref_table
    ease_dollars(-card.config.center.reroll_cost)
    play_sound('other1')
    local jokers = {}
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        if v.key ~= card.config.center.key then
            table.insert(jokers, v.key)
        end
    end
    card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("raspberry"))
end

G.FUNCS.soe_can_reroll = function(e)
    if not ((G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) or (to_big(G.GAME.dollars) < to_big(e.config.ref_table.config.center.reroll_cost))) then
        e.config.colour = G.C.GREEN
        e.config.button = 'soe_reroll_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local retval = use_and_sell_buttonsref(card)

	if card.area and card.ability.set == 'Joker' and card.config.center.key == "j_soe_raspberryprint" then
		local fuse =
		{n=G.UIT.C, config={align = "cr"}, nodes={

		  {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, button = 'soe_reroll_card', func = 'soe_can_reroll'}, nodes={
			{n=G.UIT.B, config = {w=0.1,h=0.6}},
			{n=G.UIT.C, config={align = "tm"}, nodes={
				{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
					{n=G.UIT.T, config={text = localize('k_reroll'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
				}},
				{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
					{n=G.UIT.T, config={ref_table = card.config.center, ref_value = 'reroll_cost',colour = G.C.WHITE, scale = 0.55, shadow = true}}
				}}
			}}
		  }}
		}}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, fuse)
		return retval
	end

	return retval
end

SMODS.Joker{
    name = 'RaspberryPrint',
    key = 'raspberryprint',
    atlas = 'Prints',
    pos = {x = 0, y = 0},
    config = {extra = {}},
    rarity = 4,
    cost = 30,
    unlocked = true,
    discovered = true,
    reroll_cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    update = function (self, card, dt)
        card.children.center.atlas = G.ASSET_ATLAS["soe_Prints"]
        card.children.center:set_sprite_pos({x = 0, y = 0})
        card.config.center.demicoloncompat = G.P_CENTERS[card.ability.extra.currentjoker] and G.P_CENTERS[card.ability.extra.currentjoker].demicoloncompat or nil
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.currentjoker]
        return {vars = {SEALS.safe_get(G.localization.descriptions, "Joker", card.ability.extra.currentjoker or "ddfjvgbjbfjvbnfbcmvd", "name") or "Nothing"}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false then
            SMODS.calculate_effect({message = localize('k_reset')}, card)
            local jokers = {}
            for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                if v.key ~= self.key then
                    table.insert(jokers, v.key)
                end
            end
            card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("raspberry"))
        end
        return SEALS.get_joker_return(card.ability.extra.currentjoker, context, card, not G.P_CENTERS[card.ability.extra.currentjoker].mod)
    end,
    add_to_deck = function (self, card, from_debuff)
        local jokers = {}
        for k, v in pairs(G.P_CENTER_POOLS.Joker) do
            if not (v.mod and v.mod.id == "SealsOnEverything") then
                table.insert(jokers, v.key)
            end
        end
        card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("raspberry"))
    end
}

if JokerDisplay then
    JokerDisplay.Definitions['j_soe_raspberryprint'] = { -- Blueprint
        text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "copied_joker", colour = HEX("F2116A") },
            { text = ")" }
        },
        calc_function = function(card)
            card.joker_display_values.copied_joker = SEALS.safe_get(G.localization.descriptions, G.P_CENTERS[card.ability.extra.currentjoker] and G.P_CENTERS[card.ability.extra.currentjoker].set or "ddfjvgbjbfjvbnfbcmvd", card.ability.extra.currentjoker or "ddfjvgbjbfjvbnfbcmvd", "name") or "Nothing"
        end,
    }
end

SMODS.Joker{
    name = 'PurpureusPrint',
    key = 'purpureusprint',
    atlas = 'Prints',
    pos = {x = 1, y = 0},
    config = {extra = {}},
    rarity = 3,
    cost = 30,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.currentjoker]
        return {vars = {SEALS.safe_get(G.localization.descriptions, G.P_CENTERS[card.ability.extra.currentjoker] and G.P_CENTERS[card.ability.extra.currentjoker].set or "ddfjvgbjbfjvbnfbcmvd", card.ability.extra.currentjoker or "ddfjvgbjbfjvbnfbcmvd", "name") or "Nothing"}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false then
            SMODS.calculate_effect({message = localize('k_reset')}, card)
            local jokers = {}
            for k, v in pairs(G.P_CENTER_POOLS.Tarot_Planet) do
                    table.insert(jokers, v.key)
            end
            card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("purpureus"))
        end
        if context.joker_main or context.forcetrigger then
            local fake_card = SEALS.create_fake_card(card, card.ability.extra.currentjoker, "use", nil, nil, true, true)
            if cryptidyeohna then
                return Cryptid.forcetrigger(fake_card, context)
            else
                local thunk = G.GAME.probabilities.normal
                G.GAME.probabilities.normal = 1e9
                local effect = fake_card:use_consumeable()
    			G.GAME.probabilities.normal = thunk
                return effect
            end
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        local jokers = {}
        for k, v in pairs(G.P_CENTER_POOLS.Tarot_Planet) do
            table.insert(jokers, v.key)
        end
        card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("purpureus"))
    end
}

SMODS.Joker{
    name = 'AmazonPrint',
    key = 'amazonprint',
    atlas = 'Prints',
    pos = {x = 2, y = 0},
    config = {extra = {}},
    rarity = 3,
    cost = 30,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.currentjoker]
        return {vars = {SEALS.safe_get(G.localization.descriptions, "Voucher", card.ability.extra.currentjoker or "ddfjvgbjbfjvbnfbcmvd", "name") or "Nothing"}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false then
            SMODS.calculate_effect({message = localize('k_reset')}, card)
            local jokers = {}
            for k, v in pairs(G.P_CENTER_POOLS.Voucher) do
                table.insert(jokers, v.key)
            end
            card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("raspberry"))
        end
        return SEALS.get_joker_return(card.ability.extra.currentjoker, context, card, not G.P_CENTERS[card.ability.extra.currentjoker].mod)
    end,
    add_to_deck = function (self, card, from_debuff)
        local jokers = {}
        for k, v in pairs(G.P_CENTER_POOLS.Joker) do
            if v.key ~= self.key then
                table.insert(jokers, v.key)
            end
        end
        card.ability.extra.currentjoker = pseudorandom_element(jokers, pseudoseed("raspberry"))
    end
}

SMODS.Joker{
    key = 'newinfinifusion',
    atlas = 'JokerEnhancements',
    pos = {x = 9, y = 9},
    soul_pos = {x = 1000, y = 1000},
    config = {extra = {currentjokers = {}}},
    rarity = 4,
    cost = 1000,
    no_collection = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    update = function (self, card, dt)
        card:set_eternal(true)
        card.children.center.pinch.x = false
        if card.children.floating_sprite.atlas ~= G.ASSET_ATLAS["soe_Enhancers"] then
            card.children.floating_sprite.atlas = G.ASSET_ATLAS["soe_Enhancers"]
            card.children.floating_sprite:set_sprite_pos({x = 5, y = 3})
            card.children.center:set_sprite_pos({x = 9, y = 9})
        end
        if card.ability.extra.currentjokers then
            for k, v in pairs(card.ability.extra.currentjokers) do
                if v.key then v = v.key end
                local center = G.P_CENTERS[v]
                SEALS.run_joker_update(v, dt, card, not center.mod)
            end
        end
    end,
    loc_vars = function (self, info_queue, card)
        for k, v in pairs(card.ability.extra.currentjokers) do
            local center = G.P_CENTERS[v]
            --info_queue[#info_queue+1] = {key = center.key, set = center.set, specific_vars = card.ability.savedvalues[v]}
            info_queue[#info_queue+1] = center
        end
    end,
    calculate = function(self, card, context)
        return SEALS.get_some_jokers_returns_combined(context, card, card.ability.extra.currentjokers)
    end,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker{
    name = 'AllInOne',
    key = 'allinone',
    atlas = 'Placeholders',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1000, y = 1000, extra = {x = 1000, y = 1000}},
    config = {extra = {}},
    rarity = 4,
    cost = 1000,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    update = function (self, card, dt)
        --card:set_eternal(true)
        card.children.center.pinch.x = false
        ---SEALS.become_all_jokers_theoretically(nil, card, "update", dt)
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = card.ability.extra.currentjoker
    end,
    calculate = function(self, card, context)
        card.ability.soe_jokers = SEALS.get_allinone_jokers()
        --return SEALS.become_all_jokers_theoretically(context, card, "calculate")
    end,
    --[[
    remove_from_deck = function (self, card, from_debuff)
        SEALS.become_all_jokers_theoretically(nil, card, "remove_from_deck")
    end,
    ]]
    add_to_deck = function (self, card, from_debuff)
        card.ability.soe_jokers = SEALS.get_allinone_jokers()
        --SEALS.become_all_jokers_theoretically(nil, card, "add_to_deck")
    end,
    in_pool = function(self, args)
        return false
    end
}

--[[
SMODS.Seal{
    key = 'allinoneseal',
    name = 'AllInOneSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {},
    loc_txt = {
        name = "All In One Seal",
        text = {
            "All In One Seal",
        }
    },
    calculate = function (self, card, context)
        local effects_table = {}
        for k, v in pairs(G.P_SEALS) do
            if v.key == "fam_maroon_seal" then
                effects_table[#effects_table+1] = SEALS.get_seal_return(v.key, context, card, not v.mod)
            end
        end
        table.sort(effects_table, function(a, b)
            local a_sort = sort_returns(a)
            local b_sort = sort_returns(b)
            if a_sort == -1 and b_sort == -1 then return b_sort > a_sort end
            if a_sort == -1 then return true end
            if b_sort == -1 then return false end
            return a_sort < b_sort
        end)
        return SEALS.recursive_extra_for_non_jokers(effects_table, 1)
    end,
    get_p_dollars = function (self, card)
        local dollars = 0
        for k, v in pairs(G.P_SEALS) do
            if v.mod then
                dollars = dollars + SEALS.get_seal_dollars(v.key, card)
            end
        end
        return dollars
    end
}
]]

SMODS.Enhancement{
    key = "allinoneenhancement",
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        local effects_table = {}
        for k, v in pairs(G.P_CENTER_POOLS.Enhanced) do
            if v.mod then
                local effect = SEALS.get_joker_return(v.key, context, card, not v.mod)
                if effect and type(effect) == 'table' then
                    effects_table[#effects_table+1] = effect
                end
            end
        end
        table.sort(effects_table, function(a, b)
            local a_sort = sort_returns(a)
            local b_sort = sort_returns(b)
            if a_sort == -1 and b_sort == -1 then return b_sort > a_sort end
            if a_sort == -1 then return true end
            if b_sort == -1 then return false end
            return a_sort < b_sort
        end)
        return SEALS.recursive_extra(effects_table, 1)
    end
}

--[[
SMODS.Joker{
    name = 'SomeInOne',
    key = 'someinone',
    atlas = 'Placeholders',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1000, y = 1000, extra = {x = 1000, y = 1000}},
    config = {extra = {jokerkeys = {}}},
    rarity = 4,
    cost = 1000,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function (self, info_queue, card)
        if #card.ability.extra.jokerkeys > 0 then
            for k, v in pairs(card.ability.extra.jokerkeys) do
                info_queue[#info_queue+1] = G.P_CENTERS[v]
            end
        end
    end,
    calculate = function(self, card, context)
        return SEALS.get_some_jokers_returns_combined(context, card, card.ability.extra.jokerkeys)
    end
}
]]

--[[
if SEALS.find_mod("aikoyorisshenanigans") then
    SMODS.Joker{
        key = 'playingcardjokersactivator',
        atlas = 'Placeholders',
        pos = {x = 0, y = 0},
        rarity = 1,
        cost = 5,
        unlocked = true,
        unique = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = true,
        config = {extra = {}},
        loc_txt = {
            name = 'Playing Card Joker Activator',
            text = {
                "If a scoring card is a Joker,",
                "trigger it"
            }
        },
        update = function (self, card, dt)
            card.debuff = nil
        end,
        calculate = function (self, card, context)
            if not context.blueprint and context.scoring_hand and not context.retrigger_joker then
                local effects_table = {}
                for k, v in pairs(context.scoring_hand) do
                    if not v.debuff and v.ability.set == "Joker" then
                        local effect, fake_card = SEALS.get_joker_return(v.config.center.key, context, card, not v.config.center.mod, v)
                        if cryptidyeohna and context.individual and context.other_card == v and Cryptid.demicolonGetTriggerable(fake_card)[1] then
                            local results = Cryptid.forcetrigger(fake_card, context)
                            if results and results.jokers then effects_table[#effects_table+1] = results.jokers end 
                        end
                        if effect and type(effect) == 'table' then
                            effect.message_card = effect.message_card or effect.card or context.other_card or v
                        end
                        effects_table[#effects_table+1] = effect
                    end
                end
                return SEALS.recursive_extra(effects_table, 1)
            end
        end,
        in_pool = function(self)
            return false
        end
    }
    SMODS.Back{
        key = 'jokerdeck',
        name = 'JokerDeck',
        loc_txt = {
            name = 'Joker Deck',
            text = {
                'Start run with',
                '{C:attention}52 Jokers{}',
            }
        },
        apply = function(self, back)
            G.E_MANAGER:add_event(Event({
                func = function()
                    if not G.playing_cards then return false end
                    for i=#G.playing_cards, 1, -1 do
                        G.playing_cards[i].getting_sliced = true
                        G.playing_cards[i]:remove()
                    end
                    for i=1, 52 do
                        local card = SMODS.add_card({set = 'Joker', no_edition = true, area = G.deck})
                        card:set_edition(nil, true, true)
                        table.insert(G.playing_cards, card)
                    end
                    local card2 = SMODS.add_card({key = "j_soe_playingcardjokersactivator", edition = "e_negative"})
                    SMODS.Stickers["akyrs_sigma"]:apply(card2, true)
                    return true
                end
            }))
        end
    }
    if G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_jokerdeck' then
        SMODS.Suits["akyrs_joker"].in_pool = function(self)
            return true
        end
    end
end
]]

SMODS.Keybind{
    key_pressed = ']',
    event = 'pressed',
    action = function(self)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 2 then
            local nonfinifusionjokers, infinifusionjokers = {}, {}
            for k, v in pairs(G.jokers.highlighted) do
                if v.config.center.key ~= 'j_soe_newinfinifusion' then
                    table.insert(nonfinifusionjokers, v)
                else
                    table.insert(infinifusionjokers, v)
                end
            end
            if not next(infinifusionjokers) then
                play_sound('explosion_release1')
                local card = SMODS.add_card({key = "j_soe_newinfinifusion", no_edition = true})
                card:set_edition(nil, true, true)
                for k, v in pairs(nonfinifusionjokers) do
                    table.insert(card.ability.extra.currentjokers, v.config.center.key)
                    v:remove()
                end
            else
                if #infinifusionjokers == 1 then
                    play_sound('explosion_release1')
                    local card = infinifusionjokers[1]
                    for k, v in pairs(nonfinifusionjokers) do
                        table.insert(card.ability.extra.currentjokers, v.config.center.key)
                        v:remove()
                    end
                elseif #infinifusionjokers == 2 then
                    play_sound('explosion_release1')
                    local card = infinifusionjokers[1]
                    for k, v in pairs(infinifusionjokers) do
                        if v ~= card then
                            for kk, vv in pairs(v.ability.extra.currentjokers) do
                                table.insert(card.ability.extra.currentjokers, vv)
                            end
                            v:remove{}
                        end
                    end
                else
                    sendInfoMessage("Quite the conundrum, wouldn't you say?", "SEALS")
                end
            end
        end
    end
}