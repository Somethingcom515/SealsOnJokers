SMODS.Atlas{
    key = 'What',
    path = 'What.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Enhancers',
    path = 'Enhancers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Sleeves',
    path = 'Sleeves.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Placeholders',
    path = 'Placeholders.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'DeckSeals',
    path = 'DeckSeals.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Seals',
    path = 'Seals.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Exotics',
    path = 'Exotics.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'InfinitySeals',
    path = 'InfinitySeals.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Stakes',
    path = 'Stakes.png',
    px = 29,
    py = 29
}

SMODS.Atlas{
    key = 'modicon',
    path = 'modicon.png',
    px = 34,
    py = 34
}

SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true,
        post_trigger = true
    }
end

local cryptidyeohna = false
if next(SMODS.find_mod("Cryptid")) then
    cryptidyeohna = true
end

function IsEligibleForSeal(card)
    if ((not card.seal) or ((G.GAME.selected_sleeve and G.GAME.selected_sleeve == "sleeve_soe_seal" and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and not card.extraseal) or (#SMODS.find_card('j_soe_sealjoker') > 0)) and card.config.center.key ~= 'j_soe_sealjoker' then
        return true
    end
    return false
end

function set_card_win()
    for k, v in pairs(G.playing_cards) do
        if (v.ability.set == 'Default' or v.ability.set == 'Enhanced') then
            G.PROFILES[G.SETTINGS.profile].card_stickers = G.PROFILES[G.SETTINGS.profile].card_stickers or {}
            G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)] = G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)] or {count = 1, wins = {}, losses = {}, wins_by_key = {}, losses_by_key = {}}
            if G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)] then
                G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins = G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins or {}
                G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins[G.GAME.stake] = (G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins[G.GAME.stake] or 0) + 1
                G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins_by_key[SMODS.stake_from_index(G.GAME.stake)] = (G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(v.base.id)..tostring(v.base.suit)].wins_by_key[SMODS.stake_from_index(G.GAME.stake)] or 0) + 1
            end
        end
    end
    G:save_settings()
end

oldwingame = win_game
function win_game()
    if not G.GAME.seeded and not G.GAME.challenge then
        set_card_win()
    end
    return oldwingame()
end

SMODS.Consumable{
    key = 'dejavuq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    config = {mod_conv = "Red", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "red_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('dejavu'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Red")
                        print(highlighted.redsealcount)
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'tranceq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 1, y = 0},
    config = {mod_conv = "Blue", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "blue_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('trance'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Blue")
                        highlighted.ability.legallygold = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'talismanq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 2, y = 0},
    config = {mod_conv = "Gold", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "gold_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('talisman'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Gold")
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'mediumq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 3, y = 0},
    config = {mod_conv = "Purple", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "purple_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if IsEligibleForSeal(v) then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('medium'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Purple")
                    end
                    return true
                end,
            }))
        end
    end
}

if cryptidyeohna then
    SMODS.Consumable{
        key = 'typhoonq',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 4, y = 0},
        config = {mod_conv = "cry_azure", cards = 1},
        loc_vars = function(self,info_queue,center)
            info_queue[#info_queue+1] = { key = "cry_azure_seal_joker", set = "Other"}
        end,
        unlocked = true,
        discovered = true,
        can_use = function(self,card)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            return #eligible > 0 and true or false
        end,
        use = function(self,card,area,copier)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            local highlighted = pseudorandom_element(eligible, pseudoseed('typhoon'))
            if highlighted then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        highlighted:juice_up(0.3, 0.5)
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        if highlighted then
                            highlighted:set_seal("cry_azure")
                        end
                        return true
                    end,
                }))
            end
        end
    }
    SMODS.Consumable{
        key = 'sourceq',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 5, y = 0},
        config = {mod_conv = "cry_green", cards = 1},
        loc_vars = function(self,info_queue,center)
            info_queue[#info_queue+1] = { key = "cry_green_seal_joker", set = "Other"}
        end,
        unlocked = true,
        discovered = true,
        can_use = function(self,card)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            return #eligible > 0 and true or false
        end,
        use = function(self,card,area,copier)
            local eligible = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.seal then
                    eligible[#eligible + 1] = v
                end
            end
            local highlighted = pseudorandom_element(eligible, pseudoseed('source'))
            if highlighted then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        highlighted:juice_up(0.3, 0.5)
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        if highlighted then
                            highlighted:set_seal("cry_green")
                        end
                        return true
                    end,
                }))
            end
        end
    }
end

