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
    key = 'PlayingCards',
    path = 'PlayingCards.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'BlueprintVouchers',
    path = 'BlueprintVouchers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'JokerEnhancements',
    path = 'JokerEnhancements.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'JokerFronts',
    path = 'JokerFronts.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'ExtraLife',
    path = 'ExtraLife.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Tarots',
    path = 'Tarots.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Vouchers',
    path = 'Vouchers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Planets',
    path = 'Planets.png',
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
    key = 'SecondSeals',
    path = 'SecondSeals.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Charms',
    path = 'Charms.png',
    px = 68,
    py = 68
}

SMODS.Atlas{
    key = 'Boosters',
    path = 'Boosters.png',
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
    key = 'Think',
    path = 'Think.png',
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

SMODS.Atlas{
    key = 'VanillaSleeves',
    path = 'VanillaSleeves.png',
    px = 73,
    py = 96
}

SEALS = SMODS.current_mod

SEALS.optional_features = function()
    return {
        retrigger_joker = true,
        post_trigger = true,
    }
end

to_big = to_big or function(x) return x end

function SEALS.find_mod(id)
    for _, mod in ipairs(SMODS.find_mod(id)) do
        if mod.can_load then
            return true
        end
    end
    return false
end

local cryptidyeohna = false
if SEALS.find_mod("Cryptid") then
    cryptidyeohna = true
end

function IsEligibleForSeal(card)
    if ((not card.seal) or ((G.GAME.selected_sleeve and G.GAME.selected_sleeve == "sleeve_soe_seal" and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and not card.extraseal) or (#SMODS.find_card('j_soe_sealjoker') > 0)) and (card.config and card.config.center.key ~= 'j_soe_sealjoker') then
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

local function juice_up_game()
    local animtimer = 50
    while animtimer > 0 do
        x, y, displayindex = love.window.getPosition()
        d_width, d_height = love.window.getDesktopDimensions( displayindex )
        w_width, w_height, flags = love.window.getMode( )
        animtimer = animtimer - 0.5
        m_width = d_width - w_width
        m_height = d_height - w_height
        if not flags.fullscreen then
            love.window.setPosition( (math.sin( animtimer ) + 1) / 7 * (m_width - 224) + 112, (math.cos( animtimer ) + 1) / 7 * (m_height - 224) + 112)
        end
    end
end

local oldcardareainit = CardArea.init
function CardArea:init(X, Y, W, H, config)
    local r = oldcardareainit(self, X, Y, W, H, config)
    if not config.temporary and not config.collection then
        if not SEALS.all_card_areas then
            SEALS.all_card_areas = {}
        end
        table.insert(SEALS.all_card_areas,self)
    end
    return r
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Gold"
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted:set_ability(G.P_CENTERS.j_soe_stonecardjoker)
                        highlighted.ability.legallyenhanced = "Stone"
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Steel"
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Mult"
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Bonus"
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Lucky"
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
            if not v.ability.legallyenhanced then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.legallyenhanced then
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
                        highlighted.ability.legallyenhanced = "Glass"
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

local oldfuncsselfreroll = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop()
    oldfuncsselfreroll()
    if G.GAME.rerollbuttonseal == "Gold" then
        ease_dollars(3)
    elseif G.GAME.rerollbuttonseal == "Red" then
        oldfuncsselfreroll()
    elseif G.GAME.rerollbuttonseal == "Blue" then
    elseif G.GAME.rerollbuttonseal == "Purple" then
    end
end

SMODS.Consumable{
    key = 'murder',
    set = 'Tarot',
    atlas = 'Tarots',
    pos = {x = 3, y = 1},
    unlocked = true,
    discovered = true,
    config = {mod_conv = 'card', max_highlighted = 2, min_highlighted = 2},
    loc_txt = {
        name = 'Murder',
        text = {
            "Select {C:attention}#1#{} Jokers,",
            "convert the {C:attention}left{} Joker",
            "into the {C:attention}right{} Joker",
            "{C:inactive}(Drag to rearrange)",
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.max_highlighted}}
    end,
    can_use = function(self,card)
        if #G.jokers.highlighted == 2 then
            return true
        end
        return false
    end,
    use = function(self,card,area,copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.jokers.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.jokers.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.jokers.highlighted[i]:flip();play_sound('card1', percent);G.jokers.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local rightmost = G.jokers.highlighted[1]
        for i=1, #G.jokers.highlighted do if G.jokers.highlighted[i].T.x > rightmost.T.x then rightmost = G.jokers.highlighted[i] end end
        for i=1, #G.jokers.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= rightmost then
                    copy_card(rightmost, G.jokers.highlighted[i])
                end
                return true end }))
        end 
        for i=1, #G.jokers.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.jokers.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.jokers.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.jokers:unhighlight_all(); return true end }))
        delay(0.5)
    end
}

G.FUNCS.play_highlighted_jokers = function(e)
    local cards = {}
    for i = 1, #G.jokers.highlighted do
        cards[i] = create_playing_card({front = pseudorandom_element(G.P_CARDS, pseudoseed('highjoker')), center = G.P_CENTERS["m_soe_"..G.jokers.highlighted[i].config.center.key]}, G.hand, true, nil, nil)
        G.jokers.highlighted[i]:start_dissolve()
    end
    for k, v in pairs(cards) do
        G.hand:add_to_highlighted(v)
    end
    G.FUNCS.play_cards_from_highlighted(e)
end

SMODS.Enhancement{
    key = "j_joker",
    loc_txt = {
        name = 'Joker',
        text = {
            '{C:red,s:1.1}+#1#{} Mult',
        }
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.mult}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 0, y = 0},
    no_collection = true,
    config = {mult = 4},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end
}

SMODS.Enhancement{
    key = "j_jolly",
    loc_txt = {
        name="Jolly Joker",
        text={
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.extra.mult, self.config.extra.type}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 2, y = 0},
    no_collection = true,
    config = {extra = {mult = 8, type = 'Pair'}},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring and next(context.poker_hands[self.config.extra.type]) then
            return {mult = self.config.extra.mult}
        end
    end
}

SMODS.Enhancement{
    key = "j_zany",
    loc_txt = {
        name="Zany Joker",
        text={
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
    },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.extra.mult, self.config.extra.type}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 3, y = 0},
    no_collection = true,
    config = {extra = {mult = 12, type = 'Three of a Kind'}},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring and next(context.poker_hands[self.config.extra.type]) then
            return {mult = self.config.extra.mult}
        end
    end
}

SMODS.Enhancement{
    key = "j_blueprint",
    loc_txt = {
        name="Blueprint",
        text={
            "Copies ability of",
            "{C:attention}Playing Card{} to the right",
        },
    },
    atlas = 'JokerEnhancements',
    pos = {x = 0, y = 3},
    no_collection = true,
    replace_base_card = true,
    overrides_base_rank = true,
    always_scores = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        local other_card
        if context.main_scoring then
            for i = 1, #card.area.cards do
                if card.area.cards[i] == card and card.area.cards[i+1] then
                    other_card = card.area.cards[i+1]
                end
            end
            if other_card then
                local eval, post = eval_card(other_card, context)
                if eval.playing_card then
                    for k, v in pairs(eval.playing_card) do
                        eval[k] = v
                    end
                end
                return eval
            end
        end
    end,
    update = function(self, card, dt)
        if G.play ~= nil then
            if #G.play.cards ~= 0 then
                for i = 1, #G.play.cards do
                    if G.play.cards[i] == card then
                        if #G.play.cards == 1 and i == 1 then
                            card.ability.no_rank = true
                            card.ability.no_suit = true
                        else
                            if i < #G.play.cards then
                                local suit_prefix = G.play.cards[i+1].base.suit
                                local rank_suffix = G.play.cards[i+1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                            end
                        end
                    end
                end
            end
            if G.hand and G.hand.cards and #G.hand.cards ~= 0 then
                for i = 1, #G.hand.cards do
                    if G.hand.cards[i] == card then
                        if #G.hand.cards == 1 and i == 1 then
                            card.ability.no_rank = true
                            card.ability.no_suit = true
                        else
                            if i < #G.hand.cards then
                                local suit_prefix = G.hand.cards[i+1].base.suit
                                local rank_suffix = G.hand.cards[i+1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                            end
                        end
                    end
                end
            end
        end
        if G.hand ~= nil then
            if #G.hand.highlighted ~= 0 then
                for i = 1, #G.hand.highlighted do
                    if G.hand.highlighted[i] == card then
                        if #G.hand.highlighted == 1 and i == 1 then
                            card.ability.no_rank = true
                            card.ability.no_suit = true
                        else
                            if i < #G.hand.highlighted then
                                local suit_prefix = G.hand.highlighted[i+1].base.suit
                                local rank_suffix = G.hand.highlighted[i+1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                            end
                        end
                    end
                end
            end
        end
    end,
}

SMODS.Enhancement{
    key = "j_brainstorm",
    loc_txt = {
        name="Brainstorm",
        text={
            "Copies the ability",
            "of leftmost {C:attention}Playing Card",
        },
    },
    atlas = 'JokerEnhancements',
    pos = {x = 7, y = 7},
    no_collection = true,
    replace_base_card = true,
    always_scores = true,
    no_rank = true,
    weight = 0,
    config = {extra = {blueprint = {}}},
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        local other_card
        if context.main_scoring then
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[1] ~= card then
                    other_card = context.scoring_hand[1]
                end
            end
            if other_card then
                card.ability.bonus = other_card:get_chip_bonus()
                local eval, post = eval_card(other_card, context)
                Card:set_edition()
                if eval and eval.playing_card then
                    for k, v in pairs(eval.playing_card) do
                        card.ability.extra.blueprint[k] = v
                        eval[k] = v
                    end
                end
                if other_card.ability.extra.blueprint then
                    for k, v in pairs(other_card.ability.extra.blueprint) do
                        eval[k] = v
                    end
                end
                return eval
            end
        end
    end,
    update = function(self, card, dt)
        if G.play ~= nil then
            if #G.play.cards ~= 0 then
                if #G.play.cards[1] == card then
                    card.ability.no_rank = true
                    card.ability.no_suit = true
                else
                    local suit_prefix = G.play.cards[1].base.suit
                    local rank_suffix = G.play.cards[1].base.value
                    card.ability.no_rank = false
                    card.ability.no_suit = false
                    assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                end
            end
            if G.hand and G.hand.cards and #G.hand.cards ~= 0 then
                if G.hand.cards[1] == card then
                    card.ability.no_rank = true
                    card.ability.no_suit = true
                else
                    local suit_prefix = G.hand.cards[i+1].base.suit
                    local rank_suffix = G.hand.cards[i+1].base.value
                    card.ability.no_rank = false
                    card.ability.no_suit = false
                    assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                end
            end
        end
        if G.hand ~= nil then
            if #G.hand.highlighted ~= 0 then
                for i = 1, #G.hand.highlighted do
                    if G.hand.highlighted[i] == card then
                        if #G.hand.highlighted == 1 and i == 1 then
                            card.ability.no_rank = true
                            card.ability.no_suit = true
                        else
                            if i < #G.hand.highlighted then
                                local suit_prefix = G.hand.highlighted[i+1].base.suit
                                local rank_suffix = G.hand.highlighted[i+1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                            end
                        end
                    end
                end
            end
        end
    end,
}

SMODS.Enhancement{
    key = "j_burnt",
    loc_txt = {
        name="Burnt Joker",
        text={
            "Upgrade the level of",
            "the first {C:attention}discarded",
            "poker hand each round",
        },
    },
    atlas = 'JokerEnhancements',
    pos = {x = 3, y = 7},
    no_collection = true,
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook and context.cardarea ~= G.discard then
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
            level_up_hand(context.blueprint_card or card, text, nil, 1)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
    end
}

SMODS.Enhancement{
    key = "j_perkeo",
    loc_txt = {
        name = 'Perkeo',
        text = {
            "Creates a {C:dark_edition}Negative{} copy of",
            "{C:attention}1{} random {C:attention}consumable{}",
            "card in your possession",
            "at the end of the {C:attention}shop",
        }
    },
    atlas = 'JokerEnhancements',
    pos = {x = 7, y = 8},
    no_collection = true,
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if G.consumeables.cards[1] and context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo')), nil)
                    card:set_edition({negative = true}, true)
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    card:juice_up()
                    return true
                end}))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
        end
    end
}

--[[
SMODS.DrawStep {
    key = 'perkeoenhance',
    order = 15,
    func = function(self)
        if SMODS.has_enhancement(self, 'm_soe_j_perkeo') then
            self.children.floating_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, je, {x = 7, y = 9})
            self.children.floating_sprite.role.draw_major = self
            self.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center)
            self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
}
]]

