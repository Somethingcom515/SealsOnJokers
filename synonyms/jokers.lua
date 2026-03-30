SMODS.Rarity{
    key = 'basic',
    default_weight = 0.7,
    badge_colour = HEX('910138'),
    pools = {Joker = true},
    get_weight = function()
        return 0
    end,
}

SMODS.Rarity{
    key = 'unusual',
    default_weight = 0.25,
    badge_colour = HEX('652772'),
    pools = {Joker = true},
    get_weight = function()
        return 0
    end,
}

SMODS.Rarity{
    key = 'unique',
    default_weight = 0.05,
    badge_colour = HEX('02BF39'),
    pools = {Joker = true},
    get_weight = function()
        return 0
    end,
}

SMODS.Rarity{
    key = 'fabled',
    default_weight = 0,
    badge_colour = HEX('6B7335'),
    pools = {Joker = true},
    get_weight = function()
        return 0
    end,
}

SMODS.Joker{
    key = 'jokester',
    atlas = 'JokerSynonyms',
    rarity = 'soe_basic',
    cost = 2,
    unlocked = true,
    discovered = true,
    config = {extra = {dollars = 4}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    calculate = function(_, card, context)
        if context.joker_main then
            return {dollars = card.ability.extra.dollars}
        end
    end
}

for i, v in ipairs({{key = 'avaricious', suit = 'Diamonds'}, {key = 'concupiscent', suit = 'Hearts'}, {key = 'infuriated', suit = 'Spades'}, {key = 'edacious', suit = 'Clubs'}}) do
    SMODS.Joker{
        key = v.key..'jokester',
        atlas = 'JokerSynonyms',
        pos = {x = 5+i, y = 1},
        rarity = 'soe_basic',
        cost = 5,
        unlocked = true,
        discovered = true,
        config = {extra = {suit = v.suit, dollars = 3}},
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        loc_vars = function(_, _, card)
            return {vars = {card.ability.extra.dollars}}
        end,
        calculate = function(_, card, context)
            if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit(card.ability.extra.suit) then
                return {dollars = card.ability.extra.dollars}
            end
        end
    }
end

for _, v in ipairs({'disable', 'defeat', 'press_play', 'debuff_card', 'debuff_hand', 'stay_flipped'}) do
    local old = Blind[v]
    Blind[v] = function(self, a, ...)
        G.soe_current_evaluated_blind = {v, self}
        local g = old(self, a, ...)
        if G.GAME.round_resets.soe_mergedblinds then
            local soe_mergedblinds = G.GAME.round_resets.soe_mergedblinds[G.GAME.blind_on_deck]
            if soe_mergedblinds[1] then
                for _, v in ipairs(soe_mergedblinds) do
                    local center = G.P_BLINDS[v]
                    local old_effect, old_center, old_name, old_debuff = copy_table(self.effect), self.config.blind, self.name, self.debuff
                    self.effect, self.config.blind, self.name, self.debuff = center.config and type(center.config) == 'table' and copy_table(center.config) or {}, center, center.name, center.debuff
                    if v == 'debuff_card' then
                        if not a.debuffed_by_blind then old(self, a, ...) end
                    else
                        local other_g = old(self, a, ...)
                        g = g or other_g
                    end
                    self.effect, self.config.blind, self.name, self.debuff = old_effect, old_center, old_name, old_debuff
                end
            end
        end
        G.soe_current_evaluated_blind = nil
        return g
    end
end

local oldblindsetblind = Blind.set_blind
function Blind:set_blind(blind, reset, ...)
    G.soe_current_evaluated_blind = {'set_blind', self}
    oldblindsetblind(self, blind, reset, ...)
    if blind and not reset and G.GAME.round_resets.soe_mergedblinds then
        local soe_mergedblinds = G.GAME.round_resets.soe_mergedblinds[G.GAME.blind_on_deck]
        if soe_mergedblinds[1] then
            for _, v in ipairs(soe_mergedblinds) do
                local center = G.P_BLINDS[v]
                if center.set_blind and type(center.set_blind) == 'function' then
                    center:set_blind()
                elseif center.name == 'The Eye' then
                    self.hands = {}
                elseif center.name == 'The Fish' then
                    self.prepped = nil
                elseif center.name == 'The Water' then
                    self.discards_sub = G.GAME.current_round.discards_left
                    ease_discard(-self.discards_sub)
                elseif center.name == 'The Needle' then
                    self.hands_sub = G.GAME.round_resets.hands-1
                    ease_hands_played(-self.hands_sub)
                elseif center.name == 'The Manacle' then
                    G.hand:change_size(-1)
                elseif center.name == 'Amber Acorn' and G.jokers.cards[1] then
                    G.jokers:unhighlight_all()
                    for _, vv in ipairs(G.jokers.cards) do
                        vv:flip()
                    end
                    if G.jokers.cards[2] then
                        G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function()
                            G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 0.85);return true end }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1.15);return true end }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1);return true end }))
                            delay(0.5)
                        return true end }))
                    end
                end
            end
        end
    end
    G.soe_current_evaluated_blind = nil