SMODS.Consumable{
    key = 'devilq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 6, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('devil'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallygold = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'towerq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 7, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('tower'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_ability("j_soe_stonecardjoker")
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'chariotq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 8, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('chariot'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallysteel = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'empressq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 9, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('empress'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallymult = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'hierophantq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 10, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('hierophant'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallybonus = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'magicianq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 11, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('magician'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallylucky = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'justiceq',
    set = 'Tarot',
    atlas = 'What',
    pos = {x = 12, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('justice'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.legallyglass = true
                        highlighted.ability.legal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'eternalq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.hand.cards) do
            if not v.ability.eternal then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.hand.cards) do
            if not v.ability.eternal then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('eternal'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted.ability.eternal = true
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'dejavuqq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    config = {mod_conv = "Red", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "red_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        local eligible = {}
        for k, v in pairs(G.consumeables.cards) do
            if not v.seal and v ~= card then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.consumeables.cards) do
            if not v.seal and v ~= card then
                eligible[#eligible + 1] = v
            end
        end
        local highlighted = pseudorandom_element(eligible, pseudoseed('dejavu'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("tarot1")
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if highlighted then
                        highlighted:set_seal("Red")
                    end
                    return true
                end,
            }))
        end
    end
}

SMODS.Consumable{
    key = 'dejavuqqq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    config = {mod_conv = "Red", cards = 1},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = { key = "red_seal_joker", set = "Other"}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        if G.GAME.blind.seal then
            return false
        elseif G.GAME.blind then
            return true
        end
    end,
    use = function(self,card,area,copier)
        G.GAME.blind.seal = "Red"
        if G.GAME.blind.config.blind.key == "bl_akyrs_final_periwinkle_pinecone" then
            G.GAME.blind.permasealdebuffha = true
        end
    end
}

local oldstartdissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.ability and self.ability.eternal and self.ability.set ~= 'Joker' then return nil end
    return oldstartdissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

local oldshatter = Card.shatter
function Card:shatter()
    self.shattered = false
    self.dissolve = 0
    if self.ability and self.ability.eternal then return nil end
    return oldshatter(self)
end

SMODS.Enhancement:take_ownership('glass', 
    {
        calculate = function(self, card, context)
            if card.ability.eternal then
                return nil
            end
            if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and pseudorandom('glass') < G.GAME.probabilities.normal/card.ability.extra then
                return { remove = true }
            end
        end,
    }, 
    true
)

local oldisface = Card.is_face
function Card:is_face()
    if SMODS.has_enhancement(self, 'm_prefix_facecard') then 
        return true
    end
    return oldisface(self)
end

function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end 

local oldsave = Card.save
function Card:save()
    cardTable = oldsave(self)
    cardTable.extrasealcount = self.extrasealcount
    cardTable.redsealcount = self.redsealcount
    cardTable.goldsealcount = self.goldsealcount
    cardTable.bluesealcount = self.bluesealcount
    cardTable.purplesealcount = self.purplesealcount
    cardTable.extraseals = self.extraseals
    return cardTable
end

local oldload = Card.load
function Card:load(cardTable, other_card)
    self.extrasealcount = cardTable.extrasealcount
    self.redsealcount = cardTable.redsealcount
    self.goldsealcount = cardTable.goldsealcount
    self.bluesealcount = cardTable.bluesealcount
    self.purplesealcount = cardTable.purplesealcount
    self.extraseals = cardTable.extraseals
    return oldload(self, cardTable, other_card)
end

local oldcalcseal = Card.calculate_seal
function Card:calculate_seal(context)
    if self.debuff then return nil end
    if self.ability and self.ability.set == 'Joker' then
        if self.seal == 'Red' and self.extraseals == nil and context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self then
            return {
                repetitions = 1,
                card = self
            }
        end
        if self.seal == 'Gold' and self.extraseals == nil and context.post_trigger and context.other_card == self then
            return {
                dollars = 3,
                message_card = self,
                card = self
            }
        end
        if self.seal == 'Blue' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == G.jokers then
            local card_type = 'Planet'
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)}))
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end
        if self.seal == 'Purple' and context.selling_self then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, '8ba')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
            end
        end
        if self.seal == 'Gold' and context.post_trigger and context.other_card == self and not table.contains(self.extraseals, "Gold") then
            ease_dollars(3)
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
        end
        if cryptidyeohna then
            if self.seal == 'cry_azure' and context.after then
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.0,
                    func = function()
                        local card_type = "Planet"
                        local _planet = nil
                        if G.GAME.last_hand_played then
                            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == G.GAME.last_hand_played then
                                    _planet = v.key
                                    break
                                end
                            end
                        end
    
                        for i = 1, 3 do
                            local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, "cry_azure")
    
                            card:set_edition({ negative = true }, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        self:start_dissolve()
                        return true
                    end,
                }))
            end
            if self.seal == 'cry_green' then
                local scoredyeohna
                if context.before then
                    scoredyeohna = false
                end
                if context.post_trigger and context.other_card == self then
                    scoredyeohna = true
                end
                if not scoredyeohna and context.after then
                    G.E_MANAGER:add_event(Event({
						func = function()
							if G.consumeables.config.card_limit > #G.consumeables.cards then
								local c = create_card("Code", G.consumeables, nil, nil, nil, nil, nil, "cry_green_seal")
								c:add_to_deck()
								G.consumeables:emplace(c)
								self:juice_up()
							end
							return true
						end,
					}))
                end
            end
        end
        if next(SMODS.find_mod('RevosVault')) then
            if self.seal == 'crv_ps' then
                if context.post_trigger and context.other_card == self then
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.0,
                        func = function()
                            local card = copy_card(self, nil)