local abovehand
if cryptidyeohna then
    abovehand = "cry_WholeDeck"
else
    abovehand = "Flush Five"
end

local vanilla_jokers_as_enhanced = {"m_soe_j_joker", "m_soe_j_greedy_joker", "m_soe_j_lusty_joker", "m_soe_j_wrathful_joker", "m_soe_j_gluttenous_joker", "m_soe_j_jolly", "m_soe_j_zany", "m_soe_j_mad", "m_soe_j_crazy", "m_soe_j_droll", "m_soe_j_sly", "m_soe_j_wily", "m_soe_j_clever", "m_soe_j_devious", "m_soe_j_crafty", "m_soe_j_half", "m_soe_j_stencil", "m_soe_j_four_fingers", "m_soe_j_mime", "m_soe_j_credit_card", "m_soe_j_ceremonial", "m_soe_j_banner", "m_soe_j_mystic_summit", "m_soe_j_marble", "m_soe_j_loyalty_card", "m_soe_j_8_ball", "m_soe_j_misprint", "m_soe_j_dusk", "m_soe_j_raised_fist", "m_soe_j_chaos", "m_soe_j_fibonacci", "m_soe_j_steel_joker", "m_soe_j_scary_face", "m_soe_j_abstract", "m_soe_j_delayed_grat", "m_soe_j_hack", "m_soe_j_pareidolia", "m_soe_j_gros_michel", "m_soe_j_even_steven", "m_soe_j_odd_todd", "m_soe_j_scholar", "m_soe_j_business", "m_soe_j_supernova", "m_soe_j_ride_the_bus", "m_soe_j_space", "m_soe_j_egg", "m_soe_j_burglar", "m_soe_j_blackboard", "m_soe_j_runner", "m_soe_j_ice_cream", "m_soe_j_dna", "m_soe_j_splash", "m_soe_j_blue_joker", "m_soe_j_sixth_sense", "m_soe_j_constellation", "m_soe_j_hiker", "m_soe_j_faceless", "m_soe_j_green_joker", "m_soe_j_superposition", "m_soe_j_todo_list", "m_soe_j_cavendish", "m_soe_j_card_sharp", "m_soe_j_red_card", "m_soe_j_madness", "m_soe_j_square", "m_soe_j_seance", "m_soe_j_riff_raff", "m_soe_j_vampire", "m_soe_j_shortcut", "m_soe_j_hologram", "m_soe_j_vagabond", "m_soe_j_baron", "m_soe_j_cloud_9", "m_soe_j_rocket", "m_soe_j_obelisk", "m_soe_j_midas_mask", "m_soe_j_luchador", "m_soe_j_photograph", "m_soe_j_gift", "m_soe_j_turtle_bean", "m_soe_j_erosion", "m_soe_j_reserved_parking", "m_soe_j_mail", "m_soe_j_to_the_moon", "m_soe_j_hallucination", "m_soe_j_fortune_teller", "m_soe_j_juggler", "m_soe_j_drunkard", "m_soe_j_stone", "m_soe_j_golden", "m_soe_j_lucky_cat", "m_soe_j_baseball", "m_soe_j_bull", "m_soe_j_diet_cola", "m_soe_j_trading", "m_soe_j_flash", "m_soe_j_popcorn", "m_soe_j_trousers", "m_soe_j_ancient", "m_soe_j_ramen", "m_soe_j_walkie_talkie", "m_soe_j_selzer", "m_soe_j_castle", "m_soe_j_smiley", "m_soe_j_campfire", "m_soe_j_ticket", "m_soe_j_mr_bones", "m_soe_j_acrobat", "m_soe_j_sock_and_buskin", "m_soe_j_swashbuckler", "m_soe_j_troubadour", "m_soe_j_certificate", "m_soe_j_smeared", "m_soe_j_throwback", "m_soe_j_hanging_chad", "m_soe_j_rough_gem", "m_soe_j_bloodstone", "m_soe_j_arrowhead", "m_soe_j_onyx_agate", "m_soe_j_glass", "m_soe_j_ring_master", "m_soe_j_flower_pot", "m_soe_j_blueprint", "m_soe_j_wee", "m_soe_j_merry_andy", "m_soe_j_oops", "m_soe_j_idol", "m_soe_j_seeing_double", "m_soe_j_matador", "m_soe_j_hit_the_road", "m_soe_j_duo", "m_soe_j_trio", "m_soe_j_family", "m_soe_j_order", "m_soe_j_tribe", "m_soe_j_stuntman", "m_soe_j_invisible", "m_soe_j_brainstorm", "m_soe_j_satellite", "m_soe_j_shoot_the_moon", "m_soe_j_drivers_license", "m_soe_j_cartomancer", "m_soe_j_astronomer", "m_soe_j_burnt", "m_soe_j_bootstraps", "m_soe_j_caino", "m_soe_j_triboulet", "m_soe_j_yorick", "m_soe_j_chicot", "m_soe_j_perkeo"}
SMODS.PokerHand {
    key = "joker_central",
    name = "Joker Central",
    above_hand = abovehand,
    visible = false,
    chips = 250,
    mult = 250,
    l_chips = 25,
    l_mult = 10,
    example = {
        { "S_2", true, enhancement = "m_soe_j_joker" },
        { "S_2", true, enhancement = "m_soe_j_perkeo" },
        { "S_2", true, enhancement = "m_soe_j_joker" },
        { "S_2", true, enhancement = "m_soe_j_perkeo" },
        { "S_2", true, enhancement = "m_soe_j_perkeo" },
    },
    evaluate = function(parts)
        return parts.soe_jc_orig
    end,
}
  
SMODS.PokerHandPart {
    key = 'jc_orig',
    func = function(hand)
        if #hand < 5 then return {} end
        local ret = {}
        local jokers = 0
        for i = 1, #hand do
            local v = hand[i].base.value
            if v then
                if table.contains(vanilla_jokers_as_enhanced, hand[i].config.center.key) and jokers < 5 then
                jokers = jokers + 1
                table.insert(ret, hand[i])
                end
            end
        end
        if jokers >= 5 and #ret >= 5 then
            return { ret }
        else
            return {}
        end
    end
}

SMODS.Consumable {
	set = "Planet",
	key = "demjoker",
	config = {hand_type = "soe_joker_central", softlock = true},
	pos = {x = 0, y = 0},
	atlas = "Planets",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("soe_hand_joker_central"),
				G.GAME.hands["soe_joker_central"].level,
				G.GAME.hands["soe_joker_central"].l_mult,
				G.GAME.hands["soe_joker_central"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["soe_joker_central"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_big(math.min(7, G.GAME.hands["soe_joker_central"].level)):to_number()]
					),
				},
			},
		}
	end,
}

SMODS.PokerHand {
    key = "nil",
    name = "nil",
    above_hand = "soe_joker_central",
    visible = false,
    chips = 50,
    mult = 25,
    l_chips = 12,
    l_mult = 12,
    example = {
        { "C_T", false},
        { "S_Q", false},
        { "H_8", false},
        { "S_J", false},
        { "C_3", false},
    },
    evaluate = function(parts)
        return parts.soe_nil_orig
    end,
}

SMODS.PokerHandPart {
    key = 'nil_orig',
    func = function(hand)
        if #SMODS.find_card('j_soe_reversesplash') > 0 then
            local ret = {}
            local cards = 0
            for i = 1, #hand do
                cards = cards + 1
                table.insert(ret, hand[i])
            end
            if cards > 0 and #ret > 0 then
                return { ret }
            else
                return {}
            end
        else
            return {}
        end
    end
}

