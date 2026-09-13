--[[
SMODS.Voucher{
    key = 'orbitalconnoisseur',
    cost = 10,
    atlas = 'VoucherSynonyms',
    pos = {x = 2, y = 0},
    unlocked = true,
    discovered = true,
    redeem = function()
        G.soe_jokerhandsbutton.states.visible = true
        G.soe_jokerhandsbutton.states.click.can = true
        G.GAME.soe_joker_hands_available = true
        G.GAME.soe_orbital_rate = 2
    end,
    unredeem = function()
        G.soe_jokerhandsbutton.states.visible = false
        G.soe_jokerhandsbutton.states.click.can = false
        G.GAME.soe_joker_hands_available = false
        G.GAME.soe_orbital_rate = 0
    end
}
]]

local oldinitgameobject = Game.init_game_object
function Game.init_game_object(...)
    local g = oldinitgameobject(...)
    g.soe_reroll_discount_percent = 0
    return g
end

local fl = math.floor
local oldcalculatererollcost = calculate_reroll_cost
function calculate_reroll_cost(...)
    oldcalculatererollcost(...)
    if G.GAME.soe_reroll_discount_percent > 0 then
        G.GAME.current_round.reroll_cost = math.max(0, fl((G.GAME.current_round.reroll_cost + 0.5)*(100-G.GAME.soe_reroll_discount_percent)/100))
    end
end

SMODS.Voucher{
    key = 'rerolloverflow',
    cost = 10,
    atlas = 'VoucherSynonyms',
    pos = {x = 0, y = 2},
    unlocked = true,
    discovered = true,
    config = {extra = {discount = 25}},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.discount}}
    end,
    redeem = function(_, voucher)
        voucher.ability.extra.thunk = G.GAME.soe_reroll_discount_percent
        G.GAME.soe_reroll_discount_percent = voucher.ability.extra.discount
        calculate_reroll_cost(true)
    end,
    unredeem = function(_, voucher)
        G.GAME.soe_reroll_discount_percent = voucher.ability.extra.thunk
        calculate_reroll_cost(true)
    end
}

SMODS.Voucher{
    key = 'legerdemain',
    cost = 10,
    atlas = 'VoucherSynonyms',
    pos = {x = 4, y = 2},
    unlocked = true,
    discovered = true,
}

SMODS.Voucher{
    key = 'phantasm',
    cost = 10,
    atlas = 'VoucherSynonyms',
    pos = {x = 4, y = 3},
    requires = {'v_soe_legerdemain'},
    unlocked = true,
    discovered = true,
}

SMODS.Voucher{
    key = 'deception',
    cost = 10,
    atlas = 'Vouchers',
    pos = {x = 8, y = 0},
    requires = {'v_soe_legerdemain', 'v_soe_phantasm'},
    unlocked = true,
    discovered = true,
}