----                            if not SMODS.find_card('j_soe_sealjoker') and ((not G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal' and G.GAME.selected_sleeve == 'sleeve_soe_seal') and not self.extraseal) then
                                card:set_seal()
----                            end
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            card_eval_status_text(self, 'extra', nil, nil, nil, {message = 'Printed!'})
                            return true
                        end
                    }))
                end
            end
        end
        if self.extraseals then
            if table.contains(self.extraseals, "Gold") and context.post_trigger and context.other_card == self then
                for i = 1, self.goldsealcount do
                    ease_dollars(3)
                    card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                end
            end
            if table.contains(self.extraseals, "Blue") and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == self.area then
                local card_type = 'Planet'
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        if G.GAME.last_hand_played then
                            local _planet = 0
                            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == G.GAME.last_hand_played then
                                    _planet = v.key
                                end
                            end
                            for i = 1, self.bluesealcount do
                                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                else
                                    break
                                end
                            end
                            G.GAME.consumeable_buffer = 0
                        end
                        return true
                    end)}))
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = '+'..tostring(math.min(self.bluesealcount, G.consumeables.config.card_limit - #G.consumeables.cards - G.GAME.consumeable_buffer + 1))..' Planet'..(self.bluesealcount > 1 and 's' or ''), colour = G.C.SECONDARY_SET.Planet})
            end
            if table.contains(self.extraseals, "Purple") and context.selling_self then
                for i = 1, self.purplesealcount do
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                    local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, '8ba')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                        card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                end
            end
        end
        if (self.extraseals and table.contains(self.extraseals, "Red")) or self.seal == "Red" then
            if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self then
                return {
                    repetitions = self.redsealcount,
                    card = self
                }
            end
        end
    end
    if self.ability and (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then
        if self.extraseal == 'Red' then 
        end
        if self.extraseal == 'Gold' then
            return {
                dollars = 3,
                colour = G.C.MONEY,
                card = self
            }
        end
    end
    if (self.ability.set == 'Joker') then return nil end
    return oldcalcseal(self, context)
end

function Card:set_sealbutbetter(var, _seal, silent, immediate)
    if _seal then
        self[var] = _seal
        if not silent then 
        G.CONTROLLER.locks.seal = true
            if immediate then 
                self:juice_up(0.3, 0.3)
                play_sound('gold_seal', 1.2, 0.4)
                G.CONTROLLER.locks.seal = false
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        self:juice_up(0.3, 0.3)
                        play_sound('gold_seal', 1.2, 0.4)
                    return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.CONTROLLER.locks.seal = false
                    return true
                    end
                }))
            end
        end
    end
end