function string.starts(string, start)
    return string.sub(string, 1, string.len(start)) == start
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
function Card:calculate_seal(context, ischecking)
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
        if self.seal == 'soe_rainbowseal' then
            if self.ability.set == 'Joker' then
                if self.edition and context.individual and context.cardarea == G.hand then
                    if self.edition.key == 'e_holo' then
                        SMODS.calculate_effect({
                            mult = 10,
                            colour = G.C.DARK_EDITION,
                            card = self,
                        })
                    elseif self.edition.key == 'e_polychrome' then
                        SMODS.calculate_effect({
                            x_mult = 1.5,
                            colour = G.C.DARK_EDITION,
                            card = self,
                        })
                    elseif self.edition.key == 'e_foil' then
                        SMODS.calculate_effect({
                            chips = 50,
                            colour = G.C.DARK_EDITION,
                            card = self,
                        })
                    end
                end
            end
        end
        if self.seal == 'soe_reverseseal' then
            if context.joker_main and context.cardarea == G.jokers and self.facing == 'back' then
                SMODS.calculate_effect({
                    x_mult = 3,
                    colour = G.C.MULT,
                    card = self
                })
            end
        end
        if self.seal == 'soe_carmineseal' then
            if context.before then
                self.oymatearyescored = false
            end
            if context.post_trigger and context.other_card == self then
                self.oymatearyescored = true
            end
            if context.after and not self.oymatearyescored and not self.ability.eternal then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        self:start_dissolve()
                        return true
                    end,
                }))
            end
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
                if not self.ability.eternal then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.2,
                        func = function()
                            self:start_dissolve()
                            return true
                        end,
                    }))
                end
            end
            if self.seal == 'cry_green' then
                if context.before then
                    self.oymatearyescored = false
                end
                if context.post_trigger and context.other_card == self then
                    self.oymatearyescored = true
                end
                if not self.oymatearyescored and context.after then
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
        if next(SMODS.find_mod('aikoyorisshenanigans')) then
            if self.seal == 'akyrs_debuff' then
                self.debuff = true
            else
                self.debuff = false
            end
        end
        if next(SMODS.find_mod("familiar")) then
            if self.seal == "fam_maroon_seal" then
                if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == G.jokers.cards[1] then
                    return {
                        repetitions = 1,
                        card = G.jokers.cards[1]
                    }
                end
            end
            if self.seal == "fam_sapphire_seal" then
                if context.end_of_round and context.main_eval then
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        SMODS.add_card({set = 'Spectral', area = G.consumeables})
                        SMODS.calculate_effect({message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral, card = self}, self)
                    end
                end
            end
            if self.seal == "fam_gilded_seal" then
                if context.post_trigger and context.other_card == self then
                    if pseudorandom('gilded_seal') < G.GAME.probabilities.normal/4 then
                        SMODS.calculate_effect({dollars = -5, card = self}, self)
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 5
                        G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    else
                        SMODS.calculate_effect({dollars = 5, card = self}, self)
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 5
                        G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    end
                end
            end
            if self.seal == "fam_familiar_seal" then
                if context.selling_self and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    SMODS.add_card({set = 'Familiar_Tarots', area = G.consumeables})
                    SMODS.calculate_effect({message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot, card = self}, self)
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
        if self.seal == 'soe_reverseseal' then
            if context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) and self.facing == 'back' then
                return {
                    x_mult = 3,
                    colour = G.C.MULT,
                    card = self
                }
            end
        end
        if self.seal == 'soe_rainbowseal' then
        end
        if self.seal == 'soe_carmineseal' then
            if context.cardarea == 'unscored' and context.destroy_card and context.destroy_card == self then
                return {
                    remove = true,
                }
            end
        end
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
    --[[
    if not ischecking and self.extraseals then
        local flags
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self then
            flags = {
                repetitions = 1,
                card = self,
            }
        end
        local eval = flags
        if eval then
            for k, v in pairs(self.extraseals) do
                for i = 1, #self[v..'sealcount'] do
                    eval.extra = flags
                    eval = eval and type(eval) == 'table' and eval.extra or {}
                end
            end
            return eval
        end
    end
    ]]
    if not (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then return nil end
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

local smodsoldcalccontext = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    local g = smodsoldcalccontext(context, return_table)
    --[[
    if context.individual and context.cardarea == G.hand then
        for k, v in pairs(context.scoring_hand) do
            if v.seal == 'soe_rainbowseal' then
                if pseudorandom('rainbowseal') < G.GAME.probabilities.normal / 4 then
                    if v.edition and v.edition.key == 'e_foil' then
                        return {
                            chips = 50,
                            colour = G.C.DARK_EDITION,
                            card = context.other_card,
                        }
                    end
                    if v.edition and v.edition.key == 'e_holo' then
                        return {
                            mult = 10,
                            colour = G.C.DARK_EDITION,
                            card = context.other_card,
                        }
                    end
                    if v.edition and v.edition.key == 'e_polychrome' then
                        return {
                            x_mult = 1.5,
                            colour = G.C.DARK_EDITION,
                            card = context.other_card,
                        }
                    end
                end
            end
        end
    end
    ]]
    return g
end

SEALS.nojokercalculate = function(context)
    --[[
    if context.individual and context.other_card.ability.set == "Joker" and not context.end_of_round and context.cardarea == G.play then
        local target = SMODS.add_card({key = context.other_card.config.center.key})
        local eval = target:calculate_joker({joker_main = true, cardarea = G.jokers, full_hand = context.full_hand, scoring_hand = context.scoring_hand})
        target.getting_sliced = true
        target:start_dissolve()
        SMODS.calculate_effect(eval, context.other_card)
    end
    ]]
    if context.individual and context.cardarea == G.play then
        if context.other_card.ability.legallysleeve == 'Plasma' then
            local tot = hand_chips + mult
            if not tot.array or #tot.array < 2 or tot.array[2] < 2 then --below eXeY notation
				hand_chips = mod_chips(math.floor(tot / 2))
				mult = mod_mult(math.floor(tot / 2))
			else
				if hand_chips > mult then
					tot = hand_chips
				else
					tot = mult
				end
				hand_chips = mod_chips(tot)
				mult = mod_chips(tot)
			end
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
    
            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('k_balanced')
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  4.3,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  6.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
        end
    end
end

local oldstartdissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.ability.eternal and self.playing_card then return nil end
    return oldstartdissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

local oldshatter = Card.shatter
function Card:shatter()
    if self.ability.eternal and self.playing_card then return nil end
    return oldshatter(self)
end

local oldcalcjoker = Card.calculate_joker
function Card:calculate_joker(context)
    local g = oldcalcjoker(self, context)
    if context.end_of_round and context.cardarea == G.jokers then
        if self.ability.legallyenhanced == "Gold" then
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
        if self.ability.legallyenhanced == "Mult" then
            return {
                mult = 4,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyenhanced == "Bonus" then
            return {
                chips = 30,
                colour = G.C.CHIPS,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyenhanced == "Lucky" then
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
        if self.ability.legallyenhanced == "Steel" then
            return {
                xmult = 1.5,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
        if self.ability.legallyenhanced == "Glass" then
            return {
                xmult = 2,
                colour = G.C.MULT,
                card = self,
                message_card = self
            }
        end
    end
    if context.after then
        if self.ability.legallyenhanced == "Glass" then
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
            if self.ability.legallyenhanced == "Mult" then
                return {
                    mult = 4,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallyenhanced == "Bonus" then
                return {
                    chips = 30,
                    colour = G.C.CHIPS,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallyenhanced == "Lucky" then
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
            if self.ability.legallyenhanced == "Steel" then
                return {
                    xmult = 1.5,
                    colour = G.C.MULT,
                    card = self,
                    message_card = self
                }
            end
            if self.ability.legallyenhanced == "Glass" then
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
    if context.joker_main and context.cardarea == G.jokers and self.ability.legallysleeve == 'Plasma' then
        local tot = hand_chips + mult
        if not tot.array or #tot.array < 2 or tot.array[2] < 2 then --below eXeY notation
            hand_chips = mod_chips(math.floor(tot / 2))
            mult = mod_mult(math.floor(tot / 2))
        else
            if hand_chips > mult then
                tot = hand_chips
            else
                tot = mult
            end
            hand_chips = mod_chips(tot)
            mult = mod_chips(tot)
        end
        update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})

        G.E_MANAGER:add_event(Event({
            func = (function()
                local text = localize('k_balanced')
                play_sound('gong', 0.94, 0.3)
                play_sound('gong', 0.94*1.5, 0.2)
                play_sound('tarot1', 1.5)
                ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                attention_text({
                    scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    delay =  4.3,
                    func = (function() 
                            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                            ease_colour(G.C.UI_MULT, G.C.RED, 2)
                        return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    blocking = false,
                    no_delete = true,
                    delay =  6.3,
                    func = (function() 
                        G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                        G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                        return true
                    end)
                }))
                return true
            end)
        }))
    end
    return g
end

local oldclick = Card.click
function Card:click()
    local g = oldclick(self)
    if (self.config.center.key == 'v_soe_blueprint' or self.config.center.key == 'v_soe_brainstorm') and self.area ~= G.shop_vouchers and self.area ~= G.shop_jokers and self.area ~= G.shop_booster and not table.contains(G.your_collection, self.area) and not (G.blueprintvoucherchoosecardarea and G.blueprintvoucherchoosecardarea.cards and G.blueprintvoucherchoosecardarea.cards[1]) then
        G.SETTINGS.paused = true
        G.ownerofblueprintvoucherchoosecardarea = self.config.center.key
        G.blueprintvoucherchoosecardarea = CardArea(
            G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
            G.ROOM.T.h,
            5.3 * G.CARD_W,
            1.03 * G.CARD_H,
            { card_limit = 5, type = "title", highlight_limit = 0, collection = true }
        )
        local used_vouchers = {
            n = G.UIT.R,
            config = { align = "cm", padding = 0, no_fill = true },
            nodes = {
                { n = G.UIT.O, config = { object = G.blueprintvoucherchoosecardarea } },
            },
        }
        for i = 1, #G.vouchers.cards do
            if G.vouchers.cards[i].config.center.key ~= "v_soe_brainstorm" and G.vouchers.cards[i].config.center.key ~= "v_soe_blueprint" then
                SMODS.add_card({set = 'Vouchers', area = G.blueprintvoucherchoosecardarea, key = G.vouchers.cards[i].config.center.key})
            end
        end
        G.UIBOXGENERICOPTIONSBLUEPRINTVOUCHER = create_UIBox_generic_options({
            back_func = "run_info",
            snap_back = true,
            contents = {
                {
                    n = G.UIT.R,
                    config = {align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05},
                    nodes = {used_vouchers},
                },
            },
        })
        G.FUNCS.overlay_menu({
            definition = G.UIBOXGENERICOPTIONSBLUEPRINTVOUCHER,
        })
    end
    if self.area == G.blueprintvoucherchoosecardarea and self.ability.set == "Voucher" and G.blueprintvoucherchoosecardarea and G.blueprintvoucherchoosecardarea.cards and G.blueprintvoucherchoosecardarea.cards[1] and self.config.center.key ~= G.ownerofblueprintvoucherchoosecardarea then
        G.GAME["old"..G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"] = G.GAME[G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"]
        G.GAME[G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"] = self.config.center.key
        G.FUNCS.run_info()
        if G.GAME["old"..G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"] or not G.vouchers.cards[G.GAME[G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"]] then
            local other_old_voucher = G.vouchers.cards[G.GAME["old"..G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"]]
            if other_old_voucher then
                other_old_voucher:unapply_to_run(nil, true)
            end
        end
        self:apply_to_run(nil, true)
    end
    return g
end

function SEALS.safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

SMODS.Voucher{
    key = 'blueprint',
    cost = 10,
    atlas = 'BlueprintVouchers',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {SEALS.safe_get(G.localization.descriptions, "Voucher", G.GAME.blueprintvouchertocopy or "ddfjvgbjbfjvbnfbcmvd", "name") or "Nothing"}}
    end,
    calculate = function(self, card, context)
        if G.GAME.blueprintvouchertocopy then
            local other_voucher
            for k, v in pairs(G.vouchers.cards) do
                if v.config.center.key == G.GAME.blueprintvouchertocopy then
                    other_voucher = v
                    break
                end
            end
            if other_voucher then
                local center = other_voucher.config.center
                if center.calculate and type(center.calculate) == 'function' then
                    local o, t = center:calculate(other_voucher, context)
                    if o or t then return o, t end
                end
            else
                G.GAME.blueprintvouchertocopy = nil
            end
        end
    end
}

SMODS.Voucher{
    key = 'brainstorm',
    cost = 10,
    atlas = 'BlueprintVouchers',
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {SEALS.safe_get(G.localization.descriptions, "Voucher", G.GAME.brainstormvouchertocopy or "ddfjvgbjbfjvbnfbcmvd", "name") or "Nothing"}}
    end,
    calculate = function(self, card, context)
        local other_voucher
        for k, v in pairs(G.vouchers.cards) do
            if v.config.center.key == G.GAME.brainstormvouchertocopy then
                other_voucher = v
                break
            end
        end
        if other_voucher then
            local center = other_voucher.config.center
            if center.calculate and type(center.calculate) == 'function' then
                local o, t = center:calculate(other_voucher, context)
                if o or t then return o, t end
            end
        end
    end
}


function SEALS.recursive_extra(table_return_table, index)
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

SMODS.Joker{
    name = 'ReverseSplash',
    key = 'reversesplash',
    atlas = 'Placeholders',
    pos = {x = 0, y = 0},
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
}

local oldstartrun = Game.start_run
function Game:start_run(args)
    local g = oldstartrun(self, args)
    if SEALS.find_mod("YGGDRASIL") and SkillTreePerks then
        local jokerupgradessec = "soe_skill_tree_jokerupgrades"
        if not check_if_section_exist(jokerupgradessec) then
            SkillTreePerks[jokerupgradessec] = {
                {
                    {text = "JIM1", perk_id = "soe_jimbo_upgrade1", max_cap = 1, cost = 10},
                    {text = "JIM2", perk_id = "soe_jimbo_upgrade2", max_cap = 1, requirement = {"soe_jimbo_upgrade1"}, cost = 30},
                    {text = "JIM3", perk_id = "soe_jimbo_upgrade3", max_cap = 1, requirement = {"soe_jimbo_upgrade2"}, cost = 45},
                    {text = "JIM4", perk_id = "soe_jimbo_upgrade4", max_cap = 1, requirement = {"soe_jimbo_upgrade3"}, cost = 60},
                    {text = "JIM5", perk_id = "soe_jimbo_upgrade5", max_cap = 1, requirement = {"soe_jimbo_upgrade4"}, cost = 500},
                },
                {
                    {text = "EGG1", perk_id = "soe_egg_upgrade1", max_cap = 1, cost = 30},
                    {text = "EGG2", perk_id = "soe_egg_upgrade2", max_cap = 1, requirement = {"soe_egg_upgrade1"}, cost = 50},
                    {text = "EGG3", perk_id = "soe_egg_upgrade3", max_cap = 1, requirement = {"soe_egg_upgrade2"}, cost = 60},
                    {text = "EGG4", perk_id = "soe_egg_upgrade4", max_cap = 1, requirement = {"soe_egg_upgrade3"}, cost = 75},
                    {text = "EGG5", perk_id = "soe_egg_upgrade5", max_cap = 1, requirement = {"soe_egg_upgrade4"}, cost = 90},
                },
            }
            add_new_section(jokerupgradessec)
        end
    end
    G.jokers.config.highlighted_limit = 1000
    return g
end

if SEALS.find_mod("YGGDRASIL") then
    SMODS.Joker:take_ownership('j_joker',
        {
            loc_vars = function(self,info_queue,card)
                card.ability.extra = card.ability.extra or {}
                local key
                if SEALS.find_mod("YGGDRASIL") and if_skill_obtained then
                    if if_skill_obtained("soe_jimbo_upgrade2") then
                        key = self.key.."_u"
                    end
                end
                return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.xmult}, key = key}
            end,
            update = function(self,card,dt)
                if SEALS.find_mod("YGGDRASIL") and if_skill_obtained then
                    card.ability.mult = 0
                    card.ability.extra = {}
                    local multamount
                    local xmultamount
                    local chipsamount
                    if if_skill_obtained("soe_jimbo_upgrade5") then
                        chipsamount = 1
                        xmultamount = 1.5
                        multamount = 0
                    elseif if_skill_obtained("soe_jimbo_upgrade4") then
                        multamount = 10
                        chipsamount = 15
                        xmultamount = 1
                    elseif if_skill_obtained("soe_jimbo_upgrade3") then
                        multamount = 7
                        chipsamount = 10
                        xmultamount = 1
                    elseif if_skill_obtained("soe_jimbo_upgrade2") then
                        multamount = 5
                        chipsamount = 5
                        xmultamount = 1
                    elseif if_skill_obtained("soe_jimbo_upgrade1") then
                        multamount = 5
                        chipsamount = 0
                        xmultamount = 1
                    else
                        multamount = 4
                        chipsamount = 0
                        xmultamount = 1
                    end
                    card.ability.extra.chips = chipsamount
                    card.ability.extra.mult = multamount
                    card.ability.extra.xmult = xmultamount
                end
            end,
        },
        true
    )
end

SMODS.Joker:take_ownership('j_egg',
    {
        update = function(self,card,dt)
            if SEALS.find_mod("YGGDRASIL") and if_skill_obtained then
                local moneyincrease
                if if_skill_obtained("soe_egg_upgrade4") then
                    moneyincrease = 15
                elseif if_skill_obtained("soe_egg_upgrade2") then
                    moneyincrease = 8
                elseif if_skill_obtained("soe_egg_upgrade1") then
                    moneyincrease = 5
                else
                    moneyincrease = 3
                end
                card.ability.extra = moneyincrease
            end
        end,
        calc_dollar_bonus = function (self, card)
            if SEALS.find_mod("YGGDRASIL") and if_skill_obtained then
                if if_skill_obtained("soe_egg_upgrade3") then
                    if (pseudorandom('egg') < G.GAME.probabilities.normal / (if_skill_obtained("ygg_egg_upgrade5") and 2 or 4)) or (if_skill_obtained("soe_egg_upgrade5") and G.GAME.blind.boss) then
                        return card.sell_cost
                    end
                end
            end
        end
    },
    true
)

SMODS.Joker{
    name = 'AscendedJoker',
    key = 'ascendedjoker',
    atlas = 'JokerEnhancements',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1000, y = 1000},
    rarity = 4,
    cost = 30,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        frames = {
            xlevels = 0,
            ylevels = 0
        },
        extra = {
            mult = 4,
            suitmult = 3,
            mpair = 8,
            mtoak = 12,
            mtwopair = 10,
            mstraight = 12,
            mflush = 10,
            cpair = 50,
            ctoak = 100,
            ctwopair = 80,
            cstraight = 100,
            cflush = 80,
            halfmult = 20,
            xmult = 1,
            normretriggers = 1,
            chadretriggers = 2,
            debt = 20,
            chips = 0,
            mystic = 15,
            loyaltyremaining = 5,
            freerolls = 1,
            fibmult = 8,
            scarychips = 30,
            evenmult = 4,
            oddchips = 31,
            scholar = {chips = 20, mult = 4},
            businessodds = 2,
            businessmoney = 2,
            ridethebusgain = 1,
            spaceodds = 4,
            eggsellgain = 3,
            burglarhands = 3,
            blackboardxmult = 3,
            runnergain = 15,
            runnerchips = 0,
            icecreamchips = 100,
            icecreamloss = 5,
            bluechips = 2,
            constellationgain = 0.1,
            hikerchips = 5,
            facelessmoney = 5,
            greengainloss = 1,
            todomoney = 4,
            cavendish = 3,
            cardsharp = 3,
            redcardgain = 3,
            madnessgain = 0.5,
            squaregain = 4,
            vampiregain = 0.1,
            hologramgain = 0.25,
            vagabondmoney = 4,
            baronxmult = 1.5,
            cloudninemoney = 1,
            money = 0,
            rocketgain = 1,
            obeliskgain = 0.2,
            photoxmult = 2,
            giftmoney = 1,
            turtlebean = {handsize = 5, loss = 1},
            erosiongain = 4,
            reservedparkingmoney = 1,
            maininrebatemoney = 5,
            tothemoongain = 1, 	
            hallucinationodds = 2,
            fortunegain = 1,
            juggler = 1,
            drunkard = 1,
            stonejokergain = 25,
            luckycatgain = 0.25,
            baseballxmult = 1.5,
            bullchips = 2,
            tradingcardmoney = 3,
            flashcardgain = 2,
            popcornloss = 4,
            pantsgain = 2,
            ancientxmult = 1.5,
            ramen = {xmult = 2, loss = 0.01},
            walkie = {chips = 10, mult = 4},
            seltzerhandsleft = 10,
            isseltzerdranken = false,
            castlegain = 3,
            smileymult = 5,
            campfiregain = 0.25,
            goldenticketmoney = 4,
            mrbonesrequire = 0.25,
            acrobatxmult = 3,
            troubadour = {handsize = 2, hands = 1},
            throwbackgain = 0.25,
            roughgemmoney = 1,
            bloodstone = {odds = 2, xmult = 1.5},
            arrowheadchips = 50,
            onyxagatemult = 7,
            glassgain = 0.75,
            flowerxmult = 3,
            weegain = 8,
            merryandy = {discards = 3, handsize = 1},
            idolxmult = 2,
            seeingdoublexmult = 2,
            matadormoney = 8,
            hittheroadgain = 0.5,
            duoxmult = 2,
            trioxmult = 3,
            familyxmult = 4,
            orderxmult = 3,
            tribexmult = 2,
            stuntman = {chips = 250, handsize = 2},
            invisiblerounds = 2,
            satelitegain = 1,
            shootthemoonmult = 13,
            driverslicensexmult = 3,
            bootstraps = {mult = 2, dollars = 5},
            cainogain = 1,
            tribouletxmult = 2,
            yorickgain = 1,
        }
    },
    add_to_deck = function (self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.drunkard + card.ability.extra.merryandy.discards
        ease_discard(card.ability.extra.drunkard + card.ability.extra.merryandy.discards)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.debt
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v*2
        end
        SMODS.change_free_rerolls(1)
        calculate_reroll_cost(true)
        G.hand:change_size(card.ability.extra.turtlebean.handsize)
        G.GAME.interest_amount = G.GAME.interest_amount + 1
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
            return true
        end }))
        G.hand:change_size(card.ability.extra.troubadour.handsize)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.troubadour.hands
        G.hand:change_size(-card.ability.extra.stuntman.handsize)
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.drunkard - card.ability.extra.merryandy.discards
        ease_discard(card.ability.extra.drunkard + card.ability.extra.merryandy.discards)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v/2
        end
        SMODS.change_free_rerolls(-1)
        calculate_reroll_cost(true)
        G.hand:change_size(-card.ability.extra.turtlebean.handsize)
        G.GAME.interest_amount = G.GAME.interest_amount - 1
        G.E_MANAGER:add_event(Event({func = function()
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
            return true
        end }))
        G.hand:change_size(-card.ability.extra.troubadour.handsize)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.troubadour.hands
        G.hand:change_size(card.ability.extra.stuntman.handsize)
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            --[[
            local my_pos
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i; break end
            end
            if my_pos and G.jokers.cards[my_pos+1] and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced and not context.blueprint then 
                local sliced_card = G.jokers.cards[my_pos+1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    card.children.center:set_sprite_pos({x = 5, y = 5})
                    G.GAME.joker_buffer = 0
                    card.ability.extra.mult = card.ability.extra.mult + sliced_card.sell_cost*2
                    card:juice_up(0.8, 0.8)
                    sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                    play_sound('slice1', 0.96+math.random()*0.08)
                return true end }))
                card_eval_status_text(card, 'extra', card, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult+2*sliced_card.sell_cost}}, colour = G.C.RED, no_juice = true})
            end
            ]]
            --[[
            local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local card = Card(G.discard.T.x + G.discard.T.w/2, G.discard.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.children.center:set_sprite_pos({x = 3, y = 2})
                    card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                    G.play:emplace(card)
                    table.insert(G.playing_cards, card)
                    return true
                end}))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced})
            ]]
        end
        if context.ending_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.children.center:set_sprite_pos({x = 7, y = 8})
                    return true
                end
            }))
            local eligibleJokers = {}
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.consumeable then
                    eligibleJokers[#eligibleJokers + 1] = G.consumeables.cards[i]
                end
            end
            if #eligibleJokers > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = copy_card(pseudorandom_element(eligibleJokers, pseudoseed('perkeo')), nil)
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        card.ability.qty = 1
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                return nil, true
            end
            return
        end
        if context.joker_main and context.cardarea == G.jokers then
            SMODS.calculate_effect({mult = card.ability.extra.mult, card = card}, card)
            if next(context.poker_hands["Pair"]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 2, y = 0})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.mpair, card = card}, card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 0, y = 14})
                        return true
                    end
                }))
                SMODS.calculate_effect({chips = card.ability.extra.cpair, card = card}, card)
            end
            if next(context.poker_hands["Three of a Kind"]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 3, y = 0})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.mtoak, card = card}, card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 1, y = 14})
                        return true
                    end
                }))
                SMODS.calculate_effect({chips = card.ability.extra.ctoak, card = card}, card)
            end
            if next(context.poker_hands["Two Pair"]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 4, y = 0})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.mtwopair, card = card}, card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 2, y = 14})
                        return true
                    end
                }))
                SMODS.calculate_effect({chips = card.ability.extra.ctwopair, card = card}, card)
            end
            if next(context.poker_hands["Straight"]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 5, y = 0})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.mstraight, card = card}, card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 3, y = 14})
                        return true
                    end
                }))
                SMODS.calculate_effect({chips = card.ability.extra.cstraight, card = card}, card)
            end
            if next(context.poker_hands["Flush"]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 6, y = 0})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.mflush, card = card}, card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 4, y = 14})
                        return true
                    end
                }))
                SMODS.calculate_effect({chips = card.ability.extra.cflush, card = card}, card)
            end
            if #context.full_hand < 3 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 7, y = 0})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.halfmult, card = card}, card)
            end
            if G.GAME.current_round.discards_left == 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 2, y = 2})
                        return true
                    end
                }))
                SMODS.calculate_effect({mult = card.ability.extra.mystic, card = card}, card)
            end
            return nil, true
        end
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:is_suit("Hearts") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 7, y = 1})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({mult = card.ability.extra.suitmult, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Diamonds") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 6, y = 1})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({mult = card.ability.extra.suitmult, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Spades") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 8, y = 1})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({mult = card.ability.extra.suitmult, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Clubs") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 9, y = 1})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({mult = card.ability.extra.suitmult, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Diamonds") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 9, y = 7})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({dollars = card.ability.extra.roughgemmoney, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Spades") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 1, y = 8})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({chips = card.ability.extra.arrowheadchips, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Clubs") then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 2, y = 8})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({mult = card.ability.extra.onyxagatemult, card = context.other_card}, card)
                end
                if context.other_card:is_suit("Hearts") and pseudorandom('bloodstone') < G.GAME.probabilities.normal/card.ability.extra.bloodstone.odds then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 0, y = 8})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({x_mult = card.ability.extra.bloodstone.xmult, card = context.other_card}, card)
                end
                if context.other_card:get_id() == 12 or context.other_card:get_id() == 13 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card.children.center:set_sprite_pos({x = 4, y = 8})
                            return true
                        end
                    }))
                    SMODS.calculate_effect({x_mult = card.ability.extra.tribouletxmult, card = context.other_card}, card)
                end
                return nil, true
            end
            if context.cardarea == G.hand then
                if not context.end_of_round then
                    if context.other_card:get_id() == 12 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card.children.center:set_sprite_pos({x = 2, y = 6})
                                return true
                            end
                        }))
                        if context.other_card.debuff then
                            return {
                                message = localize('k_debuffed'),
                                colour = G.C.RED,
                                card = card,
                            }
                        else
                            return {
                                mult = card.ability.extra.shootthemoonmult,
                                card = card
                            }
                        end
                    end
                    if context.other_card:get_id() == 13 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card.children.center:set_sprite_pos({x = 6, y = 12})
                                return true
                            end
                        }))
                        if context.other_card.debuff then
                            return {
                                message = localize('k_debuffed'),
                                colour = G.C.RED,
                                card = card,
                            }
                        else
                            return {
                                x_mult = card.ability.extra.baronxmult,
                                card = card
                            }
                        end
                    end
                end
            end
        end
        if context.repetition then
            if context.cardarea == G.hand then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 4, y = 1})
                        return true
                    end
                })) 
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.normretriggers,
                    card = card,
                }
            end
            if context.cardarea == G.play then
                local retriggeramount = 0
                if not card.ability.extra.isseltzerdranken then
                    retriggeramount = retriggeramount + card.ability.extra.normretriggers
                end
                if context.other_card:is_face() then
                    retriggeramount = retriggeramount + card.ability.extra.normretriggers
                end
                if context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4 or context.other_card:get_id() == 5 then
                    retriggeramount = retriggeramount + card.ability.extra.normretriggers
                end
                if G.GAME.current_round.hands_left == 0 then
                    retriggeramount = retriggeramount + card.ability.extra.normretriggers
                end
                if context.other_card == context.scoring_hand[1] then
                    retriggeramount = retriggeramount + card.ability.extra.chadretriggers
                end
                return {
                    message = localize('k_again_ex'),
                    repetitions = retriggeramount,
                    card = card,
                }
            end
        end
        if context.after then
            if card.ability.extra.seltzerhandsleft - 1 <= 0 and not card.ability.extra.isseltzerdranken then
                card.ability.extra.seltzerhandsleft = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 3, y = 15})
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.4)
                        return true
                    end
                })) 
                SMODS.calculate_effect({message = localize('k_drank_ex'), colour = G.C.FILTER}, card)
                card.ability.extra.isseltzerdranken = true
            elseif not card.ability.extra.isseltzerdranken then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.children.center:set_sprite_pos({x = 3, y = 15})
                        return true
                    end
                }))
                card.ability.extra.seltzerhandsleft = card.ability.extra.seltzerhandsleft - 1
                SMODS.calculate_effect({message = card.ability.extra.seltzerhandsleft..'', colour = G.C.FILTER}, card)
            end
        end
    end,
    update = function(self, card, dt)
        if card.children.center.sprite_pos and card.children.center.sprite_pos.x >= 3 and card.children.center.sprite_pos.x <= 7 and card.children.center.sprite_pos.y == 8 then
            card.children.floating_sprite:set_sprite_pos({x = card.children.center.sprite_pos.x, y = card.children.center.sprite_pos.y + 1})
        elseif card.children.center.sprite_pos and card.children.center.sprite_pos.x == 4  and card.children.center.sprite_pos.y == 12 then
            card.children.floating_sprite:set_sprite_pos({x = 2, y = 9})
        else
            card.children.floating_sprite:set_sprite_pos({x = 1000, y = 1000})
        end
        --[[
        anim = {}
        if not anim.t then anim.t = 0 end
        anim.t = anim.t + dt
        if anim.t > 1/(anim.fps or 10) then
            anim.t = anim.t - 1/(anim.fps or 10)
            next_frame = true
        end
        ]]
        --[[
        if true then
            card.ability.frames.xlevels = card.ability.frames.xlevels + 0.1
            if card.ability.frames.ylevels >= 9 and card.ability.frames.ylevels < 10 then
                card.ability.frames.ylevels = 10
            end
            if card.ability.frames.xlevels >= 9 then
                card.ability.frames.ylevels = card.ability.frames.ylevels + 0.1
            end
            if card.ability.frames.xlevels >= 10 then
                card.ability.frames.xlevels = 0
            end
            if card.ability.frames.ylevels >= 15 then
                card.ability.frames.xlevels = 0
                card.ability.frames.ylevels = 0
            end
            card.children.center:set_sprite_pos({x = math.floor(card.ability.frames.xlevels), y = math.floor(card.ability.frames.ylevels)})
        end
        ]]
    end,
    in_pool = function(self)
        return false
    end
}