end

local oldblindmodifyhand = Blind.modify_hand
function Blind:modify_hand(a, b, c, mult, hand_chips, ...)
    G.soe_current_evaluated_blind = {'modify_hand', self}
    local modded
    mult, hand_chips, modded = oldblindmodifyhand(self, a, b, c, mult, hand_chips, ...)
    if G.GAME.round_resets.soe_mergedblinds then
        local soe_mergedblinds = G.GAME.round_resets.soe_mergedblinds[G.GAME.blind_on_deck]
        if soe_mergedblinds[1] then
            for _, v in ipairs(soe_mergedblinds) do
                local center = G.P_BLINDS[v]
                local old_effect, old_center, old_name, old_debuff = copy_table(self.effect), self.config.blind, self.name, self.debuff
                self.effect, self.config.blind, self.name, self.debuff = center.config and type(center.config) == 'table' and copy_table(center.config) or {}, center, center.name, center.debuff
                local other_modded
                mult, hand_chips, other_modded = oldblindmodifyhand(self, a, b, c, mult, hand_chips, ...)
                modded = modded or other_modded
                self.effect, self.config.blind, self.name, self.debuff = old_effect, old_center, old_name, old_debuff
            end
        end
    end
    G.soe_current_evaluated_blind = nil
    return mult, hand_chips, modded
end