oldsetseal = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
    if _seal then
        self[string.lower(_seal)..'sealcount'] = (self[string.lower(_seal)..'sealcount'] or 0) + 1
    end
    if #SMODS.find_card("j_soe_sealjoker") > 0 and _seal then
        if not self.seal then
            self:set_sealbutbetter('seal', _seal, silent, immediate)
        elseif not self.extraseal then
            self:set_sealbutbetter('extraseal', _seal, silent, immediate)
            self.extraseals = self.extraseals or {}
            self.extraseals['extraseal'] = _seal
            self.extrasealcount = (self.extrasealcount or 0) + 1
        else
            local random = '483959652912'
            while true do
                local random = tostring(math.random(1,999999999999999999999999))
                if not self['extraseal'..random] then break end
            end
            self:set_sealbutbetter('extraseal'..random, _seal, silent, immediate)
            self.extraseals = self.extraseals or {}
            self.extraseals['extraseal'..random] = _seal
            self.extrasealcount = (self.extrasealcount or 0) + 1
            print(self[string.lower(_seal)..'sealcount'])
        end
        return nil
    end
    if ((G.GAME.selected_sleeve == 'sleeve_soe_seal' and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and self.seal and not self.extraseal) and _seal then
        self:set_sealbutbetter('extraseal', _seal, silent, immediate)
        self.extraseals = self.extraseals or {}
        self.extraseals['extraseal'] = _seal
        self.extrasealcount = (self.extrasealcount or 0) + 1
        print(self[string.lower(_seal)..'sealcount'])
        if self.ability.name == 'Gold Card' and self.extraseal == 'Gold' and self.playing_card then 
            check_for_unlock({type = 'double_gold'})
        end
        self:set_cost()
        return nil
    end
    return oldsetseal(self, _seal, silent, immediate)
end

local oldunhighlightall = CardArea.unhighlight_all
function CardArea:unhighlight_all()
    if self == G.hand and G.GAME.modifiers.isred then return nil end
    return oldunhighlightall(self)
end

local olduseconsume = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if self.seal == 'Red' then
        G.GAME.modifiers.isred = true
    else
        G.GAME.modifiers.isred = false
    end
    local g = olduseconsume(self, area, copier)
    local used_tarot = copier or self
    if self.seal then
        if self.seal == 'Gold' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
        if self.seal == 'Red' then
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_again_ex')})
            if self.ability.name == 'The Emperor' or self.ability.name == 'The High Priestess' then
                for i = 1, math.min((self.ability.consumeable.tarots or self.ability.consumeable.planets), G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            local card = create_card((self.ability.name == 'The Emperor' and 'Tarot') or (self.ability.name == 'The High Priestess' and 'Planet'), G.consumeables, nil, nil, nil, nil, nil, (self.ability.name == 'The Emperor' and 'emp') or (self.ability.name == 'The High Priestess' and 'pri'))
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            used_tarot:juice_up(0.3, 0.5)
                        end
                        return true end }))
                end
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            for i=1, #G.hand.highlighted do
                local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            if self.ability.name == 'Strength' then
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        local card = G.hand.highlighted[i]
                        local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                        local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
                        if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                        elseif rank_suffix == 10 then rank_suffix = 'T'
                        elseif rank_suffix == 11 then rank_suffix = 'J'
                        elseif rank_suffix == 12 then rank_suffix = 'Q'
                        elseif rank_suffix == 13 then rank_suffix = 'K'
                        elseif rank_suffix == 14 then rank_suffix = 'A'
                        end
                        card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    return true end }))
                end  
            end
            for i=1, #G.hand.highlighted do
                local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            -- after this stays at the end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
                G.GAME.modifiers.isred = false
                G.hand:unhighlight_all(); return true
            end }))
        end
    end
    return g
end

local oldopen = Card.open
function Card:open()
    if self.ability.set == 'Booster' and self.seal then
        if self.seal == 'Gold' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
    end
    return oldopen(self)
end

local oldredeem = Card.redeem
function Card:redeem()
    if self.ability.set == 'Voucher' and self.seal then
        if self.seal == 'Gold' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(3)
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "$3", colour = G.C.MONEY})
                return true end 
            }))
        end
    end
    return oldredeem(self)
end

local oldcalcjoker = Card.calculate_joker
function Card:calculate_joker(context)
    local g = oldcalcjoker(self, context)
    if context.end_of_round and context.cardarea == G.jokers then
        if self.ability.legallygold then
            return {
                dollars = 3,
                colour = G.C.MONEY,
                card = self,
                message_card = self
            }
        end
    end
    if context.before then
        self.ability.triggered = false
    end
    if context.post_trigger and context.other_card == self and (context.other_context.joker_main or context.other_context.individual) then
        self.ability.triggered = true
        if self.ability.legallymult then
            return {
                mult = 4,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallybonus then
            return {
                chips = 30,
                colour = G.C.CHIPS,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallylucky then
            local smult, money
            if pseudorandom('lucky') < G.GAME.probabilities.normal / 5 then
                smult = 20
            end
            if pseudorandom('luckymoney') < G.GAME.probabilities.normal / 15 then
                money = 20
            end
            return {
                mult = smult,
                colour = G.C.MULT,
                card = self,
                message_card = self,
                extra = {
                    dollars = money,
                    colour = G.C.MONEY,
                    card = self,
                    message_card = self
                }
            }
        end
        if self.ability.legallysteel then
            return {
                xmult = 1.5,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyglass then
            return {
                xmult = 2,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
    end
    if context.after then
        if self.ability.legallyglass then
            if pseudorandom('glass') < G.GAME.probabilities.normal / 4 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        self:shatter()
                        return true
                    end
                }))
            end
        end
    end
    if context.joker_main and context.cardarea == G.jokers then
        if not true then
            if self.ability.legallymult then
                return {
                    mult = 4,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallybonus then
                return {
                    chips = 30,
                    colour = G.C.CHIPS,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallylucky then
                local smult, money
                if pseudorandom('lucky') < G.GAME.probabilities.normal / 5 then
                    smult = 20
                end
                if pseudorandom('luckymoney') < G.GAME.probabilities.normal / 15 then
                    money = 20
                end
                return {
                    mult = smult,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self,
                    extra = {
                        dollars = money,
                        colour = G.C.MONEY,
                        card = self,
                        message_card = self
                    }
                }
            end
            if self.ability.legallyglass then
                return {
                    xmult = 2,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
        end
    end
    if self.ability and (self.ability.set == 'Tarot' or self.ability.set == 'Spectral' or self.ability.set == 'Voucher' or self.ability.set == 'Planet') and self.seal then
        if self.seal == 'Blue' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == G.consumeables then
            local card_type = 'Planet'
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)}))
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        end
        if self.seal == 'Purple' and context.selling_self then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, '8ba')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
            end
        end
    end
    return g