--[[
SMODS.Joker{
    name = 'Seeder',
    key = 'seeder',
    atlas = 'Placeholders',
    pos = {x = 2, y = 0},
    rarity = 3,
    cost = 15,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            seed = "2K9H9HN",
            runnable = true
        }
    },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.seed}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
            if not card.ability.extra.runnable then
                card.ability.extra.runnable = true
                return {
                    message = localize('k_reset'),
                }
            end
        end
        if context.using_consumeable and card.ability.extra.runnable then
            G.ENTERED_SEED = ""
            G.E_MANAGER:add_event(Event({
				blockable = false,
				func = function()
					G.REFRESH_ALERTS = true
					return true
				end,
			}))
			G.UIBOXGENERICOPTIONSREALLYSEED = create_UIBox_generic_options({
				no_back = true,
				colour = HEX("04200c"),
				outline_colour = G.C.SECONDARY_SET.Code,
				contents = {
					{
						n = G.UIT.R,
						nodes = {
							create_text_input({
								colour = G.C.SET.Code,
								hooked_colour = darken(copy_table(G.C.SET.Code), 0.3),
								w = 4.5,
								h = 1,
								max_length = 8,
								extended_corpus = true,
								prompt_text = "ENTER A SEED",
								ref_table = G,
								ref_value = "ENTERED_SEED",
								keyboard_offset = 1,
							}),
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							UIBox_button({
								colour = G.C.SET.Code,
								button = "seed_apply",
								label = {"SEED"},
								minw = 4.5,
								focus_args = { snap_to = true },
							}),
						},
					},
				},
			})
            G.UIBOXFORSEED = UIBox({
                definition = G.UIBOXGENERICOPTIONSREALLYSEED,
                config = {
                    align = "cm",
                    offset = { x = 0, y = 10 },
                    major = G.ROOM_ATTACH,
                    bond = "Weak",
                    instance_type = "POPUP",
                },
            })
            G.UIBOXFORSEED.alignment.offset.y = 0
            G.ROOM.jiggle = G.ROOM.jiggle + 1
            G.UIBOXFORSEED:align_to_major()
            G.FUNCS.seed_apply = function()
                G.ENTERED_SEED = string.upper(G.ENTERED_SEED) or "r"
                card.ability.extra.runnable = false
                card.ability.extra.seed = G.ENTERED_SEED
                G.GAME.pseudorandom.seed = G.ENTERED_SEED
                G.GAME.pseudorandom.hashed_seed = pseudohash(G.GAME.pseudorandom.seed)
                G.UIBOXFORSEED:remove()
            end
        end
    end,
    in_pool = function(self)
        return false
    end
}
]]

