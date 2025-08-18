SMODS.ConsumableType{
    key = "soe_Vice",
    primary_colour = HEX("2D5E5A"),
    secondary_colour = HEX("2D5E5A"),
    collection_rows = { 6, 6 },
    can_stack = true,
    can_divide = true,
    default = "c_idiot",
    inject_card = function(self, center)
        SMODS.ObjectType.inject_card(self, center)
        SMODS.insert_pool(G.P_CENTER_POOLS['soe_Synonyms'], center)
    end,
    delete_card = function(self, center)
        SMODS.ObjectType.delete_card(self, center)
        SMODS.remove_pool(G.P_CENTER_POOLS['soe_Synonyms'], center.key)
    end,
}

local oldsellcard = Card.sell_card
function Card:sell_card()
    local g = oldsellcard(self)
    if self.ability.set == "Joker" then
        G.GAME.soe_last_sold_joker = self.config.center.key
    end
    return g
end

SMODS.Consumable {
    key = 'idiot',
    set = 'soe_Vice',
    pos = { x = 0, y = 0 },
    atlas = 'Synonyms',
    soe_alternative = 'c_fool',
    loc_vars = function(self, info_queue, card)
        local fool_c = G.GAME.soe_last_sold_joker and G.P_CENTERS[G.GAME.soe_last_sold_joker] or nil
        local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or
            localize('k_none')
        local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN

        if not (not fool_c or fool_c.name == 'The Fool') then
            info_queue[#info_queue + 1] = fool_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_tarot_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_tarot_planet }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.jokers.config.card_limit > #G.jokers.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.soe_last_sold_joker, area = G.jokers })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers.config.card_limit > #G.jokers.cards and G.GAME.soe_last_sold_joker
    end
}

SMODS.Consumable {
    key = 'governor',
    set = 'soe_Vice',
    atlas = 'Synonyms',
    pos = { x = 4, y = 0 },
    soe_alternative = 'c_emperor',
    config = {extra = {key = ""}},
    use = function(self, card, area, copier)
        for i = 1, 2 do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    if i == 1 then
                        local _card = SMODS.add_card({set = 'soe_Synonyms'})
                        card.ability.extra.key = _card.config.center.soe_alternative
                    elseif i == 2 then
                        SMODS.add_card({key = card.ability.extra.key})
                    end
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables and (#G.consumeables.cards + (card.area == G.consumeables and 0 or 1)) < G.consumeables.config.card_limit
    end
}

SMODS.Consumable {
    key = 'energy',
    set = 'soe_Vice',
    atlas = 'Synonyms',
    soe_alternative = 'c_strength',
    pos = { x = 1, y = 1 },
    config = { max_highlighted = 1, extra = { jokeradd = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.extra.jokeradd, card.ability.max_highlighted ~= 1 and 'Jokers' or 'Joker' } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.jokers.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    SEALS.modify_joker_values(G.jokers.highlighted[i], {["+"] = card.ability.extra.jokeradd}, {x_mult = 1, x_chips = 1, h_size = 0, extra_value = true, cry_prob = true, d_size = 0})
                    return true
                end
            }))
        end
        for i = 1, #G.jokers.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.jokers:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        if G.jokers and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.max_highlighted then
            for k, v in pairs(G.jokers.highlighted) do
                if v.config.center.immutable then
                    return false
                end
            end
            return true
        end
        return false
    end
}

SMODS.Consumable {
    key = 'gallowsbird',
    set = 'soe_Vice',
    atlas = 'Synonyms',
    pos = { x = 2, y = 1 },
    soe_alternative = 'c_hanged_man',
    config = {max_highlighted = 2, min_highlighted = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.max_highlighted}}
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                for k, v in pairs(G.jokers.highlighted) do
                    v:soe_no_touching2()
                end
                return true
            end
        }))
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted >= card.ability.min_highlighted and #G.jokers.highlighted <= card.ability.max_highlighted
    end
}

SMODS.Consumable{
    key = 'murder',
    set = 'soe_Vice',
    atlas = 'Synonyms',
    pos = {x = 3, y = 1},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_death',
    config = {max_highlighted = 2, min_highlighted = 2},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted >= card.ability.min_highlighted and #G.jokers.highlighted <= card.ability.max_highlighted
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.jokers.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        local rightmost = G.jokers.highlighted[1]
        for i = 1, #G.jokers.highlighted do
            if G.jokers.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.jokers.highlighted[i]
            end
        end
        for i = 1, #G.jokers.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.jokers.highlighted[i] ~= rightmost then
                        copy_card(rightmost, G.jokers.highlighted[i])
                    end
                    return true
                end
            }))
        end
        for i = 1, #G.jokers.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.jokers:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}