local fix_context = SEALS.fix_context
G.soe_apophenia_cache = {}
local oldisface = Card.is_face
function Card:is_face(from_boss)
    local g = oldisface(self, from_boss)
    if not g or not SMODS.find_card('j_soe_apophenia')[1] or (self.debuff and not from_boss) or G.soe_from_face_check then return g end
    local object, card, blind = SMODS.current_evaluated_object, G.soe_current_updated_card, G.soe_current_evaluated_blind
    if object then
        local identifier = 'soe_evaluated_card_'..object.ID..STR_PACK(fix_context(SMODS.context_stack[#SMODS.context_stack].context))
        if G.soe_apophenia_cache[identifier] ~= nil then
            return G.soe_apophenia_cache[identifier]
        else
            local cache = not SEALS.get_line_from_function(3):match('not.*%s*:%s*is_face%s*%(')
            G.soe_apophenia_cache[identifier] = cache
            return cache
        end
    elseif card then
        local identifier = 'soe_updated_card_'..card.ID
        if G.soe_apophenia_cache[identifier] ~= nil then
            return G.soe_apophenia_cache[identifier]
        else
            local cache = not SEALS.get_line_from_function(3):match('not.*%s*:%s*is_face%s*%(')
            G.soe_apophenia_cache[identifier] = cache
            return cache
        end
    elseif blind then
        local identifier = 'soe_evaluated_blind_'..blind[2].ID..blind[1]
        if G.soe_apophenia_cache[identifier] ~= nil then
            return G.soe_apophenia_cache[identifier]
        else
            local cache = not SEALS.get_line_from_function(3):match('not.*%s*:%s*is_face%s*%(')
            G.soe_apophenia_cache[identifier] = cache
            return cache
        end
    end
    return not SEALS.get_line_from_function(3):match('not.*%s*:%s*is_face%s*%(')
end

SMODS.Joker{
    key = 'apophenia',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_pareidolia.pos,
    rarity = 'soe_unusual',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
}

SMODS.Joker{
    key = 'ballnote',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_baseball.pos,
    rarity = 'soe_unique',
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(_, _, context)
        if context.retrigger_joker_check and context.other_card.is_rarity and context.other_card:is_rarity('soe_unusual') then
            return {repetitions = 1}
        end
    end
}

local oldsmodsscalecard = SMODS.scale_card
function SMODS.scale_card(card, args)
    if card.config.center.soe_frozen_immune or not (card.edition and card.edition.soe_frozen) then
        return oldsmodsscalecard(card, args)
    end
end

SMODS.Joker{
    key = 'water',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_diet_cola.pos,
    rarity = 'soe_unusual',
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_soe_frozen
    end,
    calculate = function(_, card, context)
        if context.selling_self then
            local other_joker = G.jokers.cards[card.rank+1]
            if other_joker and other_joker.ability.set == 'Joker' and not (other_joker.edition and other_joker.edition.soe_frozen) then
                other_joker:set_edition('e_soe_frozen')
                return {message = 'Frozen!', colour = HEX('17B4E8')}
            end
        end
    end
}

SMODS.Joker{
    key = 'cheerfulexpression',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_smiley.pos,
    rarity = 'soe_basic',
    cost = 4,
    unlocked = true,
    discovered = true,
    config = {extra = {dollars = 5}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    calculate = function(_, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and SEALS.face_check(context.other_card, true) then
            return {dollars = card.ability.extra.dollars}
        end
    end
}

SMODS.Joker{
    key = 'redfabric',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_blueprint.pos,
    rarity = 'soe_unique',
    cost = 10,
    unlocked = true,
    discovered = true,
    config = {extra = {jokers = {}}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    soe_frozen_immune = true,
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'soe_redfabric', set = 'Other'}
    end,
    calculate = function(self, card, context)
        local effects, jokers, other_joker = {}, card.ability.extra.jokers, G.jokers.cards[card.rank+1]
        if other_joker and context.end_of_round and context.main_eval and other_joker.config.center_key ~= self.key then
            jokers[#jokers+1] = other_joker.config.center_key
            SEALS.copy_card_but_not(card, other_joker.config.center_key).ability = copy_table(other_joker.ability)
            effects[#effects+1] = {message = localize('k_copied_ex'), colour = G.C.RED}
        end
        if jokers[1] then
            local joker_effects = SEALS.calculate_quantum_jokers(card, context, jokers)
            if joker_effects then
                effects[#effects+1] = joker_effects
            end
        end
        if effects[1] then
            return SMODS.merge_effects(effects)
        end
    end
}

SMODS.Joker{
    key = 'what',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_oops.pos,
    rarity = 'soe_unusual',
    cost = 4,
    unlocked = true,
    discovered = true,
    config = {extra = {prob_mod = 1, cards = 5, count = 0, prob = 0}},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.prob_mod, card.ability.extra.cards, card.ability.extra.cards-card.ability.extra.count, card.ability.extra.prob}}
    end,
    calculate = function(_, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            card.ability.extra.count = card.ability.extra.count + 1
            if card.ability.extra.count >= card.ability.extra.cards then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = 'prob',
                    scalar_value = 'prob_mod',
                    no_message = true
                })
                card.ability.extra.count = 0
                return {message = localize('k_upgrade_ex'), colour = G.C.GREEN, message_card = card}
            end
            return nil, true
        end
        if context.mod_probability and card.ability.extra.prob ~= 0 then
            return {numerator = context.numerator+card.ability.extra.prob}
        end
    end
}

local sc = SMODS.shallow_copy
SMODS.Joker{
    key = 'mindassault',
    atlas = 'JokerSynonyms',
    pos = G.P_CENTERS.j_brainstorm.pos,
    rarity = 'soe_unique',
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(_, card, context)
        if context.joker_main and context.scoring_hand[1] then
            local other_context = sc(context)
            other_context.cardarea = G.play
            other_context.joker_main = nil
            return {func = function()
                for _, v in ipairs(context.scoring_hand) do
                    if v.debuff then
                        G.GAME.blind.triggered = true
                        G.E_MANAGER:add_event(Event({
                            func = (function() SMODS.juice_up_blind() return true end)
                        }))
                        card_eval_status_text(card, 'debuff')
                    else
                        G.soe_truer_card = {[v] = card}
                        SMODS.score_card(v, other_context)
                    end
                end
                G.soe_truer_card = nil
            end}
        end
    end
}