--[[
if Bakery_API and Bakery_API.Charm then
    Bakery_API.Charm {
        key = 'sealcharm',
        atlas = 'Charms',
        pos = {x = 0, y = 0},
        config = {},
        loc_vars = function(self, info_queue, card) end,
        calculate = function(self, card, context) end, -- Works just like a Joker
        check_for_unlock = function(self, args) end,
        equip = function(self, card) 
            G.GAME.red_seal_number = 2
            G.GAME.gold_seal_dollar = 6
        end, -- Called when the charm is purchased
        unequip = function(self, card)
            G.GAME.red_seal_number = 1
            G.GAME.gold_seal_dollar = 3
        end, -- Called when a new charm is purchased that replaces this one
    }
end
]]


for k, v in pairs(G.P_CENTER_POOLS.Consumeables) do
    SEALS.all_consumables = SEALS.all_consumables or {}
    table.insert(SEALS.all_consumables, v.key)
    SEALS.all_consumable_jokers = SEALS.all_consumable_jokers or {}
    table.insert(SEALS.all_consumable_jokers, "j_soe_"..v.key.."joker")
end

for k, v in pairs(G.P_CENTERS) do
    local name = v.name
    if v.set == 'Planet' and v.config.hand_type then
        SMODS.Joker{
            key = v.key .. 'joker',
            atlas = v.atlas or 'Tarots',
            pos = v.pos,
            rarity = 3,
            loc_txt = {
                name =  name .. ' Joker',
                text = {
                    "If played {C:attention}poker hand{} is",
                    "{C:attention}#1#{}",
                    "Upgrade played hand",
                },
            },
            cost = 10,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
            perishable_compat = true,
            loc_vars = function(self, info_queue, card)
                return {vars = {v.config.hand_type}}
            end,
            calculate = function(self, card, context)
                if context.before and context.scoring_name == v.config.hand_type then
                    return {
                        level_up = 1,
                        card = card,
                        message = localize('k_level_up_ex'),
                    }
                end
            end,
        }
    end