end

SMODS.Joker{
    name = 'StoneCardJoker',
    key = 'stonecardjoker',
    atlas = 'Enhancers',
    pos = {x = 5, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    config = {
        chips = 50
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.chips,
                colour = G.C.CHIPS,
                card = card
            }
        end
    end,
    in_pool = function(self)
        return false
    end
}

local exoticrarity
if cryptidyeohna then
    exoticrarity = 'cry_exotic'
else
    exoticrarity = 'soe_infinity'
end

SMODS.Joker{
    name = 'SealJoker',
    key = 'sealjoker',
    atlas = 'Exotics',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = exoticrarity,
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
}

local sealoverlords = SMODS.Gradient{
        key = 'seal_gradient',
        colours = {
            HEX('E8463D'),
            HEX('009CFD'),
            HEX('A267E4'),
            HEX('F7AF38'),
        }
}

SMODS.Rarity{
    key = 'infinity',
    badge_colour = sealoverlords,
}

SMODS.Consumable{
    key = 'infinityfuser',
    name = 'InfinityFuser',
    atlas = 'Placeholders',
    set = 'Spectral',
    pos = {x = 2, y = 2},
    can_use = function (self, card) 
        local g = {}
        if (#SMODS.find_card("j_soe_infinityred") > 0 and #SMODS.find_card("j_soe_infinitygold") > 0 and #SMODS.find_card("j_soe_infinityblue") > 0 and #SMODS.find_card("j_soe_infinitypurple") > 0) and #G.jokers.highlighted == 4 then
            for k, v in pairs(G.jokers.highlighted) do
                if v.config.center.key == 'j_soe_infinityred' or v.config.center.key == 'j_soe_infinitygold' or v.config.center.key == 'j_soe_infinityblue' or v.config.center.key == 'j_soe_infinitypurple' then
                    table.insert(g, v)
                else
                    return false
                end
            end
            return true
        else
            return false
        end
    end,
    use = function (self, card, area, copier)
        for k, v in pairs(G.jokers.highlighted) do
            v:start_dissolve()
        end
        play_sound('explosion_release1')
        SMODS.add_card({set = 'Joker', area = G.jokers, key = 'j_soe_infinity'})
    end
}

local infinityrarity
if next(SMODS.find_mod('jen')) then
    infinityrarity = 'jen_omegatranscendent'
else
    infinityrarity = 'soe_infinity'
end

SMODS.Joker{
    name = 'Infinity',
    key = 'infinity',
    atlas = 'Placeholders',
    pos = {x = 0, y = 1},
    soul_pos = {x = 5, y = 0,},
    rarity = infinityrarity,
    cost = 2147483647,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'InfinityRed',
    key = 'infinityred',
    atlas = 'InfinitySeals',
    pos = {x = 0, y = 0},
    soul_pos = {x = 4, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
		if context.post_trigger and context.other_card.config.center.rarity ~= 'soe_infinity' then
            context.other_card:set_seal('Red', true, true)
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                card = card,
                message_card = card
            }
		end
        if context.individual and context.cardarea == G.play then
            context.other_card:set_seal('Red')
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                card = card,
                message_card = card
            }
        end
    end

}

SMODS.Joker{
    name = 'InfinityPurple',
    key = 'infinitypurple',
    atlas = 'InfinitySeals',
    pos = {x = 1, y = 0},
    soul_pos = {x = 5, y = 0,},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
}

SMODS.Joker{
    name = 'InfinityGold',
    key = 'infinitygold',
    atlas = 'InfinitySeals',
    pos = {x = 2, y = 0},
    soul_pos = {x = 6, y = 0,
    draw = function(card, scale_mod, rotate_mod)
        card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end
},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if context.individual then
            return {
                dollar_message = 'Gold!!!',
                message = 'Gold!!!',
                dollars = 3,
                colour = G.C.GOLD,
                card = card,
                message_card = card
            }
        end
        if context.post_trigger and context.other_card.config.center.rarity ~= 'soe_infinity' then
            return {
                dollar_message = 'Gold!!!',
                message = 'Gold!!!',
                dollars = 3,
                card = card,
                message_card = card,
                colour = G.C.GOLD
            }
        end
    end
}

SMODS.Joker{
    name = 'InfinityBlue',
    key = 'infinityblue',
    atlas = 'InfinitySeals',
    pos = {x = 3, y = 0},
    soul_pos = {x = 7, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
}

if cryptidyeohna then
    local oldadvanced = Cryptid.advanced_find_joker
    function Cryptid.advanced_find_joker(name, rarity, edition, ability, non_debuff, area)
        local e = oldadvanced(name, rarity, edition, ability, non_debuff, area)
        if (name == nil and rarity == "cry_exotic" and edition ==  nil and ability == nil and non_debuff == true) and #oldadvanced(nil, 'soe_infinity', nil, nil, true) > 0 then
            table.insert(e, "e")
        end
        return e
    end
end

SMODS.Seal{
    key = 'sealseal',
    name = 'SealSeal',
    badge_colour = HEX('E8463D'),
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {omult = 5},
    loc_vars = function(self, info_queue)
        return {vars = {self.config.omult}}
    end,
    calculate = function(self, card, context)
        if card.extraseal and context.before then
            local adjacentright, adjacentleft
            if context.cardarea == G.jokers or context.cardarea == G.hand or context.cardarea == G.consumeables or context.cardarea == G.play then
                for i=1, #card.area.cards do
                    if card.area.cards[i] == card then
                        if card.area.cards[i+1] then
                            adjacentright = card.area.cards[i+1]
                        end
                        if card.area.cards[i-1] then
                            adjacentleft = card.area.cards[i-1]
                        end
                    end
                end
                if adjacentright then
                    adjacentright:set_seal(card.extraseal)
                end
                if adjacentleft then
                    adjacentleft:set_seal(card.extraseal)
                end
            end
        end
        if not card.extraseal and context.main_scoring then
            return {
                mult = self.config.omult,
                colour = G.C.MULT,
                card = card
            }
        end 
    end
}

local ancientupdate = EventManager.update

function EventManager:update(dt, forced)
    if G.STATE == G.STATES.SELECTING_HAND then
        if G.GAME and G.GAME.blind and G.GAME.blind.seal and G.GAME.blind.debuff.akyrs_all_seals_perma_debuff and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
        end
        if G.GAME and G.GAME.blind and G.GAME.blind.permasealdebuffha and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
        end
    end
    return ancientupdate(self, dt, forced)
end

SMODS.Back{
    key = 'seal',
    name = 'AllSealsDeck',
    atlas = 'Enhancers',
    pos = {x = 5, y = 2},
}

if CardSleeves then
    CardSleeves.Sleeve {
        key = "seal",
        atlas = "Sleeves",
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key
            if self.get_current_deck_key() == "b_soe_seal" then
                key = self.key .. "_extra"
            end
            return {key = key}
        end,
    }
    CardSleeves.Sleeve {
        key = "redseal",
        atlas = "DeckSeals",
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key
            local deckkey = self.get_current_deck_key()
            key = self.key
            self.config = G.P_CENTERS.b_red.config
            local tempstring = ""
            for k, v in pairs(G.localization.descriptions.Back[deckkey].text) do
                tempstring = tempstring .. v
            end
            return {vars = {tempstring}, key = key}
        end,
    }
    CardSleeves.Sleeve {
        key = "goldseal",
        atlas = "DeckSeals",
        pos = { x = 3, y = 0 },
        calculate = function(self, sleeve, context)
            if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
                return {
                    dollars = 3,
                    colour = G.C.MONEY,
                    card = context.other_card,
                    message_card = context.other_card,  
                }
            end
        end
    }
end

--[[
SMODS.Stake{
    key = 'seal',
    applied_stakes = {'stake_gold'},
    loc_txt = {
        name = 'Seal Stake',
        text = {
            'I dont know',
        },
        sticker = {
            name = 'Seal Sticker',
            text = {
                'I dont know',
            }
        }
    },
    atlas = 'Stakes',
    pos = {x = 0, y = 0},
    colour = G.C.RED
}
]]

--[[
SMODS.Achievement{
    key = 'completionist_plus_plus_plus',
    unlock_condition = function(self, args)
        return G.PROGRESS.card_stickers.tally/G.PROGRESS.card_stickers.of >= 1 
    end
}

local oldsetprofileprog = set_profile_progress
function set_profile_progress()
    local g = oldsetprofileprog()
    G.PROGRESS.card_stickers = {tally = 0, of = 0}
    for _, v in pairs(G.P_CARDS) do
        G.PROGRESS.card_stickers.of = G.PROGRESS.card_stickers.of + #G.P_CENTER_POOLS.Stake
        G.PROGRESS.card_stickers.tally = G.PROGRESS.card_stickers.tally + get_card_win_sticker(v, true, true)
    end
    return g
end
]]

function get_card_win_sticker(_card, index, proprog)
    local suit, rank
    if proprog then
        suit = _card.suit
        if _card.value == 'King' then
            rank = 13
        elseif _card.value == 'Queen' then
            rank = 12
        elseif _card.value == 'Jack' then
            rank = 11
        else
            rank = tonumber(_card.value)
        end
    else
        suit = _card.base.suit
        rank = _card.base.id
    end

    G.PROFILES[G.SETTINGS.profile].card_stickers = G.PROFILES[G.SETTINGS.profile].card_stickers or {}
	local card_usage = G.PROFILES[G.SETTINGS.profile].card_stickers[tostring(rank)..tostring(suit)] or {}
	if card_usage.wins then
		local applied = {}
		local _count = 0
		local _stake = nil
		for k, v in pairs(card_usage.wins_by_key) do
			SMODS.build_stake_chain(G.P_STAKES[k], applied)
		end
		for i, v in ipairs(G.P_CENTER_POOLS.Stake) do
			if applied[v.order] then
				_count = _count+1
				if (v.stake_level or 0) > (_stake and G.P_STAKES[_stake].stake_level or 0) then
					_stake = v.key
				end
			end
		end
		if index then return _count end
		if _count > 0 then return G.sticker_map[_stake] end
	end
	if index then return 0 end
end

oldcheckforunlock = check_for_unlock
function check_for_unlock(args)
    if args.type == 'win_stake' then 
        if G.PROGRESS.card_stickers.tally/G.PROGRESS.card_stickers.of >= 1 then
            unlock_achievement('completionist_plus_plus_plus')
        end
    end
    return oldcheckforunlock(args)
end

local oldupdate = Card.update
function Card:update(dt)
    if (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal') or (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_soe_seal') then
        local seals = {'Red', 'Blue', 'Gold', 'Purple'}
        if cryptidyeohna then
            table.insert(seals, {'cry_azure', 'cry_green'})
        end
        if G.shop_jokers and G.shop_jokers.cards and G.shop_jokers.cards[1] then
            for k, v in ipairs(G.shop_jokers.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
        if G.shop_booster and G.shop_booster.cards and G.shop_booster.cards[1] then
            for k, v in ipairs(G.shop_booster.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
        if G.shop_vouchers and G.shop_vouchers.cards and G.shop_vouchers.cards[1] then
            for k, v in ipairs(G.shop_vouchers.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
        if G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] then
            for k, v in ipairs(G.pack_cards.cards) do
                if not v.seal then
                    v:set_seal(pseudorandom_element(seals, pseudoseed('seal')), true, true)
                end
            end
        end
    end
    if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and not self.sticker_run then 
        self.sticker_run = get_card_win_sticker(self) or 'NONE'
    end
    return oldupdate(self, dt)
end

SMODS.Joker:take_ownership('j_mail',
    {
        calculate = function(self, card, context)
            if context.discard and not context.other_card.debuff and ((context.other_card:get_id() == G.GAME.current_round.mail_card.id)) then
                return {
                    dollars = card.ability.extra,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    },
    true
)

SMODS.Joker:take_ownership('j_burglar',
    {
        calculate = function(self, card, context)
            if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
                return {
                    G.E_MANAGER:add_event(Event({func = function()
                        ease_discard(-G.GAME.current_round.discards_left, nil, true)
                        ease_hands_played(card.ability.extra)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {card.ability.extra}}})
                    return true end }))
                }
            end
        end
    },
    true
)

SMODS.DrawStep{
    key = 'sealsforall',
    order = 10,
    func = function(self)
        if (self.ability.set ~= 'Joker' and (self.ability.set ~= 'Default' and self.ability.set ~= 'Enhanced')) and self.seal then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
        end
    end
}

SMODS.DrawStep{
    key = 'secondsealsforall',
    order = 11,
    func = function(self, card)
        if self.extraseal and not (#SMODS.find_card("j_soe_sealjoker") > 0) then
            G.shared_seals[self.extraseal].role.draw_major = self
            G.shared_seals[self.extraseal]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, 1)
            if self.extraseal == 'Gold' then G.shared_seals[self.extraseal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, nil, nil, nil, 1) end
        end
    end
}

function table.contains(table, element)
    if table and type(table) == "table" then
        for _, value in pairs(table) do
            if value == element then
                return true
            end
        end
        return false
    end
end
  

SMODS.DrawStep{
    key = 'foursealstoshow',
    order = 12,
    func = function(self, card)
        if self.extraseals and (#SMODS.find_card("j_soe_sealjoker") > 0) then
            if table.contains(self.extraseals, "Red") then
                G.shared_seals["Red"].role.draw_major = self
                G.shared_seals["Red"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, nil)
            end
            if table.contains(self.extraseals, "Gold") then
                G.shared_seals["Gold"].role.draw_major = self
                G.shared_seals["Gold"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, 1)
                G.shared_seals["Gold"]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, nil, nil, nil, 1)
            end
            if table.contains(self.extraseals, "Blue") then
                G.shared_seals["Blue"].role.draw_major = self
                G.shared_seals["Blue"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 0.5)
            end
            if table.contains(self.extraseals, "Purple") then
                G.shared_seals["Purple"].role.draw_major = self
                G.shared_seals["Purple"]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 0.5, 1)
            end
        end
    end
}

SMODS.DrawStep{
    key = 'stickersforplayingcards',
    order = 13,
    func = function(self, card)
        if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and G.playing_cards then
            if self.sticker and G.shared_stickers[self.sticker] then
                G.shared_stickers[self.sticker].role.draw_major = self
                G.shared_stickers[self.sticker]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                G.shared_stickers[self.sticker]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
            elseif (self.sticker_run and G.shared_stickers[self.sticker_run]) and G.SETTINGS.run_stake_stickers then
                G.shared_stickers[self.sticker_run].role.draw_major = self
                G.shared_stickers[self.sticker_run]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                G.shared_stickers[self.sticker_run]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
            end
        end
    end
}

SMODS.Atlas{
    key = 'Blinds',
    path = 'Blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Blind{
    key = 'theseal',
    atlas = 'Blinds',
    discovered = true,
    pos = {x = 0, y = 0},
    boss = {min = 1, max = 10, showdown = true},
    boss_colour = HEX('E8463D'),
    set_blind = function(self)
        for i, v in ipairs(G.playing_cards) do
            if not v.seal then
                SMODS.debuff_card(v, true, 'redseal1'..tostring(i))
            end
        end
        for i, v in ipairs(G.jokers.cards) do
            if not v.seal then
                SMODS.debuff_card(v, true,'redseal2'..tostring(i))
            end
        end
        for i, v in ipairs(G.consumeables.cards) do
            if not v.seal then
                SMODS.debuff_card(v, true,'redseal3'..tostring(i))
            end
        end
    end,
    disable = function(self)
        for i, v in ipairs(G.playing_cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal1'..tostring(i))
            end
        end
        for i, v in ipairs(G.jokers.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal2'..tostring(i))
            end
        end
        for i, v in ipairs(G.consumeables.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal3'..tostring(i))
            end
        end
    end,
    defeat = function(self)
        for i, v in ipairs(G.playing_cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal1'..tostring(i))
            end
        end
        for i, v in ipairs(G.jokers.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal2'..tostring(i))
            end
        end
        for i, v in ipairs(G.consumeables.cards) do
            if not v.seal then
                SMODS.debuff_card(v, false, 'redseal3'..tostring(i))
            end
        end
    end
}

SMODS.Keybind{
    key_pressed = '-',
    held_keys = {'lshift'},
    event = 'pressed',
    action = function(self)
        G.PROFILES[G.SETTINGS.profile].card_stickers = {}
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
            local joker = G.jokers.highlighted[1]
            if not joker.ability.legal then
                print('Highlighted joker is not enhanced')
            end
            if joker.ability.legallygold then
                print('Highlighted joker is enhanced with gold')
            end
            if joker.ability.legallysteel then
                print('Highlighted joker is enhanced with steel')
            end
            if joker.ability.legallymult then
                print('Highlighted joker is enhanced with mult')
            end
            if joker.ability.legallybonus then
                print('Highlighted joker is enhanced with bonus')
            end
            if joker.ability.legallylucky then
                print('Highlighted joker is enhanced with lucky')
            end
            if joker.ability.legallyglass then
                print('Highlighted joker is enhanced with glass')
            end
            if joker.ability.name == 'StoneCardJoker' then
                print('You cannot be serious right now, but this is a stone')
            end
        end
    end
}