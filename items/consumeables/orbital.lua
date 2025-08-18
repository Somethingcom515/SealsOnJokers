SMODS.ConsumableType{
    key = "soe_Orbital",
    primary_colour = HEX("A2334C"),
    secondary_colour = HEX("A2334C"),
    collection_rows = { 6, 6 },
    default = "c_soe_degrade",
    shop_rate = 0,
    can_stack = true,
    can_divide = true,
    inject_card = function(self, center)
        SMODS.ObjectType.inject_card(self, center)
        SMODS.insert_pool(G.P_CENTER_POOLS['soe_Synonyms'], center)
    end,
    delete_card = function(self, center)
        SMODS.ObjectType.delete_card(self, center)
        SMODS.remove_pool(G.P_CENTER_POOLS['soe_Synonyms'], center.key)
    end,
}

function G.UIDEF.joker_hands()
    local t =
    {
        n = G.UIT.ROOT,
        config = { align = "cm", colour = G.C.CLEAR },
        nodes = {
            { n = G.UIT.O, config = { object = DynaText({ string = { "Work In Progress!" }, colours = { G.C.UI.TEXT_LIGHT }, bump = true, scale = 0.6 }) } }
        }
    }
    return t
end

function SEALS.level_up_joker_hand(card, hand, instant, amount)
    amount = amount or 1
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(hand, 'soe_joker_hands'),chips = G.GAME.soe_joker_hands[hand].chips, mult = G.GAME.soe_joker_hands[hand].mult, level=G.GAME.soe_joker_hands[hand].level})
    G.GAME.soe_joker_hands[hand].level = math.max(0, G.GAME.soe_joker_hands[hand].level + amount)
    G.GAME.soe_joker_hands[hand].mult = math.max(G.GAME.soe_joker_hands[hand].s_mult + G.GAME.soe_joker_hands[hand].l_mult*(G.GAME.soe_joker_hands[hand].level - 1), 1)
    G.GAME.soe_joker_hands[hand].chips = math.max(G.GAME.soe_joker_hands[hand].s_chips + G.GAME.soe_joker_hands[hand].l_chips*(G.GAME.soe_joker_hands[hand].level - 1), 0)
    if not instant then 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.soe_joker_hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.soe_joker_hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.soe_joker_hands[hand].level})
        delay(1.3)
    end
    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, vals_after_level or {mult = 0, chips = 0, handname = '', level = ''})
end

local oldsmodscalccontext = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    if context.soe_calcjokerhands and G.GAME.soe_joker_hands_available then
        for k, v in pairs(context.soe_joker_hands) do
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=v, level=G.GAME.soe_joker_hands[k].level})
            delay(0.9)
            update_hand_text({sound = 'chips1', delay = 0}, {chips = (hand_chips or 0) + G.GAME.soe_joker_hands[k].chips, StatusText = true})
            hand_chips = (hand_chips or 0) + G.GAME.soe_joker_hands[k].chips
            delay(0.9)
            update_hand_text({sound = 'multhit1', delay = 0}, {mult = (mult or 0) + G.GAME.soe_joker_hands[k].mult, StatusText = true})
            mult = (mult or 0) + G.GAME.soe_joker_hands[k].mult
            delay(0.9)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, vals_after_level or {handname = context.scoring_name, level = G.GAME.hands[context.scoring_name].level})
            delay(1)
        end
    end
    return oldsmodscalccontext(context, return_table)
end

G.FUNCS.can_calc_joker_hands = function(e)
    if G.GAME.soe_joker_hands_available then
        e.states.button = "calc_joker_hands"
    else
        e.states.button = nil
    end
end

G.FUNCS.calc_joker_hands = function(e)
    local hands = SEALS.evaluate_joker_hands(G.jokers.cards) or {}
    sendInfoMessage("Here are your currently active joker hands:", "SEALS")
    for k, v in pairs(hands) do
        sendInfoMessage(v, "SEALS")
    end
end

local oldinitgameobject = Game.init_game_object
function Game:init_game_object()
    local ret = oldinitgameobject(self)
    ret.soe_joker_hands = {
        ["soe_simple_jimbo"] = {jokers = {"j_joker"}},
        ["soe_best_brothers"] = {jokers = {"j_odd_todd", "j_even_steven"}},
    }
    for k, v in pairs(ret.soe_joker_hands) do
        v.level = 1
        v.l_chips = 3
        v.l_mult = 3
        v.chips = 2
        v.mult = 1
        v.s_chips = 2
        v.s_mult = 1
        v.visible = true
    end
    ret.soe_reroll_discount_percent = 0
    return ret
end

SEALS.find_card_in_area = function(key, area)
    for k, v in pairs(area) do
        if v.config.center.key == key then
            return true
        end
    end
    return false
end

function SEALS.evaluate_joker_hands(jokers)
    if not jokers or not G.GAME or not G.GAME.soe_joker_hands then return nil end
    local hands = {}
    for k, v in pairs(G.GAME.soe_joker_hands) do
        local check = 0
        if v.evaluate and type(v.evaluate) == 'function' then
            if v.evaluate(jokers) then
                hands[k] = localize(k, 'soe_joker_hands')
            end
        elseif v.jokers then
            for kk, vv in pairs(v.jokers) do
                if SEALS.find_card_in_area(vv, jokers) then
                    check = check + 1
                end
            end
            if check == #v.jokers then
                hands[k] = localize(k, 'soe_joker_hands')
            end
        end
    end
    return hands
end

SMODS.Consumable{
    key = 'degrade',
    set = 'soe_Orbital',
    atlas = 'Synonyms',
    pos = {x = 8, y = 3},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_pluto',
    config = {joker_hand_type = "soe_simple_jimbo"},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("soe_simple_jimbo", "soe_joker_hands"),
                G.GAME.soe_joker_hands["soe_simple_jimbo"].level,
                G.GAME.soe_joker_hands["soe_simple_jimbo"].l_mult,
                G.GAME.soe_joker_hands["soe_simple_jimbo"].l_chips,
				colours = {
					(
						to_big(G.GAME.soe_joker_hands["soe_simple_jimbo"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.soe_joker_hands["soe_simple_jimbo"].level)):to_number()]
					),
				},
			},
		}
	end,
    use = function (self, card, area, copier)
        SEALS.level_up_joker_hand(card, "soe_simple_jimbo")
    end,
    can_use = function (self, card)
        return true
    end,
}