end

SMODS.Joker{
    name = 'TalismanJoker',
    key = 'c_talismanjoker',
    atlas = 'Tarots',
    pos = {x = 3, y = 4},
    rarity = 3,
    cost = 10,
    boostershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        local free = false
        if context.before then
            for k, v in pairs(context.scoring_hand) do
                if IsEligibleForSeal(v) then
                    free = true
                    break
                end
            end
            if not free then
                return {
                    message = localize('k_nope_ex'),
                    card = card,
                }
            end
            local randomcard = {}
            while not IsEligibleForSeal(randomcard) do
                randomcard = pseudorandom_element(context.scoring_hand, pseudoseed('talisman'))
            end
            if randomcard then
                return {
                    message = 'Talisman!',
                    card = card,
                    randomcard:set_seal('Gold')
                }
            end
        end
    end,
}

--[[
SMODS.Joker{
    name = 'TheSoulJoker',
    key = 'thesouljoker',
    atlas = 'Tarots',
    pos = {x = 2, y = 2},
    rarity = 3,
    cost = 10,
    boostershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before then
            return {
                message = localize('k_nope_ex'),
                card = card,
            }
        end
    end,
}
]]

--[[
SMODS.DrawStep{
    key = 'thesoulpos',
    order = 20,
    func = function(self)
        if self.config.center.key == 'thesouljoker' then
            local scale_mod = 0.05 + 0.05*math.sin(1.8*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
            
            local sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["soe_Enhancers"], {x = 0, y = 1})
            sprite.role.draw_major = self
            sprite:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
            sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
        end
    end
}
]]

SMODS.Joker{
    name = 'BlankJoker',
    key = 'v_blankjoker',
    atlas = 'Vouchers',
    pos = {x = 7, y = 0},
    rarity = 3,
    cost = 10,
    vouchershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            roundsleft = 20
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.roundsleft}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra.roundsleft = card.ability.extra.roundsleft - 1
            if card.ability.extra.roundsleft <= 0 then
                card:set_ability(G.P_CENTERS.j_soe_antimatterjoker)
            else
                return {
                    message = 'Doing nothing...',
                    sound = 'holo1'
                }
            end
        end
    end,
}

SMODS.Joker{
    name = 'AntimatterJoker',
    key = 'v_antimatterjoker',
    atlas = 'Vouchers',
    pos = {x = 7, y = 1},
    rarity = 4,
    cost = 10,
    negativeshader = true,
    unlocked = true,
    discovered = true,
    no_doe = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            weightmult = 105,
            xmult = 1.2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.weightmult}}
    end,
    calculate = function(self, card, context)
        if (context.other_joker and context.other_joker.edition and context.other_joker.edition.key == 'e_negative') or (context.other_consumeable and context.other_consumeable.edition and context.other_consumeable.edition.key == 'e_negative') or (context.individual and context.other_card.edition and context.other_card.edition.key == 'e_negative' and not context.end_of_round) then
            return {
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT,
                message = 'Negative!!',
                card = card,
            }
        end
    end,
    in_pool = function(self)
        return false
    end
}

local oldenegativegetweight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership('e_negative', {
    get_weight = function(self)
        local weight = oldenegativegetweight(self)
        if #SMODS.find_card('j_soe_v_antimatterjoker') > 0 then
            weight = weight * G.P_CENTERS.j_soe_v_antimatterjoker.config.extra.weightmult * #SMODS.find_card('j_soe_v_antimatterjoker')
        end
        return weight
    end
}, true)

SMODS.DrawStep{
    key = 'boostershader',
    order = 20,
    func = function(self)
        if self.config.center.boostershader then
            self.children.center:draw_shader('booster',nil, self.ARGS.send_to_shader)
        end
    end
}

SMODS.DrawStep{
    key = 'vouchershader',
    order = 20,
    func = function(self)
        if self.config.center.vouchershader then
            self.children.center:draw_shader('voucher',nil, self.ARGS.send_to_shader)
        end
    end
}

local unorganizedrarity
if cryptidyeohna then
    unorganizedxmult = 2.2
    unorganizedrarity = 'cry_epic'
else
    unorganizedrarity = 3
    unorganizedxmult = 1.5
end

SMODS.Joker{
    name = 'UnorganizedJoker',
    key = 'unorganizedjoker',
    atlas = 'Placeholders',
    pos = {x = 3, y = 0},
    rarity = unorganizedrarity,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = unorganizedxmult
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if (context.other_joker and (context.other_joker.seal or context.other_joker.ability.legallyenhanced or context.other_joker.ability.legallysleeve)) or (context.other_consumeable and context.other_consumeable.seal) then
            return {
                x_mult = card.ability.extra.xmult,
                colour = G.C.MULT,
                card = context.other_joker or context.other_consumeable
            }
        end
        if context.individual then
            for k, v in pairs(SMODS.Stickers) do
                if context.other_card.ability[k] then
                    return {
                        x_mult = card.ability.extra.xmult,
                        colour = G.C.MULT,
                        card = context.other_card
                    }
                end
            end
        end
    end,
}

--[[
SMODS.Joker{
    name = 'KingofHeartsCardJoker',
    key = 'kingofheartscardjoker',
    atlas = 'PlayingCards',
    pos = {x = 11, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
            local kingcontext = {cardarea = G.play, main_scoring = true, other_card = context.other_card}
            local eval, post = eval_card(context.other_card, kingcontext)
            for k, v in pairs(eval) do
                if type(v) == 'table' then
                    for k, v in pairs(v) do
                        eval[k] = v
                    end
                end
            end
            return eval
        end
    end,
    in_pool = function(self)
        return false
        end
}
]]

SMODS.Joker{
    name = 'ExtraLife',
    key = 'extralife',
    atlas = 'ExtraLife',
    pos = {x = 0, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    no_collection = true,
    config = {
        lives = 1
    },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.lives}}
    end,
    calculate = function(self, card, context)
        if context.game_over then
            card.ability.lives = card.ability.lives - 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    if card.ability.lives < 1 then
                        card:start_dissolve()
                    end
                    return true
                end
            })) 
            return {
                saved = "Life Used!",
                colour = G.C.RED
            }
        end
    end,
    in_pool = function(self)
        return false
    end,
    add_to_deck = function (self, card, from_debuff)
        if #SMODS.find_card('j_soe_extralife') > 0 then
            for k, v in pairs(G.jokers.cards) do
                if v.config.center.key == 'j_soe_extralife' then
                    v.ability.lives = (v.ability.lives or 0) + 1
                    break
                end
            end
            card:start_dissolve()
        end
        if cryptidyeohna then
            card.ability.cry_absolute = true
        else
            card.ability.eternal = true
        end
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

if cryptidyeohna then
    SMODS.Joker{
        name = 'ThinkingEmoji',
        key = 'thinkingemoji',
        atlas = 'Think',
        pos = {x = 0, y = 0},
        soul_pos = {x = 1, y = 0},
        config = {extra = {emult_mod = 0.2, idea_count = 19}},
        rarity = "cry_exotic",
        cost = 62,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.emult_mod, card.ability.extra.emult or (1 + (card.ability.extra.emult_mod * card.ability.extra.idea_count))}}
        end,
        calculate = function(self, card, context)
            if context.joker_main and context.cardarea == G.jokers then
                card.ability.extra.emult = 1 + (card.ability.extra.emult_mod * card.ability.extra.idea_count)
                return {
                    emult = card.ability.extra.emult,
                    colour = G.C.DARK_EDITION
                }
            end
        end
    }
end

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
    hidden = true,
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
    end,
    in_pool = function(self)
        if (#SMODS.find_card("j_soe_infinityred") > 0 and #SMODS.find_card("j_soe_infinitygold") > 0 and #SMODS.find_card("j_soe_infinityblue") > 0 and #SMODS.find_card("j_soe_infinitypurple") > 0) then
            return true
        end
        return false
    end
}

local infinityrarity
if SEALS.find_mod('jen') then
    infinityrarity = 'jen_omegatranscendent'
else
    infinityrarity = 'soe_infinity'
end

if cryptidyeohna then
    SEALS.randomconsumeable = Cryptid.random_consumable
else
    function SEALS.randomconsumeable(seed, excluded_flags, banned_card, pool, no_undiscovered)
        -- set up excluded flags - these are the kinds of consumables we DON'T want to have generating
        excluded_flags = excluded_flags or { "hidden", "no_doe", "no_grc" }
        local selection = "n/a"
        local passes = 0
        local tries = 500
        while true do
            tries = tries - 1
            passes = 0
            -- create a random consumable naively
            local key = pseudorandom_element(pool or G.P_CENTER_POOLS.Consumeables, pseudoseed(seed or "grc")).key
            selection = G.P_CENTERS[key]
            -- check if it is valid
            if selection.discovered or not no_undiscovered then
                for k, v in pairs(excluded_flags) do
                    if not selection.config.center[v] then
                        --Makes the consumable invalid if it's a specific card unless it's set to
                        --I use this so cards don't create copies of themselves (eg potential inf Blessing chain, Hammerspace from Hammerspace...)
                        if not banned_card or (banned_card and banned_card ~= key) then
                            passes = passes + 1
                        end
                    end
                end
            end
            if passes >= #excluded_flags or tries <= 0 then
                if tries <= 0 and no_undiscovered then
                    return G.P_CENTERS["c_strength"]
                else
                    return selection
                end
            end
        end
    end
end



SMODS.Joker{
    name = 'TheInfinitySeal',
    key = 'theinfinityseal',
    atlas = 'Placeholders',
    pos = {x = 0, y = 1},
    rarity = infinityrarity,
    cost = 2147483647,
    config = {
        extra = {
            dollars = 30,
            retriggers = 3,
            negativeblackholes = 2,
            negativeconsumables = 3
        }
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    dangerous = true,
    perishable_compat = false,
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_black_hole
        return {vars = {card.ability.extra.dollars, card.ability.extra.retriggers, card.ability.extra.negativeblackholes, card.ability.extra.negativeconsumables, colours = {sealoverlords}}}
    end,
    calculate = function(self, card, context)
        if (context.individual and (context.cardarea == G.play or context.cardarea == G.hand)) or context.other_joker or context.other_consumeable then
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.0,
                func = function()
                    for i = 1, card.ability.extra.negativeblackholes do
                        SMODS.add_card({set = 'Spectral', area = G.consumeables, key = 'c_black_hole', edition = 'e_negative'})
                    end
                    for i = 1, card.ability.extra.negativeconsumables do
                        local forced_key = SEALS.randomconsumeable("theinfinityseal"..i)
                        SMODS.add_card({set = 'Consumeables', area = G.consumeables, key = forced_key.key, edition = 'e_negative'})
                    end
                    return true
                end,
            }))
            return {
                dollars = card.ability.extra.dollars,
                colour = G.C.MONEY,
                card = context.other_card,
            }
        end
        if context.repetition then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.retriggers,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.0,
                        func = function()
                            juice_up_game()
                            return true
                        end,
                    }))
                end,
                card = card,
            }
        end
    end,

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

SMODS.Seal{
    key = 'rainbowseal',
    name = 'RainbowSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    draw = function(self, card, layer)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('polychrome', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

SMODS.Seal{
    key = 'reverseseal',
    name = 'ReverseSeal',
    badge_colour = G.C.UI.TEXT_DARK,
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {extra = {downxmult = 3}},
    loc_vars = function (self, info_queue, card)
        return {vars = {self.config.extra.downxmult}}
    end
}

SMODS.Seal{
    key = 'negativeseal',
    name = 'NegativeSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = { x = 6, y = 4 },
    draw = function(self, card, layer)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('negative', nil, card.ARGS.send_to_shader, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('negative_shine', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

SMODS.Seal{
    key = 'carmineseal',
    name = 'CarmineSeal',
    badge_colour = HEX('FF0040'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
}

SEALS.has_seal = function(card, seal)
    if card.seal == seal then
        return true
    end
    if table.contains(card.extraseals, seal) then
        return true
    end
    return false
end

--[[
SMODS.Seal{
    key = 'aquaseal',
    name = 'AquaSeal',
    badge_colour = HEX('00FFFF'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
}
]]

SMODS.Seal{
    key = 'yellowseal',
    name = 'YellowSeal',
    badge_colour = HEX('F7AF38'),
    atlas = 'Enhancers',
    pos = {x = 2, y = 0},
}

local oldhighlight = Card.highlight
function Card:highlight(highlighted)
    local g = oldhighlight(self, highlighted)
    if self.seal == "soe_negativeseal" then
        if not highlighted and self.config.negative_enabled then
            self.config.negative_enabled = false
            G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1 
        end
    end
    return g
end

local oldaddhighlighted = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if card.seal == "soe_negativeseal" and not card.config.negative_enabled then
        card.config.negative_enabled = true
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 1 
    end
    return oldaddhighlighted(self, card, silent)
end

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

SEALS.toNormalString = function(a) --Convert stylized strings to normal strings.
    local returnStr = a

    local start_search = false
    local search_result = ""
    local every_result = {}

    local start_var_search = false
    local var_search_result = ""
    local every_var_result = {}

    for i = 1, #returnStr do
        local character = string.sub(returnStr,i,i)
        
        if start_search then
            search_result = search_result..character
            if character == "}" then
                every_result[#every_result+1] = search_result
                start_search = false
            end
        end

        if start_var_search then
            var_search_result = var_search_result..character
            if character == "#" then
                every_var_result[#every_var_result+1] = var_search_result
                start_var_search = false
            end
        end

        if character == "{" and not start_search then start_search = true; search_result = "{" end
        if character == "#" and not start_var_search then start_var_search = true; var_search_result = "#" end
    end

    if #every_result > 0 then
        for _,search in ipairs(every_result) do
            returnStr = string.gsub(returnStr, search, "", 1)
        end
    end

    if #every_var_result > 0 then
        for _,search in ipairs(every_var_result) do
            returnStr = string.gsub(returnStr, search, "?", 1)
        end
    end

    return returnStr
end

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
            local tempstring
            if deckkey and G.P_CENTERS[deckkey] and type(G.P_CENTERS[deckkey]) == "table" then
            self.config = G.P_CENTERS[deckkey].config
                tempstring = ""
            for k, v in pairs(G.localization.descriptions.Back[deckkey].text) do
                repeat
                    if string.sub(v,1,1) == " " then v = string.sub(v,2,#v) end
                until string.sub(v,1,1) ~= " "
                repeat
                    if string.sub(v,#v,#v) == " " then v = string.sub(v,1,#v-1) end
                until string.sub(v,#v,#v) ~= " "
                if v ~= "" then tempstring = tempstring .. SEALS.toNormalString(v) .. " " end
            end

            if tempstring then tempstring = string.sub(tempstring,1,#tempstring-1) end

            end
            return {vars = {tempstring or "Nothing"}, key = key}
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

--[[
oldcheckforunlock = check_for_unlock
function check_for_unlock(args)
    if args.type == 'win_stake' then 
        G.PROGRESS.card_stickers = G.PROGRESS.card_stickers or {tally = 0, of = 0}
        if G.PROGRESS.card_stickers.tally/G.PROGRESS.card_stickers.of >= 1 then
            unlock_achievement('completionist_plus_plus_plus')
        end
    end
    return oldcheckforunlock(args)
end
]]

if SEALS.find_mod("JokerDisplay") then
    SEALS.config_tab = function()
        return {
            n = G.UIT.ROOT,
            config = {
                align = "cl",
                minh = G.ROOM.T.h * 0.25,
                padding = 0.0,
                r = 0.1,
                colour = G.C.GREY,
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = "cm",
                        minw = G.ROOM.T.w * 0.25,
                        padding = 0.05,
                    },
                    nodes = {
                        create_toggle({
                            label = "Enable JokerDisplay on Non-Jokers (Quite unstable!)",
                            ref_table = SEALS.config,
                            ref_value = "nonjokerdisplay",
                        }),
                    },
                },
            },
        }
    end
end

local oldupdate = Card.update
function Card:update(dt)
    if G.GAME and G.GAME.hands and G.GAME.hands["soe_nil"] and G.GAME.hands["soe_nil"].played and G.GAME.hands["soe_nil"].played > 0 then
        G.GAME.hands["soe_nil"].visible = false
        G.GAME.hands["soe_nil"].played = 0
    end
    if not SEALS.config.nonjokerdisplay and self.joker_display_values and self.ability and self.ability.set ~= 'Joker' then
        self.joker_display_values.disabled = true
    end
    for i, v in ipairs(SEALS.all_consumables) do
        if self.config.center.key == v then
            if self.area == G.jokers then
                self:set_ability(G.P_CENTERS[SEALS.all_consumable_jokers[i]])
            end
        end
    end
    for i, v in ipairs(SEALS.all_consumable_jokers) do
        if self.config.center.key == v then
            if self.area == G.consumeables then
                self:set_ability(G.P_CENTERS[SEALS.all_consumables[i]])
            end
        end
    end
    if (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal') or (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_soe_seal') then
        local seals = {}
        for k, v in pairs(G.P_SEALS) do
            table.insert(seals, k)
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

SMODS.Joker:take_ownership('j_mr_bones',
    {
        calculate = function(self, card, context)
            if context.game_over and G.GAME.chips/G.GAME.blind.chips >= to_big(0.25) and not context.retrigger_joker then
                local g
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        if card.seal == 'Red' then
                            g = 'Extra Life!'
                            local f = SMODS.add_card({set = 'Joker', area = G.jokers, key = 'j_soe_extralife', edition = 'e_negative'})
                            f.ability.lives = 0
                        end
                        return true
                    end
                }))
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED,
                    extra = {
                        message = g,
                        colour = G.C.RED
                    }
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

local oldmainmenu = Game.main_menu
Game.main_menu = function(change_context)
    G.shared_secondseals = {Red = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_SecondSeals"], {x = 5, y = 4})}
    G.shared_jokerenhancements = {Bonus = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 1, y = 1}), Mult = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 2, y = 1}), Wild = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 3, y = 1})}
    G.shared_sleeves = {Plasma = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_VanillaSleeves"], {x = 3, y = 2})}
    G.shared_jokerfronts = {}
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        if not v.mod then
            G.shared_jokerfronts[v.key] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_JokerFronts"], v.pos or {x = 0, y = 0})
        end
    end
    return oldmainmenu(change_context)
end

SMODS.DrawStep{
    key = 'secondsealsforall',
    order = 11,
    func = function(self, card)
        if self.extraseal == 'Red' and not (#SMODS.find_card("j_soe_sealjoker") > 0) then
            G.shared_secondseals[self.extraseal].role.draw_major = self
            G.shared_secondseals[self.extraseal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.DrawStep{
    key = 'threeenhancementsforjokers',
    order = 10,
    func = function(self, card)
        if self.ability.legallyenhanced and (self.ability.legallyenhanced == "Mult" or self.ability.legallyenhanced == "Bonus" or self.ability.legallyenhanced == "Wild") then
            G.shared_jokerenhancements[self.ability.legallyenhanced].role.draw_major = self
            G.shared_jokerenhancements[self.ability.legallyenhanced]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.DrawStep{
    key = 'sleevesforjokersandplayingcards',
    order = 10,
    func = function(self, card)
        if self.ability.legallysleeve then
            G.shared_sleeves[self.ability.legallysleeve].role.draw_major = self
            G.shared_sleeves[self.ability.legallysleeve]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.DrawStep{
    key = 'therestenhancementsforvanillajokers',
    order = 10,
    func = function(self, card)
        if self.ability.legallyenhanced and not (self.ability.legallyenhanced == "Mult" or self.ability.legallyenhanced == "Bonus" or self.ability.legallyenhanced == "Wild") and G.P_CENTERS[self.config.center.key] and not G.P_CENTERS[self.config.center.key].mod then
            if not self.oldatlas or not self.oldpos then
                self.oldatlas = self.children.center.atlas
                self.oldpos =  self.children.center.sprite_pos
            end
            self.children.center.atlas = G.ASSET_ATLAS["soe_Enhancers"]
            if self.ability.legallyenhanced == "Lucky" then
                self.children.center:set_sprite_pos(G.P_CENTERS.m_lucky.pos)
            end
            if self.ability.legallyenhanced == "Steel" then
                self.children.center:set_sprite_pos(G.P_CENTERS.m_steel.pos)
        end
            if self.ability.legallyenhanced == "Glass" then
                self.children.center:set_sprite_pos(G.P_CENTERS.m_glass.pos)
            end
            if self.ability.legallyenhanced == "Gold" then
                self.children.center:set_sprite_pos(G.P_CENTERS.m_gold.pos)
            end
            G.shared_jokerfronts[self.config.center.key].role.draw_major = self
            G.shared_jokerfronts[self.config.center.key]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        elseif self.oldatlas and self.oldpos then
            self.children.center.atlas = self.oldatlas
            self.children.center:set_sprite_pos(self.oldpos)
            self.oldatlas = nil
            self.oldpos = nil
        end
    end,
    conditions = {vortex = false, facing = 'front'},
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
        if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and G.playing_cards and self.facing == 'front' then
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

SMODS.DrawStep{
    key = 'reversesealonback',
    order = 14,
    func = function(self, card)
        if (self.seal == 'soe_reverseseal' or ((G and G.GAME and G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_soe_theseal') and self.seal)) and self.facing == 'back' then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
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
    dollars = 8,
    boss = {min = 1, max = 10, showdown = true},
    boss_colour = HEX('E8463D'),
    stay_flipped = function (self, area, card)
        return area == G.hand
    end,
    set_blind = function (self)
        for k, v in pairs(G.jokers.cards) do
            if v.facing == 'front' then
                v:flip()
            end
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.facing == 'front' then
                v:flip()
            end
        end
    end,
    defeat = function (self)
        for k, v in pairs(G.jokers.cards) do
            if v.facing == 'back' then
                v:flip()
            end
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.facing == 'back' then
                v:flip()
            end
        end
    end,
    disable = function (self)
        for k, v in pairs(G.jokers.cards) do
            if v.facing == 'back' then
                v:flip()
            end
        end
        for k, v in pairs(G.consumeables.cards) do
            if v.facing == 'back' then
                v:flip()
            end
        end
    end
}

SMODS.Keybind{
    key_pressed = '-',
    held_keys = {'lshift'},
    event = 'pressed',
    action = function(self)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
            local joker = G.jokers.highlighted[1]
            if not joker.ability.legallyenhanced then
                print('Highlighted joker is not enhanced')
            end
            if joker.ability.legallyenhanced == "Gold" then
                print('Highlighted joker is enhanced with gold')
            end
            if joker.ability.legallyenhanced == "Steel" then
                print('Highlighted joker is enhanced with steel')
            end
            if joker.ability.legallyenhanced == "Mult" then
                print('Highlighted joker is enhanced with mult')
            end
            if joker.ability.legallyenhanced == "Bonus" then
                print('Highlighted joker is enhanced with bonus')
            end
            if joker.ability.legallyenhanced == "Lucky" then
                print('Highlighted joker is enhanced with lucky')
            end
            if joker.ability.legallyenhanced == "Glass" then
                print('Highlighted joker is enhanced with glass')
            end
            if joker.ability.name == 'StoneCardJoker' then
                print('You cannot be serious right now, but this is a stone')
            end
        end
    end
}
