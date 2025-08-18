SMODS.Atlas{
    key = 'What',
    path = 'What.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Confusion',
    path = 'Confusion.png',
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
    key = 'Synonyms',
    path = 'Synonyms.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'VoucherSynonyms',
    path = 'Vouchersynonyms.png',
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
    key = 'RainbowSeal',
    path = 'rainbowseal.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'SealsIndividual',
    path = 'SealsIndividual.png',
    px = 27,
    py = 27
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

SMODS.Atlas{
    key = 'Prints',
    path = 'Prints.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Blinds',
    path = 'Blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Sound{
    key = 'synonymmusic',
    path = 'synonymmusicmain.ogg',
    sync = true,
    select_music_track = function()
        return not SEALS.config.synonymmusicdisable and (G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'soe_Synonym' and 2e12) or nil
    end
}

SMODS.Sound{
    key = 'laes_dlog',
    path = 'laes_dlog.ogg',
}

SMODS.Font {
    key = "11x6m",
    path = "11x6m.ttf",
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.83,
    TEXT_OFFSET = { x = 10, y = 0 },
    FONTSCALE = 0.1,
    squish = 1,
    DESCSCALE = 1
}

SEALS = SMODS.current_mod

SEALS.no_marquee = true
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
    if ((not card.seal) or ((G.GAME.selected_sleeve and G.GAME.selected_sleeve == "sleeve_soe_seal" and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) and not #SEALS.get_seals(card, true) > 0) or (next(SMODS.find_card('j_soe_sealjoker')) or next(SMODS.find_card('j_soe_sealjoker2')))) and (card.config and card.config.center.key ~= 'j_soe_sealjoker' and card.config.center.key ~= 'j_soe_sealjoker2') then
        return true
    end
    return false
end

function SEALS.get_seal_limit(card)
    local limit = 1
    if (G.GAME and G.GAME.selected_sleeve and G.GAME.selected_sleeve == "sleeve_soe_seal" and (G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal')) then
        limit = limit + 1
    end
    if SMODS.find_card('j_soe_sealjoker') and SMODS.find_card('j_soe_sealjoker2') then
        limit = 1.7976e308
    end
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

local oldwingame = win_game
function win_game()
    if not G.GAME.seeded and not G.GAME.challenge then
        set_card_win()
    end
    return oldwingame()
end

local function juice_up_game()
    local animtimer = 50
    while animtimer > 0 do
        local x, y, displayindex = love.window.getPosition()
        local d_width, d_height = love.window.getDesktopDimensions( displayindex )
        local w_width, w_height, flags = love.window.getMode( )
        animtimer = animtimer - 0.5
        local m_width = d_width - w_width
        local m_height = d_height - w_height
        if not flags.fullscreen then
            love.window.setPosition( (math.sin( animtimer ) + 1) / 7 * (m_width - 224) + 112, (math.cos( animtimer ) + 1) / 7 * (m_height - 224) + 112)
        end
    end
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
                        highlighted:set_seal("Red", nil, true)
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
                        highlighted:set_seal("Blue", nil, true)
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
                        highlighted:set_seal("Gold", nil, true)
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
                        highlighted:set_seal("Purple", nil, true)
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
                            highlighted:set_seal("cry_azure", nil, true)
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
                            highlighted:set_seal("cry_green", nil, true)
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
                        SEALS.set_joker_enhancement(highlighted, G.P_CENTERS.m_gold)
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
                        SEALS.set_joker_enhancement(highlighted, G.P_CENTERS.m_steel)
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
                        SEALS.set_joker_enhancement(highlighted, G.P_CENTERS.m_mult)
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
                        SEALS.set_joker_enhancement(highlighted, G.P_CENTERS.m_bonus)
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
                        SEALS.set_joker_enhancement(highlighted, G.P_CENTERS.m_lucky)
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
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or next(SMODS.find_card('j_soe_sealjoker2')) then
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
                        SEALS.set_joker_enhancement(highlighted, G.P_CENTERS.m_glass)
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
                        SMODS.Stickers["eternal"]:apply(highlighted, true)
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
            if IsEligibleForSeal(v) and v ~= card then
                eligible[#eligible + 1] = v
            end
        end
        return #eligible > 0 and true or false
    end,
    use = function(self,card,area,copier)
        local eligible = {}
        for k, v in pairs(G.consumeables.cards) do
            if IsEligibleForSeal(v) and v ~= card then
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
                        highlighted:set_seal("Red", nil, true)
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
        elseif G.GAME.blind.in_blind then
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

function SEALS.get_closest_card(card, fromred)
    local points = {}
    local function calculate_distance(point1, point2)
        return math.sqrt((point2[1] - point1[1])^2 + (point2[2] - point1[2])^2)
    end
    local function find_closest_point(target_point, points)
        local min_distance = math.huge
        local closest_point = nil
        for i = 1, #points do
            local distance = calculate_distance(target_point, points[i])
            if distance < min_distance then
                min_distance = distance
                closest_point = points[i]
            end
        end
        return closest_point
    end
    local target_point = {card.T.x + card.T.w/2, card.T.y + card.T.h/2}
    for i, v in ipairs(G.I.CARD) do
        if v ~= card and v.area then
            if fromred then v.ability.soe_has_Red = nil end
            table.insert(points, {v.T.x + v.T.w/2, v.T.y + v.T.h/2, card = v})
        end
    end
    local closest_point = find_closest_point(target_point, points)
    if closest_point and closest_point.card then
        if fromred then closest_point.card.ability.soe_has_Red = true end
        return closest_point.card
    end
end

local oldcardstopdrag = Card.stop_drag
function Card:stop_drag()
    local g = oldcardstopdrag(self)
    if G.STAGE == G.STAGES.RUN then
        if self and self.ability and self.ability.soe_detached_seal == 'Red' then
            self.ability.extra.card = SEALS.get_closest_card(self, true).sort_id
        end
    end
    return g
end

SEALS.detached_seals = {
    Red = {
        config = {extra = {retriggers = 1}},
        calculate = function(self, card, context)
            if context.press_play then
                G.soe_event_scoring = true
                card.ability.extra.card = SEALS.get_closest_card(card, true).sort_id
            end
            if context.after then
                SEALS.event(function() G.soe_event_scoring = nil; return true end)
            end
            if card.ability.extra.card and (context.retrigger_joker_check or context.repetition) and context.other_card and context.other_card.area and context.other_card.is and context.other_card:is(Card) and context.other_card.sort_id == card.ability.extra.card then
                return {repetitions = card.ability.extra.retriggers, message = localize('k_again_ex')}
            end
        end,
        loc_vars = function(self, card)
            return {vars = {card.ability.extra.retriggers}}
        end
    },
    Blue = {
        calculate = function(self, card, context)
            if (context.end_of_round and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
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
                    end
                }))
                return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
            end
        end
    },
    Gold = {
        config = {extra = {dollars = 3}},
        calculate = function(self, card, context)
            if context.before or context.forcetrigger then
                return {dollars = card.ability.extra.dollars, card = card}
            end
        end,
        loc_vars = function(self, card)
            return {vars = {card.ability.extra.dollars}}
        end
    },
    Purple = {
        calculate = function(self, card, context)
            if (context.pre_discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        SMODS.add_card({set = 'Tarot', key_append = '8ba'})
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {message = localize('k_plus_tarot'), colour = G.C.PURPLE}
            end
        end
    }
}

for k, v in pairs(SEALS.detached_seals) do
    v.key = k
    v.config = v.config or {}
    v.set = "Seal"
    v.original_seal = G.P_SEALS[k] or {}
    v.original_key = v.original_seal.original_key
    v.mod = SEALS
    v.original_mod = SEALS
end

local oldgeneratecardui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local old = {set = _c.set, key = _c.key}
    if card and card.ability and card.ability.soe_detached_seal then
        card_type = "Seal"
        _c.set = 'soe_DetachedSeal'
        _c.key = card.ability.soe_detached_seal
    end
    local g = oldgeneratecardui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if card and card.ability and card.ability.soe_detached_seal then
        localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = g.main, vars = (SEALS.detached_seals[_c.key].loc_vars and SEALS.detached_seals[_c.key]:loc_vars(card).vars) or {}}
        _c.set = old.set
        _c.key = old.key
    end
    return g
end

local oldfuncsselfreroll = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop()
    local g = oldfuncsselfreroll()
    if G.GAME.rerollbuttonseal == "Gold" then
        ease_dollars(3)
    elseif G.GAME.rerollbuttonseal == "Red" then
        oldfuncsselfreroll()
    elseif G.GAME.rerollbuttonseal == "Blue" then
    elseif G.GAME.rerollbuttonseal == "Purple" then
    end
    return g
end

SMODS.ObjectType{
    key = "soe_Synonyms",
    default = "c_soe_idiot"
}

SMODS.ObjectType{
    key = "soe_Infinity",
    cards = {
        j_soe_infinityred = true,
        j_soe_infinityblue = true,
        j_soe_infinitygold = true,
        j_soe_infinitypurple = true,
        j_soe_sealjoker = true,
    },
}

local oldsmodscreatecard = SMODS.create_card
function SMODS.create_card(t)
    if not t.area and t.set == "soe_Synonyms" then
        t.area = G.consumeables
    end
    return oldsmodscreatecard(t)
end

local oldeventmanageraddevent = EventManager.add_event
function EventManager:add_event(event, queue, front)
    if event:is(Event) and G.GAME then
        if G.GAME.triggered_enhancement or G.GAME.triggered_joker then
            local card, key, g
            local triggered = G.GAME.triggered_enhancement or G.GAME.triggered_joker
            for k, v in ipairs(G.I.CARD) do
                if v.sort_id == triggered[1] then
                    card, key = v, triggered[2]
                end
            end
            local oldeventfunc = event.func
            event.func = function()
                local old_ability = copy_table(card.ability)
                local old_center = card.config.center
                local old_center_key = card.config.center_key
                SEALS.safe_set_ability(card, G.P_CENTERS[key])
                g = oldeventfunc()
                card.ability = old_ability
                card.config.center = old_center
                card.config.center_key = old_center_key
                return g
            end
        elseif G.GAME.triggered_edition then
            local card, key, g
            for k, v in ipairs(G.I.CARD) do
                if v.sort_id == G.GAME.triggered_edition[1] then
                    card, key = v, G.GAME.triggered_edition[2]
                end
            end
            local oldeventfunc = event.func
            event.func = function()
                local ed_key = key:sub(3)
                local old_edition = card.edition and copy_table(card.edition) or nil
                local cardedition = {
                    [ed_key] = true,
                    type = ed_key,
                    key = key
                }
                for k, v in pairs(G.P_CENTERS[key].config) do
                    cardedition[k] = copy_table(v)
                end
                card.edition = cardedition
                g = oldeventfunc()
                card.edition = old_edition
                return g
            end
        end
    end
    return oldeventmanageraddevent(self, event, queue, front)
end

local oldcardsetability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites, quantum)
	if not center then
		return nil
	end
	if type(center) == "string" then
		assert(G.P_CENTERS[center], ('Could not find center "%s"'):format(center))
		center = G.P_CENTERS[center]
	end
    if self.playing_card and self.config.center.key ~= "c_base" and not initial and not quantum and not self.soe_from_copy and center and center ~= G.P_CENTERS.c_base and next(SMODS.find_card("j_soe_sealjoker2")) then
        self.ability.soe_quantum_enhancements = self.ability.soe_quantum_enhancements or {}
        table.insert(self.ability.soe_quantum_enhancements, center.key)
        return nil
    end
    local g = oldcardsetability(self, center, initial, delay_sprites)
    if cryptidyeohna then
        if SEALS.safe_get(G, "GAME", "modifiers", "cry_force_seal") then
            self:set_seal(G.GAME.modifiers.cry_force_seal, true, true)
        end
    end
    return g
end

local oldcardsetbase = Card.set_base
function Card:set_base(card, initial)
    if (initial or self.soe_from_copy) or not next(SMODS.find_card("j_soe_sealjoker2")) then return oldcardsetbase(self, card, initial) end
    local newrank = card and card.value and SMODS.Ranks[card.value]
    local newsuit = card and card.suit and SMODS.Suits[card.suit]
    if newrank then
        if self.playing_card and self.base and self.base.id and self.base.id ~= newrank.id and not table.contains(self.ability.soe_quantum_ranks, newrank.key) then
            self.ability.soe_quantum_ranks = self.ability.soe_quantum_ranks or {}
            table.insert(self.ability.soe_quantum_ranks, newrank.key)
        end
    end
    if newsuit then
        if self.playing_card and self.base and self.base.suit and self.base.suit ~= newsuit.key and not table.contains(self.ability.soe_quantum_suits, newsuit.key) then
            self.ability.soe_quantum_suits = self.ability.soe_quantum_suits or {}
            table.insert(self.ability.soe_quantum_suits, newsuit.key)
        end
    end
    if (newsuit or newrank) and (self.base and self.base.value and self.base.suit) then return nil end
    return oldcardsetbase(self, card, initial)
end

local oldcardgetchipbonus = Card.get_chip_bonus
function Card:get_chip_bonus()
    if self and self.base then
        local ranks = SEALS.convert_ids_to_keys(SEALS.get_ids(self))
        table.sort(ranks, function(a, b) return SMODS.Ranks[a].nominal > SMODS.Ranks[b].nominal end)
        self.base.nominal = (SMODS.Ranks[ranks[1]] or {}).nominal or self.base.nominal
    end
    return oldcardgetchipbonus(self)
end

if SEALS.find_mod("aikoyorisshenanigans") then
    function SEALS.get_quantum_letters(card)
        return copy_table(card.ability.soe_quantum_letters or {})
    end

    local oldgetchipmult = Card.get_chip_mult
    function Card:get_chip_mult()
        local g = oldgetchipmult(self)
        for i, v in ipairs(SEALS.get_quantum_letters(self)) do
            if G.GAME.akyrs_letters_mult_enabled then
                g = g + AKYRS.get_scrabble_score(v)
            end
        end
        return g
    end

    local oldgetchipxmult = Card.get_chip_x_mult
    function Card:get_chip_x_mult()
        local g = oldgetchipxmult(self)
        for i, v in ipairs(SEALS.get_quantum_letters(self)) do
            if G.GAME.akyrs_letters_xmult_enabled then
                g = g + (1 + (AKYRS.get_scrabble_score(v) / 10))
            end
        end
        return g
    end
end

local oldcardissuit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
    if self and self.ability and self.ability.soe_quantum_suits then
        for k, v in ipairs(self.ability.soe_quantum_suits) do
            if v == suit then
                return true
            end
        end
    end
    return g
end

local oldisface = Card.is_face
function Card:is_face(from_boss)
    local extra_ranks = self.ability.soe_quantum_ranks or {}
    if next(extra_ranks) then
        for i, v in ipairs(extra_ranks) do
            if SMODS.Ranks[v].face then return true end
        end
    end
    return oldisface(self, from_boss)
end

if Card.is_numbered then
    local oldisnumbered = Card.is_numbered
    function Card:is_numbered(from_boss)
        local extra_ranks = self.ability.soe_quantum_ranks or {}
        if next(extra_ranks) then
            for i, v in ipairs(extra_ranks) do
                if not SMODS.Ranks[v].face then return true end
            end
        end
        return oldisnumbered(self, from_boss)
    end
end

function SEALS.perform_checks(table1, op, table2, mod)
    for i, v in ipairs(table1) do
        for ii, vv in ipairs(table2) do
            if op == "==" and v == vv then return true end
            if op == "~=" and v ~= vv then return true end
            if op == ">" and v > vv then return true end
            if op == ">=" and v >= vv then return true end
            if op == "<" and v < vv then return true end
            if op == "<=" and v <= vv then return true end
            if op == "mod" and v % vv == mod then return true end
        end
    end
    return false
end

local ids_op_ref = ids_op
function ids_op(card, op, b, c)
    local id = card:get_id()
    local other_results = false
    if ids_op_ref ~= nil then
        other_results = ids_op_ref(card, op, b, c)
    end

    local function alias(x)
        local ids = {[id] = true}
        for i, v in ipairs(SEALS.get_ids(card)) do
            ids[v] = true
        end
        if ids[x] then return 11 end
        return x
    end

    if other_results == true then
        return true
    end

    if op == "mod" then
        return SEALS.perform_checks(SEALS.get_ids(card), "mod", {b}, c)
    end

    if op == "==" then
        local lhs = alias(id)
        local rhs = alias(b)
        return lhs == rhs
    end
    if op == "~=" then
        local lhs = alias(id)
        local rhs = alias(b)
        return lhs ~= rhs
    end

    if op == ">=" then return SEALS.perform_checks(SEALS.get_ids(card), ">=", {b}) end
    if op == "<=" then return SEALS.perform_checks(SEALS.get_ids(card), "<=", {b}) end
    if op == ">" then return SEALS.perform_checks(SEALS.get_ids(card), ">", {b}) end
    if op == "<" then return SEALS.perform_checks(SEALS.get_ids(card), "<", {b}) end

    error("ids_op: unsupported op " .. tostring(op))
end

function SEALS.is_ids(card, ids)
    for i, v in ipairs(ids) do
        if ids_op(card, "==", v) then return true end
    end
end

function SEALS.get_ids(card, extra_only)
    local ids = {}
    for i, v in ipairs(card.ability.soe_quantum_ranks or {}) do
        table.insert(ids, SMODS.Ranks[v].id)
    end
    if not extra_only then
        if not table.contains(ids, card:get_id()) then
            table.insert(ids, 1, card:get_id())
        elseif not table.contains(ids, card.base.id) then
            table.insert(ids, 1, card.base.id)
        end
    end
    return ids
end

function SEALS.convert_ids_to_keys(ids)
    local ranks = {}
    for i, v in ipairs(ids) do
        for k, vv in pairs(SMODS.Ranks) do
            if vv.id == v then
                table.insert(ranks, vv.key)
                break
            end
        end
    end
    return ranks
end

local oldgetxsame = get_X_same
function get_X_same(num, hand, or_more)
    local passed = false
    for i, v in ipairs(hand) do
        if next(SEALS.get_ids(v, true)) then
            passed = true
        end
    end
    if not passed then return oldgetxsame(num, hand, or_more) end
    local vals = {}
    for i = 1, SMODS.Rank.max_id.value do
        vals[i] = {}
    end
    vals[#vals + 1] = {}
    for i = #hand, 1, -1 do
        local curr_ranks = SEALS.get_ids(hand[i])
        for _, rank in ipairs(curr_ranks) do
            local curr_group = vals[rank]
            if not curr_group then
                curr_group = {}
                vals[rank] = curr_group
            end
            table.insert(curr_group, hand[i])
        end
    end
    local ret = {}
    for i = #vals, 1, -1 do
        local group = vals[i]
        if #group >= num or (or_more and #group > num) then
            table.insert(ret, group)
        end
    end
    return ret
end

local oldgetstraight = get_straight
function get_straight(hand, min_length, skip, wrap)
    local passed = false
    for i, v in ipairs(hand) do
        if next(SEALS.get_ids(v, true)) then
            passed = true
        end
    end
    if not passed then return oldgetstraight(hand, min_length, skip) end
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    for k, _ in pairs(SMODS.Ranks) do ranks[k] = {} end
    for _, card in ipairs(hand) do
        local card_ids = SEALS.get_ids(card)
        local card_ranks = {}
        for i, v in ipairs(card_ids) do
            for k, vv in pairs(SMODS.Ranks) do
                if vv.id == v then
                    table.insert(card_ranks, vv.key)
                    break
                end
            end
        end
        for _, rank in ipairs(card_ranks) do
            table.insert(ranks[rank], card)
        end
    end
    local function next_ranks(key, start)
        local rank = SMODS.Ranks[key]
        local ret = {}
        if not start and not wrap and rank.straight_edge then return ret end
        for _, v in ipairs(rank.next) do
            ret[#ret + 1] = v
            if skip and (wrap or not SMODS.Ranks[v].straight_edge) then
                for _, w in ipairs(SMODS.Ranks[v].next) do
                    ret[#ret + 1] = w
                end
            end
        end
        return ret
    end
    local tuples = {}
    local ret = {}
    for _, k in ipairs(SMODS.Rank.obj_buffer) do
        if next(ranks[k]) then
            tuples[#tuples + 1] = { k }
        end
    end
    for i = 2, #hand + 1 do
        local new_tuples = {}
        for _, tuple in ipairs(tuples) do
            local any_tuple
            if i ~= #hand + 1 then
                for _, l in ipairs(next_ranks(tuple[i - 1], i == 2)) do
                    if next(ranks[l]) then
                        local new_tuple = {}
                        for _, v in ipairs(tuple) do new_tuple[#new_tuple + 1] = v end
                        new_tuple[#new_tuple + 1] = l
                        new_tuples[#new_tuples + 1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i > min_length and not any_tuple then
                local straight = {}
                for _, v in ipairs(tuple) do
                    for _, card in ipairs(ranks[v]) do
                        straight[#straight + 1] = card
                    end
                end
                ret[#ret + 1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a, b) return #a > #b end)
    return ret
end

local oldsmodstriggereffects = SMODS.trigger_effects
SMODS.trigger_effects = function(effects, card)
    if card and effects and card.sort_id and next(effects) then
        G.GAME.last_trigger_effects = {effects, card.sort_id}
    end
    return oldsmodstriggereffects(effects, card)
end

if SEALS.find_mod("paperback") then
    local oldpbutilremovepaperclip = PB_UTIL.remove_paperclip
    function PB_UTIL.remove_paperclip(card)
        if next(SMODS.find_card("j_soe_sealjoker2")) then return nil end
        return oldpbutilremovepaperclip(card)
    end
end

if SEALS.find_mod("LuckyRabbit") then
    local oldlrutilsetmarking = LR_UTIL.set_marking
    function LR_UTIL.set_marking(card, mark)
        if not next(SMODS.find_card("j_soe_sealjoker2")) then return oldlrutilsetmarking(card, mark) end
        local key = 'fmod_' .. mark .. '_mark'
        if card and LR_UTIL.is_marking(key) then
            SMODS.Stickers[key]:apply(card, true)
        end
    end
end

G.FUNCS.soe_purchaseitems = function(e)
    G.GAME.soe_purchasingitems = true
    G.FUNCS.overlay_menu({definition = SEALS.create_UIBox_your_purchases()})
end

G.FUNCS.soe_can_purchaseitems = function(e)
    if e.config.ref_table:can_sell_card() then
        e.config.colour = G.C.DARK_EDITION
        e.config.button = 'soe_purchaseitems'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.soe_exit_purchaseitems = function(e)
    G.GAME.soe_purchasingitems = nil
    G.FUNCS.exit_overlay_menu()
end

G.FUNCS.soe_exit_purchase_key = function(e)
    if G.CHOOSE_PURCHASE then G.CHOOSE_PURCHASE:remove() end
end

local oldcardinit = Card.init
function Card:init(X, Y, W, H, card, center, params)
    if not G.GAME.soe_purchasingitems then return oldcardinit(self, X, Y, W, H, card, center, params) end
    local g = oldcardinit(self, X, Y, W, H, card, center, params)
    if self.config.center.set == "Partner" and not G.soe_creating_card_during_purchase then
        self.cost = SEALS.get_cost(self.config.center.key)
        create_shop_card_ui(self)
    end
    return g
end

function SEALS.get_cost(key)
    if not key or not G.P_CENTERS[key] then return 0 end
    local center = G.P_CENTERS[key]
    if not G.GAME.soe_purchasingitems then return center.cost or 0 end
    if center.set == "Partner" then
        return 20
    elseif center.set == "Sleeve" or center.set == "Back" then
        return 50
    end
    return center.cost or 0
end

local oldcardsetcost = Card.set_cost
function Card:set_cost()
    if not G.GAME.soe_purchasingitems then return oldcardsetcost(self) end
    local g = oldcardsetcost(self)
    if self.config.center.set == "Partner" then
        self.cost = SEALS.get_cost(self.config.center.key)
    end
    return g
end

local oldcardclick = Card.click
function Card:click()
    if not G.GAME.soe_purchasingitems then return oldcardclick(self) end
    local g = oldcardclick(self)
    if (self.config.center.set == "Sleeve" or (self.config.center.set == "Default" and self.area and self.area.cards[52] == self) or self.config.center.set == "Partner") and not G.soe_creating_card_during_purchase then
        if (to_big(G.GAME.dollars) + to_big(G.GAME.bankrupt_at)) >= to_big(SEALS.get_cost(self.config.center.key)) then
            SEALS.purchase_key(self.config.center.key)
        end
    end
    return g
end

local oldcontrollerkeypressupdate = Controller.key_press_update
function Controller:key_press_update(key, dt)
    if key == "escape" and G.OVERLAY_MENU and G.GAME and G.GAME.soe_purchasingitems then
        G.GAME.soe_purchasingitems = nil
    end
    return oldcontrollerkeypressupdate(self, key, dt)
end

function SEALS.create_UIBox_enter_key()
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end,
    }))
    local t = create_UIBox_generic_options({
        back_func = 'soe_exit_purchase_key',
        colour = HEX("04200c"),
        outline_colour = G.C.DARK_EDITION,
        contents = {
            {
                n = G.UIT.R,
                nodes = {
                    create_text_input({
                        colour = G.C.DARK_EDITION,
                        hooked_colour = darken(copy_table(G.C.DARK_EDITION), 0.3),
                        w = 4.5,
                        h = 1,
                        max_length = 100,
                        extended_corpus = true,
                        prompt_text = "Enter key of Deck"..(SEALS.find_mod("partner") and "/Partner" or "")..(SEALS.find_mod("CardSleeves") and "/Sleeve" or ""),
                        ref_table = G,
                        ref_value = "ENTERED_PURCHASE",
                        keyboard_offset = 1,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    UIBox_button({
                        colour = G.C.DARK_EDITION,
                        button = "soe_purchase_key",
                        label = {"Purchase"},
                        func = "soe_can_purchase_key",
                        minw = 4.5,
                        focus_args = { snap_to = true },
                    }),
                },
            },
        },
    })
    return t
end

G.FUNCS.soe_can_purchase_key = function(e)
    local enteredpurchase = SEALS.convert_to_key(G.ENTERED_PURCHASE)
    if enteredpurchase and G.P_CENTERS[enteredpurchase] and (G.P_CENTERS[enteredpurchase].set == "Back" or G.P_CENTERS[enteredpurchase].set == "Partner" or G.P_CENTERS[enteredpurchase].set == "Sleeve") then
        e.UIBox.definition.nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[1].config.text = "Purchase".." ("..(localize('$')..SEALS.get_cost(enteredpurchase))..")"
        if (to_big(G.GAME.dollars) + to_big(G.GAME.bankrupt_at)) >= to_big(SEALS.get_cost(enteredpurchase)) then
            e.config.colour = G.C.DARK_EDITION
            e.config.button = 'soe_purchase_key'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    else
        e.UIBox.definition.nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[1].config.text = "Purchase"
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

function G.FUNCS.soe_purchase_key(e)
    local enteredpurchase = SEALS.convert_to_key(G.ENTERED_PURCHASE)
    if enteredpurchase and G.P_CENTERS[enteredpurchase] then
        SEALS.purchase_key(enteredpurchase)
    end
end

function G.FUNCS.soe_purchase_all(e)
    for i, v in ipairs(G.P_CENTER_POOLS.Back) do
        SEALS.purchase_key(v.key)
    end
end

function SEALS.convert_to_key(string, onlydecksandsleeves)
    string = string and type(string) == "string" and string:lower() or nil
    if not string then return nil end
    if onlydecksandsleeves == nil then onlydecksandsleeves = true end
    if G.P_CENTERS[string] or (not onlydecksandsleeves and (G.P_SEALS[string] or G.P_BLINDS[string] or SMODS.Stickers[string])) then return string end
    for k, v in pairs(G.localization.descriptions) do
        for kk, vv in pairs(v) do
            if (G.P_CENTERS[kk] or (not onlydecksandsleeves and (G.P_SEALS[kk] or G.P_BLINDS[kk] or SMODS.Stickers[kk]))) and vv.name and type(vv.name) == "string" and vv.name:lower() == string then return kk end
        end
    end
    for i, v in ipairs({G.P_SEALS, G.P_BLINDS, SMODS.Stickers, G.P_CENTERS}) do
        for k, vv in pairs(v) do
            if v.name and type(v.name) == "string" and v.name:lower() == string then return k end
            if vv.original_key and type(vv.original_key) == "string" and vv.original_key:lower() == string then return v.key end
        end
    end
end

function SEALS.purchase_key(key)
    if not key then return nil end
    local center = G.P_CENTERS[key]
    if not center then return nil end
    if center.set == "Back" or center.set == "Sleeve" then
        G.GAME.soe_creating_card_during_purchase = true
        for k, v in pairs(center.config) do
            if k == "jokers" then for i, vv in ipairs(v) do SMODS.add_card({key = vv}) end end
            if k == "voucher" then G.GAME.used_vouchers[v] = true; Card.apply_to_run(nil, G.P_CENTERS[v]) end
            if k == "hands" then G.GAME.round_resets.hands = G.GAME.round_resets.hands + v; ease_hands_played(v, true) end
            if k == "consumables" then for i, vv in ipairs(v) do SMODS.add_card({key = vv}) end end
            if k == "dollars" then ease_dollars(v, true) end
            if k == "remove_faces" then for i, vv in ipairs(G.playing_cards) do if SMODS.Ranks[vv.base.value].face then vv:remove() end end end
            if k == "spectral_rate" then G.GAME.spectral_rate = v end
            if k == "discards" then G.GAME.round_resets.discards = G.GAME.round_resets.discards + v; ease_discard(v, true) end
            if k == "reroll_discount" then G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - v; G.GAME.current_round.reroll_cost = G.GAME.current_round.reroll_cost - v end
            if k == "vouchers" then for i, vv in ipairs(v) do G.GAME.used_vouchers[vv] = true; Card.apply_to_run(nil, G.P_CENTERS[vv]) end end
            if k == "joker_slot" then G.jokers:change_size(v) end
            if k == "hand_size" then G.hand:change_size(v) end
            if k == "ante_scaling" then G.GAME.starting_params.ante_scaling = v end
            if k == "consumable_slot" then G.consumeables:change_size(v) end
            if k == "no_interest" then G.GAME.modifiers.no_interest = true end
            if k == "extra_hand_bonus" then G.GAME.modifiers.money_per_hand = v end
            if k == "extra_discard_bonus" then G.GAME.modifiers.money_per_discard = v end
        end
        if center.name == "Checkered Deck" or center.name == "Checkered Sleeve" then
            for k, v in pairs(G.playing_cards) do
                if v.base.suit == 'Clubs' then 
                    v:change_suit('Spades')
                end
                if v.base.suit == 'Diamonds' then 
                    v:change_suit('Hearts')
                end
            end
        end
        if center.apply then
            if center.set == "Sleeve" then
                center:apply(center)
            else
                local fake_deck = {effect = {config = center.config, center = center, text_UI = {}, fake_deck = true}}
                center:apply(fake_deck)
            end
        end
        G.soe_creating_card_during_purchase = nil
        G.GAME.soe_extra_decks = G.GAME.soe_extra_decks or {}
        table.insert(G.GAME.soe_extra_decks, key)
    elseif center.set == "Partner" then
        G.soe_creating_card_during_purchase = true
        if G.GAME.selected_partner_card then
            G.GAME.soe_extra_partners = G.GAME.soe_extra_partners or {}
            table.insert(G.GAME.soe_extra_partners, key)
            G.GAME.soe_extra_partner_cards = G.GAME.soe_extra_partner_cards or {}
            table.insert(G.GAME.soe_extra_partner_cards, Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, G.P_CARDS.empty, center))
            G.GAME.soe_extra_partner_cards[#G.GAME.soe_extra_partner_cards]:juice_up(0.3, 0.5)
            local ret = G.GAME.soe_extra_partner_cards[#G.GAME.soe_extra_partner_cards]:calculate_partner_begin()
            if ret then SMODS.trigger_effects({{individual = ret}}, G.GAME.soe_extra_partner_cards[#G.GAME.soe_extra_partner_cards]) end
        else
            G.GAME.selected_partner = key
            G.GAME.selected_partner_card = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, G.P_CARDS.empty, center)
            G.GAME.selected_partner_card:juice_up(0.3, 0.5)
            local ret = G.GAME.selected_partner_card:calculate_partner_begin()
            if ret then SMODS.trigger_effects({{individual = ret}}, G.GAME.selected_partner_card) end
        end
        G.soe_creating_card_during_purchase = nil
    end
    ease_dollars(-SEALS.get_cost(key), true)
end

function G.FUNCS.soe_enter_key_to_purchase(e)
    G.ENTERED_PURCHASE = ""
    G.CHOOSE_PURCHASE = UIBox({
        definition = SEALS.create_UIBox_enter_key(),
        config = {
            align = "cm",
            offset = { x = 0, y = 10 },
            major = G.ROOM_ATTACH,
            bond = "Weak",
            instance_type = "POPUP",
        },
    })
    G.CHOOSE_PURCHASE.alignment.offset.y = 0
    G.ROOM.jiggle = G.ROOM.jiggle + 1
    G.CHOOSE_PURCHASE:align_to_major()
end

function SEALS.create_UIBox_your_purchases()
    set_discover_tallies()
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = function()
            G.REFRESH_ALERTS = true
            return true
        end
    }))
    local t = create_UIBox_generic_options({
        back_func = 'soe_exit_purchaseitems',
        infotip = {
            "You may purchase",
            "any Deck"..(SEALS.find_mod("CardSleeves") and " or Sleeve" or "")..(SEALS.find_mod("partner") and " or Partner" or ""),
        },
        contents = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.15 },
                nodes = {
                    UIBox_button({ button = 'soe_enter_key_to_purchase', label = { "Enter Key/Name" }, minw = 5 }),
                }
            },
            SEALS.find_mod("partner") and {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.15 },
                nodes = {
                    Partner_API.custom_collection_tabs()[1]
                }
            } or nil,
        }
    })
    return t
end

local oldcreateuiboxyourcollection = create_UIBox_your_collection
function create_UIBox_your_collection()
    if not G.GAME.soe_purchasingitems then return oldcreateuiboxyourcollection() end
    return SEALS.create_UIBox_your_purchases()
end

local oldcreateuiboxothergameobjects = create_UIBox_Other_GameObjects
function create_UIBox_Other_GameObjects()
    if not G.GAME.soe_purchasingitems then return oldcreateuiboxothergameobjects() end
    return SEALS.create_UIBox_your_purchases()
end

local oldguidefuseandsellbuttons = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local retval = oldguidefuseandsellbuttons(card)

    if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and card.config.center.key == "j_soe_sealjoker2" then
        local ui =
        {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {

                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, button = 'soe_purchaseitems', func = 'soe_can_purchaseitems' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = "Purchase", colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = "Items", colour = G.C.WHITE, scale = 0.4, shadow = true } },
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
        table.insert(retval.nodes[1].nodes[2].nodes, ui)
        return retval
    end

    return retval
end

SMODS.Voucher{
    key = 'orbitalconnoisseur',
    cost = 10,
    atlas = 'VoucherSynonyms',
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    redeem = function (self, voucher)
        G.soe_jokerhandsbutton.states.visible = true
        G.soe_jokerhandsbutton.states.click.can = true
        G.GAME.soe_joker_hands_available = true
        G.GAME.soe_orbital_rate = 2
    end,
    unredeem = function (self, voucher)
        G.soe_jokerhandsbutton.states.visible = false
        G.soe_jokerhandsbutton.states.click.can = false
        G.GAME.soe_joker_hands_available = false
        G.GAME.soe_orbital_rate = 0
    end
}

SMODS.Voucher{
    key = 'rerolloverflow',
    cost = 10,
    atlas = 'VoucherSynonyms',
    pos = {x = 0, y = 2},
    unlocked = true,
    discovered = true,
    config = {extra = {discount = 25}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.discount}}
    end,
    redeem = function (self, voucher)
        voucher.ability.extra.thunk = G.GAME.soe_reroll_discount_percent
        G.GAME.soe_reroll_discount_percent = voucher.ability.extra.discount
        calculate_reroll_cost(true)
    end,
    unredeem = function (self, voucher)
        G.GAME.soe_reroll_discount_percent = voucher.ability.extra.thunk
        calculate_reroll_cost(true)
    end
}

local oldcalculatererollcost = calculate_reroll_cost
function calculate_reroll_cost(skip_increment)
    local g = oldcalculatererollcost(skip_increment)
    if G.GAME.soe_reroll_discount_percent and G.GAME.soe_reroll_discount_percent > 0 then
        G.GAME.current_round.reroll_cost = math.max(0, math.floor((G.GAME.current_round.reroll_cost + 0.5)*(100-G.GAME.soe_reroll_discount_percent)/100))
    end
    return g
end

SMODS.Gradient{
    key = 'synonym_gradient',
    cycle = 5,
    colours = {
        HEX("2D5E5A"),
        HEX("A2334C"),
        HEX("882D33"),
    }
}

assert(SMODS.load_file('items/consumeables/vice.lua'))()
assert(SMODS.load_file('items/consumeables/orbital.lua'))()
assert(SMODS.load_file('items/consumeables/phantom.lua'))()

SMODS.Booster {
    key = "synonym_normal",
    weight = 0.25,
    kind = 'soe_Synonym',
    cost = 4,
    atlas = "Boosters",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_synonym_pack",
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.soe_synonym_gradient)
        ease_background_colour{new_colour = SMODS.Gradients.soe_synonym_gradient, special_colour = darken(G.C.BLACK, 0.2), contrast = 1.5}
    end,
    update_pack = function (self, dt)
        SMODS.Booster.update_pack(self, dt)
        if G.STATE_COMPLETE then
            self:ease_background_colour()
            if G.booster_pack_sparkles then G.booster_pack_sparkles.colours = { lighten(SMODS.Gradients.soe_synonym_gradient, 0.1), SMODS.Gradients.soe_synonym_gradient, darken(SMODS.Gradients.soe_synonym_gradient, 0.1) } end
        end
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { lighten(SMODS.Gradients.soe_synonym_gradient, 0.1), SMODS.Gradients.soe_synonym_gradient, darken(SMODS.Gradients.soe_synonym_gradient, 0.1) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card = {set = "soe_Synonyms", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "soe_synonympack"}
        if G.GAME.soe_joker_hands_available then return _card end
        local set = SEALS.weighted_random({
            soe_Vice = #G.P_CENTER_POOLS['soe_Vice'],
            soe_Phantom = #G.P_CENTER_POOLS['soe_Phantom'],
        }, "synonym_pack")
        _card.set = set
        return _card
    end,
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

local oldsmodsgetenhancements = SMODS.get_enhancements
function SMODS.get_enhancements(card, extra_only)
    local g = oldsmodsgetenhancements(card, extra_only)
    for k, v in pairs(SEALS.get_enhancements(card, true)) do
        g[v] = true
    end
    return g
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
    replace_base_card = true,
    overrides_base_rank = true,
    always_scores = true,
    weight = 0,
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if card.area and card.area.cards then
            local other_card
            for i = 1, #card.area.cards do
                if card.area.cards[i] == card and card.area.cards[i+1] then
                    other_card = card.area.cards[i+1]
                end
            end
            if other_card then
                local eval, _ = eval_card(other_card, context)
                local ret = {}
                for k, v in pairs(eval) do
                    if type(v) == 'table' and k ~= 'edition' and k ~= 'seals' then
                        if not v.card then v.card = card end
                        ret[#ret+1] = v
                    end
                end
                return SMODS.merge_effects(ret)
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
                                assert(SEALS.safe_change_base(card, suit_prefix, rank_suffix))
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
                                assert(SEALS.safe_change_base(card, suit_prefix, rank_suffix))
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
                                assert(SEALS.safe_change_base(card, suit_prefix, rank_suffix))
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
    replace_base_card = true,
    always_scores = true,
    no_rank = true,
    weight = 0,
    config = {extra = {blueprint = {}}},
    in_pool = function(self)
        return false
    end,
    calculate = function(self, card, context)
        if card.area and card.area.cards then
            local other_card
            for i = 1, #card.area.cards do
                if card.area.cards[i] == card and card.area.cards[i+1] then
                    other_card = card.area.cards[i+1]
                end
            end
            if other_card then
                local eval, _ = eval_card(other_card, context)
                local ret = {}
                for k, v in pairs(eval) do
                    if type(v) == 'table' and k ~= 'edition' and k ~= 'seals' then
                        if not v.card then v.card = card end
                        ret[#ret+1] = v
                    end
                end
                return SMODS.merge_effects(ret)
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
                    assert(SEALS.safe_change_base(card, suit_prefix, rank_suffix))
                end
            end
            if G.hand and G.hand.cards and #G.hand.cards ~= 0 then
                if G.hand.cards[1] == card then
                    card.ability.no_rank = true
                    card.ability.no_suit = true
                else
                    local suit_prefix = G.hand.cards[1].base.suit
                    local rank_suffix = G.hand.cards[1].base.value
                    card.ability.no_rank = false
                    card.ability.no_suit = false
                    assert(SEALS.safe_change_base(card, suit_prefix, rank_suffix))
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
                                local suit_prefix = G.hand.highlighted[1].base.suit
                                local rank_suffix = G.hand.highlighted[1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                assert(SEALS.safe_change_base(card, suit_prefix, rank_suffix))
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

SMODS.PokerHand {
    key = "seal_flush",
    name = "Seal Flush",
    above_hand = "Straight Flush",
    visible = false,
    chips = 120,
    mult = 20,
    l_chips = 50,
    l_mult = 10,
    example = {
        { "H_T", true, seal = "Red" },
        { "C_2", true, seal = "Red" },
        { "C_5", true, seal = "Red" },
        { "S_7", true, seal = "Red" },
        { "D_3", true, seal = "Red" },
    },
    evaluate = function(parts)
        return parts.soe_sf_orig
    end,
}
  
SMODS.PokerHandPart {
    key = 'sf_orig',
    func = function(hand)
        local ret = {}
        local four_fingers = SMODS.four_fingers()
        local seals = {}
        for k, v in pairs(G.P_SEALS) do
            table.insert(seals, v.key)
        end
        if #hand < four_fingers then
            return ret
        else
            for j = 1, #seals do
                local t = {}
                local seal = seals[j]
                local flush_count = 0
                for i = 1, #hand do
                    if SEALS.has_seal(hand[i], seal) then
                        flush_count = flush_count + 1; t[#t + 1] = hand[i]
                    end
                end
                if flush_count >= four_fingers then
                    table.insert(ret, t)
                    return ret
                end
            end
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
				localize("soe_joker_central", "poker_hands"),
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

--[[
function SEALS.fake_retrigger(card, context, lasttriggereffects)
    local effects = lasttriggereffects and SMODS.shallow_copy(lasttriggereffects) or nil
    local eval, post
    if context and not effects then
        eval, post = eval_card(card, context)
        effects = {eval}
        for _, v in ipairs(post) do effects[#effects+1] = v end
    end
    if effects and next(effects) then
        local count = 0
        for k, v in pairs(effects) do
            for kk, vv in pairs(v) do
                if vv and type(vv) == 'table' and next(vv) then count = count + 1 end
            end
        end
        if count > 0 then
            SMODS.calculate_effect({message = localize('k_again_ex')}, card)
        end
        SMODS.trigger_effects(effects, card)
    end
end
]]

local oldcalcseal = Card.calculate_seal
function Card:calculate_seal(context)
    if self.debuff then return nil end
    if not self.playing_card or (table.contains(SMODS.get_card_areas('jokers'), self.area) and self.ability.set ~= 'Enhanced' and self.ability.set ~= 'Default') then
        local obj = self.config.center
        if obj.soe_jokercalculate and type(obj.soe_jokercalculate) == "function" then
            local o = obj:soe_jokercalculate(self, context)
            if o then
                if not o.card then o.card = self end
                return o
            end
        end
        if self.seal == 'Red' and context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self then
            return {
                repetitions = 1,
                card = self
            }
        end
        if self.seal == 'Gold' and ((context.post_trigger and context.other_card == self) or context.forcetrigger) then
            return {
                dollars = 3,
                message_card = self,
                card = self
            }
        end
        if self.seal == 'Blue' and ((#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.cardarea == self.area) or context.forcetrigger) then
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
            return {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet}
        end
        if self.seal == 'Purple' and (context.selling_self or context.forcetrigger) then
            if (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger then
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
                return {message = localize('k_plus_tarot'), colour = G.C.PURPLE}
            end
        end
        if self.seal == 'soe_reverseseal' then
            if (context.joker_main and self.facing == 'back') or context.forcetrigger then
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
            if (context.after and not self.oymatearyescored and not self.ability.eternal) or context.forcetrigger then
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
        --[[
        if self.seal == "soe_holoseal" and not G.holoseal_retrigger and G.GAME.last_trigger_effects and G.GAME.last_trigger_effects[2] == self.sort_id then
            if context.pseudorandom_result and not context.result and context.trigger_obj and type(context.trigger_obj) == "table" and context.trigger_obj.is and type(context.trigger_obj.is) == "function" and context.trigger_obj:is(Card) then
                G.holoseal_retrigger = true
                SEALS.fake_retrigger(context.trigger_obj, nil, G.GAME.last_trigger_effects[1])
                G.holoseal_retrigger = nil
            end
        end
        ]]
        if cryptidyeohna then
            if self.seal == 'cry_azure' and (context.after or context.forcetrigger) then
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
                if (not self.oymatearyescored and context.after) or context.forcetrigger then
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
        if SEALS.find_mod('RevosVault') then
            if self.seal == 'crv_ps' then
                if (context.post_trigger and context.other_card == self) or context.forcetrigger then
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.0,
                        func = function()
                            local copy = SEALS.copy_card(self, nil, G.consumeables)
                            copy:start_materialize()
                            return true
                        end
                    }))
                    card_eval_status_text(self, 'extra', nil, nil, nil, {message = 'Printed!'})
                end
            end
        end
        if SEALS.find_mod('aikoyorisshenanigans') then
            if self.seal == 'akyrs_debuff' then
                self.debuff = true
            else
                self.debuff = false
            end
        end
        if SEALS.find_mod("familiar") then
            if self.seal == "fam_maroon_seal" then
                if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self.area.cards[1] then
                    return {
                        repetitions = 1,
                        card = G.jokers.cards[1]
                    }
                end
            end
            if self.seal == "fam_sapphire_seal" then
                if (context.end_of_round and context.main_eval) or context.forcetrigger then
                    if (G.consumeables.config.card_limit > #G.consumeables.cards) or context.forcetrigger then
                        SMODS.add_card({set = 'Spectral', area = G.consumeables})
                        SMODS.calculate_effect({message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral, card = self}, self)
                    end
                end
            end
            if self.seal == "fam_gilded_seal" then
                if (context.post_trigger and context.other_card == self) or context.forcetrigger then
                    if SMODS.pseudorandom_probability(self, 'gilded_seal', 1, 4) then
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
                if (context.selling_self and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger then
                    SMODS.add_card({set = 'Familiar_Tarots', area = G.consumeables})
                    SMODS.calculate_effect({message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot, card = self}, self)
                end
            end
        end
        if SEALS.find_mod("GrabBag") then
            if self.seal == "gb_dual" then
                if context.before then
                    if SMODS.pseudorandom_probability(self, 'gb_dual', 1, self.ability.seal.extra.odds) then
                        local copy = SEALS.copy_card(self)
                        copy.states.visible = nil
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                copy:start_materialize()
                                return true
                            end
                        }))
                        return {
                            message = localize('k_copied_ex'),
                            colour = HEX("6E89C2"),
                        }
                    end
                end
            end
        end
    end
    if self.ability and (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then
        if self.seal == 'soe_reverseseal' then
            if (context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) and self.facing == 'back') or context.forcetrigger then
                return {
                    x_mult = 3,
                    colour = G.C.MULT,
                    card = self
                }
            end
        end
        if self.seal == 'soe_carmineseal' then
            if (context.cardarea == 'unscored' and context.destroy_card and context.destroy_card == self) or context.forcetrigger then
                return {
                    remove = true,
                }
            end
        end
    end
    if not (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then return nil end
    return oldcalcseal(self, context)
end

function SEALS.get_seal_count(card, seal, extra_only)
    local count = 0
    if (card.seal and (card.seal == seal or seal == nil)) and not extra_only then
        count = count + 1
    end
    for k, v in pairs(SEALS.get_seals(card, true)) do
        if v == seal or seal == nil then
            count = count + 1
        end
    end
    if SEALS.has_seal(card, seal) and count < 1 then
        count = 1
    end
    return count
end

local oldsetseal = Card.set_seal
function Card:set_seal(_seal, silent, immediate, quantum)
    if self and self.ability and self.ability.soe_detached_seal then return nil end
    if _seal and self and self.seal and not quantum and not self.soe_from_copy and ((next(SMODS.find_card("j_soe_sealjoker")) or next(SMODS.find_card("j_soe_sealjoker2"))) or ((G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_seal') and (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_soe_seal') and #SEALS.get_seals(self, true) < 1)) then
        self.ability.soe_quantum_seals = self.ability.soe_quantum_seals or {}
        table.insert(self.ability.soe_quantum_seals, _seal)
        if not silent then
            G.CONTROLLER.locks.seal = true
            local sound = G.P_SEALS[_seal].sound or { sound = 'gold_seal', per = 1.2, vol = 0.4 }
            if immediate then
                self:juice_up(0.3, 0.3)
                play_sound(sound.sound, sound.per, sound.vol)
                G.CONTROLLER.locks.seal = false
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = function()
                        self:juice_up(0.3, 0.3)
                        play_sound(sound.sound, sound.per, sound.vol)
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
        return nil
    end
    return oldsetseal(self, _seal, silent, immediate)
end

local oldgetseal = Card.get_seal
function Card:get_seal(bypass_debuff)
    if self.debuff and not bypass_debuff then return end
    if not self.seal and next(SEALS.get_seals(self, true)) then
        return SEALS.get_seals(self, true)[1]
    end
    return oldgetseal(self, bypass_debuff)
end

local oldunhighlightall = CardArea.unhighlight_all
function CardArea:unhighlight_all()
    if G.GAME.soe_usedconsumablehasredseal then return nil end
    return oldunhighlightall(self)
end

local olduseconsume = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if SEALS.has_seal(self, 'crv_ps') then
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.0,
            func = function()
                local copy = SEALS.copy_card(self, nil, G.consumeables)
                copy:start_materialize()
                return true
            end
        }))
        card_eval_status_text(self, 'extra', nil, nil, nil, {message = 'Printed!'})
    end
    local g = olduseconsume(self, area, copier)
    if SEALS.has_seal(self, 'Gold') then
        local effects = {}
        for i=1, SEALS.get_seal_count(self, 'Gold') do
            table.insert(effects, {dollars = 3})
        end
        SMODS.calculate_effect(SMODS.merge_effects(effects), self)
    end
    return g
end

local olduseconsume2 = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if SEALS.has_seal(self, 'Red') then
        G.GAME.soe_usedconsumablehasredseal = true
    else
        G.GAME.soe_usedconsumablehasredseal = nil
    end
    local g = olduseconsume2(self, area, copier)
    if not G.soe_redsealretriggering then
        G.soe_redsealretriggering = true
        if SEALS.has_seal(self, 'Red') then
            for i=1, SEALS.get_seal_count(self, 'Red') do
                SMODS.calculate_effect({message = localize('k_again_ex')}, self)
                if i == SEALS.get_seal_count(self, 'Red') then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.soe_usedconsumablehasredseal = nil
                            return true
                        end
                    }))
                end
                self:use_consumeable(area, copier)
            end
        end
        G.soe_redsealretriggering = nil
    end
    return g
end

local oldopen = Card.open
function Card:open()
    if self.ability.set == 'Booster' then
        if SEALS.has_seal(self, 'Gold') then
            local effects = {}
            for i=1, SEALS.get_seal_count(self, 'Gold') do
                table.insert(effects, {dollars = 3})
            end
            SMODS.calculate_effect(SMODS.merge_effects(effects), self)
        end
    end
    return oldopen(self)
end

local oldredeem = Card.redeem
function Card:redeem()
    if self.ability.set == 'Voucher' then
        if SEALS.has_seal(self, 'Gold') then
            local effects = {}
            for i=1, SEALS.get_seal_count(self, 'Gold') do
                table.insert(effects, {dollars = 3})
            end
            SMODS.calculate_effect(SMODS.merge_effects(effects), self)
        end
    end
    return oldredeem(self)
end

--[[
local oldbacktriggereffect = Back.trigger_effect
function Back:trigger_effect(args)
    local g = {oldbacktriggereffect(self, args)}
    local saved
    for i, v in ipairs(G.GAME.soe_extra_decks or {}) do
        local center = G.P_CENTERS[v]
        if args.context == "final_scoring_step" then
            local new_chips, new_mult = unpack(g)
            args.chips, args.mult = new_chips or args.chips, new_mult or args.mult
            if type(center.calculate) == "function" then
                new_chips, new_mult = center:calculate(center, args)
            elseif type(center.trigger_effect) == "function" then
                new_chips, new_mult = center:trigger_effect(args)
            end
            args.chips, args.mult = new_chips or args.chips, new_mult or args.mult
            saved = {args.chips, args.mult}
        elseif type(center.calculate) == "function" and type(args.context) == "string" then
            local context = type(args.context) == "table" and args.context or args
            local effect = center:calculate(center, context)
            if effect then
                SMODS.calculate_effect(effect, G.deck.cards[1] or G.deck)
            end
        elseif type(center.trigger_effect) == "function" then
            center:trigger_effect(args)
        end
    end
    return saved and unpack(saved) or unpack(g)
end
]]

local oldsmodsgetcardareas = SMODS.get_card_areas
function SMODS.get_card_areas(_type, _context)
    local output = oldsmodsgetcardareas(_type, _context)
    --[[
    if _type == "jokers" then
        local fake_cardarea = {cards = {}}
        for i, v in ipairs(G.I.CARD) do
            if v.ability.soe_calculate_like_normal_joker then
                table.insert(fake_cardarea.cards, v)
            end
        end
        output[#output+1] = fake_cardarea
    end
    ]]
    if _type == 'individual' then
        for i, v in ipairs(G.GAME.soe_extra_decks or {}) do
            local center = G.P_CENTERS[v]
            if center.calculate then
                local fake_deck = setmetatable({}, {
                    __index = center,
                })
                function fake_deck:calculate(context)
                    return center:calculate(center, context)
                end
                output[#output+1] = {
                    object = fake_deck,
                    scored_card = G.deck.cards[1] or G.deck,
                }
            end
        end
        if SEALS.find_mod("partner") then
            for i, v in ipairs(G.GAME.soe_extra_partner_cards or {}) do
                if v and v.config and v.config.center and v:is(Card) then
                    local center = v.config.center
                    if center.calculate then
                        local fake_partner = setmetatable({}, {
                            __index = center,
                        })
                        function fake_partner:calculate(context)
                            return v:calculate_partner(context)
                        end
                        output[#output+1] = {
                            object = fake_partner,
                            scored_card = v,
                        }
                    end
                end
            end
        end
        for i, v in ipairs(G.GAME.soe_detached_seals or {}) do
            if v and v.ability and v.ability.soe_detached_seal and v:is(Card) then
                local center = SEALS.detached_seals[v.ability.soe_detached_seal]
                if center.calculate then
                    local fake_seal = setmetatable({}, {
                        __index = center,
                    })
                    function fake_seal:calculate(context)
                        return center:calculate(v, context)
                    end
                    output[#output+1] = {
                        object = fake_seal,
                        scored_card = v,
                    }
                end
            end
        end
    end
    return output
end

if SEALS.find_mod("partner") then
    local oldsaverun = save_run
    function save_run()
        for i, v in ipairs(G.GAME.soe_extra_partner_cards or {}) do
            if v and v.ability then
                G.GAME.soe_extra_partners_tables = G.GAME.soe_extra_partners_tables or {}
                for k, vv in pairs(v.ability) do
                    G.GAME.soe_extra_partners_tables[i] = G.GAME.soe_extra_partners_tables[i] or {}
                    G.GAME.soe_extra_partners_tables[i][k] = vv
                end
            end
        end
        return oldsaverun()
    end

    local oldgamestartrun = Game.start_run
    function Game:start_run(args)
        local g = oldgamestartrun(self, args)
        local any_unlocked = nil
        for _, v in pairs(G.P_CENTER_POOLS["Partner"]) do
            if v:is_unlocked() then
                any_unlocked = true
                break
            end
        end
        if any_unlocked and not G.GAME.soe_extra_partners and not G.GAME.skip_partner and Partner_API.config.enable_partner then
        elseif G.GAME.soe_extra_partners then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local centers = {}
                    for k, v in pairs(G.GAME.soe_extra_partners) do
                        if G.P_CENTERS[v] then
                            table.insert(centers, G.P_CENTERS[v])
                        end
                    end
                    G.GAME.soe_extra_partner_cards = {}
                    for i, v in ipairs(centers) do
                        G.GAME.soe_extra_partner_cards[i] = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, G.P_CARDS.empty, v)
                        G.GAME.soe_extra_partner_cards[i]:juice_up(0.3, 0.5)
                        if G.GAME.soe_extra_partners_tables then
                            for k, vv in pairs(G.GAME.soe_extra_partners_tables[i]) do
                                G.GAME.soe_extra_partner_cards[i].ability[k] = vv
                            end
                        end
                    end
                    return true
                end
            }))
        end
        return g
    end
end

local oldsaverun = save_run
function save_run()
    for i, v in ipairs(G.GAME.soe_detached_seals or {}) do
        if v and v.ability then
            G.GAME.soe_detached_seals_tables = G.GAME.soe_detached_seals_tables or {}
            for k, vv in pairs(v.ability) do
                G.GAME.soe_detached_seals_tables[i] = G.GAME.soe_detached_seals_tables[i] or {}
                G.GAME.soe_detached_seals_tables[i][k] = vv
            end
        end
        if v and v.T then
            G.GAME.soe_detached_seal_positions = G.GAME.soe_detached_seal_positions or {}
            G.GAME.soe_detached_seal_positions[i] = {x = v.T.x, y = v.T.y}
        end
    end
    return oldsaverun()
end

local oldgamestartrun = Game.start_run
function Game:start_run(args)
    local g = oldgamestartrun(self, args)
    if G.GAME.soe_detached_seal_keys then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.soe_detached_seals = {}
                for i, v in ipairs(G.GAME.soe_detached_seal_keys) do
                    G.GAME.soe_detached_seals[i] = Card(G.GAME.soe_detached_seal_positions[i].x or G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.GAME.soe_detached_seal_positions[i].y or G.deck.T.y-G.CARD_H*1.6, G.CARD_W/2.63, G.CARD_H/3.52, G.P_CARDS.empty, G.P_CENTERS.c_base)
                    for k, vv in pairs(G.GAME.soe_detached_seals_tables[i] or ((SEALS.detached_seals[v] or {}).config or {})) do
                        G.GAME.soe_detached_seals[i].ability[k] = copy_table(vv)
                    end
                    G.GAME.soe_detached_seals[i].ability.set = "Seal"
                    G.GAME.soe_detached_seals[i].ability.soe_detached_seal = v
                    if G.GAME.soe_detached_seals[i].children.center then G.GAME.soe_detached_seals[i].children.center:remove() end
                    G.GAME.soe_detached_seals[i].children.center = Sprite(G.GAME.soe_detached_seals[i].T.x, G.GAME.soe_detached_seals[i].T.y, G.GAME.soe_detached_seals[i].T.w, G.GAME.soe_detached_seals[i].T.h, G.ASSET_ATLAS["soe_SealsIndividual"], {x = ({Red=0,Blue=1,Gold=2,Purple=3})[v], y = 0})
                    G.GAME.soe_detached_seals[i].children.center.states.hover = G.GAME.soe_detached_seals[i].states.hover
                    G.GAME.soe_detached_seals[i].children.center.states.click = G.GAME.soe_detached_seals[i].states.click
                    G.GAME.soe_detached_seals[i].children.center.states.drag = G.GAME.soe_detached_seals[i].states.drag
                    G.GAME.soe_detached_seals[i].children.center.states.collide.can = false
                    G.GAME.soe_detached_seals[i].children.center:set_role({major = G.GAME.soe_detached_seals[i], role_type = 'Glued', draw_major = G.GAME.soe_detached_seals[i]})
                    G.GAME.soe_detached_seals[i]:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
    end
    return g
end

SEALS.nojokercalculate = function(context)
    if context.individual and context.cardarea == G.play then
        if context.other_card.ability.legallysleeve == 'Plasma' then
            SMODS.calculate_effect({balance = true}, context.other_card)
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
    local g, post = oldcalcjoker(self, context)
    local playingcard
    if self.base and self.base.id and context.joker_main then
        playingcard = {
            func = function()
                SMODS.score_card(self, {cardarea = G.play})
            end
        }
    end
    if not context.extra_joker and (context.joker_main or context.before or context.after or (context.end_of_round and context.main_eval)) and self.ability.soe_legalenhancements and next(self.ability.soe_legalenhancements) then
        local enhancements, beforeorafter = SEALS.calculate_joker_enhancements(self, context, not (context.joker_main))
        if enhancements and next(enhancements) then
            local before, after = {}, {}
            for i, v in pairs(beforeorafter) do
                if v == 'before' then
                    table.insert(before, enhancements[i])
                elseif v == 'after' then
                    table.insert(after, enhancements[i])
                end
            end
            local neweffects = {}
            for i, v in ipairs(before) do
                table.insert(neweffects, v)
            end
            if g then table.insert(neweffects, g) end
            for i, v in ipairs(after) do
                table.insert(neweffects, v)
            end
            if playingcard then
                table.insert(neweffects, playingcard)
            end
            return SMODS.merge_effects(neweffects)
        end
    end
    if playingcard then
        if g then
            return SMODS.merge_effects({g, playingcard})
        else
            return playingcard
        end
    end
    if context.joker_main and self.ability.legallysleeve == 'Plasma' then
        SMODS.calculate_effect({
            balance = true,
        }, self)
    end
    return g, post
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
            if G.vouchers.cards[i].config.center.key ~= "v_soe_brainstorm" and G.vouchers.cards[i].config.center.key ~= "v_soe_blueprint" and not G.vouchers.cards[i].ability.soe_from_blueprint then
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
        if G.GAME["old"..G.ownerofblueprintvoucherchoosecardarea == "v_soe_brainstorm" and "brainstormvouchertocopy" or "blueprintvouchertocopy"] then
            local other_old_voucher
            for k, v in pairs(G.vouchers.cards) do
                if v.ability.soe_from_blueprint and v.ability.soe_from_blueprint == G.ownerofblueprintvoucherchoosecardarea then
                    other_old_voucher = v
                    break
                end
            end
            if other_old_voucher then
                other_old_voucher:remove()
                Card.unapply_to_run(nil, other_old_voucher.config.center)
            end
        end
        G.soe_blueprinting = true
        Card.apply_to_run(nil, self.config.center)
        G.soe_blueprinting = nil
    end
    --[[
    if self.config.center.key == 'j_soe_someinone' and self.area == G.jokers and not (G.someinonechoosecardarea and G.someinonechoosecardarea.cards and G.someinonechoosecardarea.cards[1]) then
        G.SETTINGS.paused = true
        G.someinonechoosecardarea = CardArea(
            G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
            G.ROOM.T.h,
            5.3 * G.CARD_W,
            1.03 * G.CARD_H,
            { card_limit = 5, type = "title", highlight_limit = 0, collection = true }
        )
        local jokers = {
            n = G.UIT.R,
            config = { align = "cm", padding = 0, no_fill = true },
            nodes = {
                { n = G.UIT.O, config = { object = G.someinonechoosecardarea } },
            },
        }
        local legaljokers = {}
        for k, v in pairs(G.P_CENTER_POOLS.Joker) do
            if v.mod and not (v.mod.id == "MoreFluff" or v.mod.id == "jen") and not (type(v.rarity) == "number" and v.rarity <= 4) then
                table.insert(legaljokers, v)
            end
        end
        for i = 1, 100 do
            local chosen, index = pseudorandom_element(legaljokers, pseudoseed('joker'))
            local card_ = SMODS.create_card({set = 'Joker', area = G.someinonechoosecardarea, no_edition = true, key = chosen.key})
            G.someinonechoosecardarea:emplace(card_)
            table.remove(legaljokers, index)
            if #legaljokers <= 0 then break end
        end
        G.UIBOXGENERICOPTIONSSOMEINONE = create_UIBox_generic_options({
            snap_back = true,
            contents = {
                {
                    n = G.UIT.R,
                    config = {align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05},
                    nodes = {jokers},
                },
            },
        })
        G.FUNCS.overlay_menu({
            definition = G.UIBOXGENERICOPTIONSSOMEINONE,
        })
    end
    if self.area == G.someinonechoosecardarea and G.someinonechoosecardarea and G.someinonechoosecardarea.cards and G.someinonechoosecardarea.cards[1] then
        local foundjokers = SMODS.find_card('j_soe_someinone')
        if #foundjokers > 0 then
            for k, v in pairs(foundjokers) do
                table.insert(v.ability.extra.jokerkeys, self.config.center.key)
            end
        end
        G.FUNCS.exit_overlay_menu()
    end
    ]]
    return g
end

function SEALS.perform_operations(val1, op, val2)
    if op == "=" then return val2 end
    if op == "+" then return val1 + val2 end
    if op == "-" then return val1 - val2 end
    if op == "*" then return val1 * val2 end
    if op == "/" then return val1 / val2 end
    if op == "%" then return val1 % val2 end
    if op == "^" then return val1 ^ val2 end
end

function SEALS.modify_joker_values(card, modifytbl, exclusions, ignoreimmutable, nodeckeffects)
    if not card or not modifytbl then return nil end
    if card.config.center.immutable and not ignoreimmutable then return nil end
    local cardwasindeck = card.added_to_deck
    if not nodeckeffects and cardwasindeck then card:remove_from_deck(true) end
    exclusions = exclusions or {}
    local ops = {"=", "+", "-", "*", "/", "%", "^"}
    local function modify_value(ref_table, ref_value, isdirectlyinability)
        if type(ref_table[ref_value]) == 'table' and (ignoreimmutable or ref_value ~= "immutable") then
            for k, v in pairs(ref_table[ref_value]) do
                modify_value(ref_table[ref_value], k, false)
            end
        elseif type(ref_table[ref_value]) == 'number' and ((not (exclusions[ref_value] == true or exclusions[ref_value] == ref_table[ref_value])) or not isdirectlyinability) then
            for i, v in ipairs(ops) do
                if modifytbl[v] then
                    ref_table[ref_value] = SEALS.perform_operations(ref_table[ref_value], v, modifytbl[v])
                end
            end
        end
    end
    for k, v in pairs(card.ability) do
        modify_value(card.ability, k, true)
    end
    if not nodeckeffects and cardwasindeck then card:add_to_deck(true) end
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

function SEALS.event(func, trigger, delay, blocking, blockable)
    G.E_MANAGER:add_event(Event({
        trigger = trigger,
        delay = delay,
        blocking = blocking,
        blockable = blockable,
        func = func,
    }))
end

function SEALS.create_mod_badge(mod)
    local mod = (type(mod) == 'string' and SMODS.Mods[mod]) or (type(mod) == 'table' and mod) or nil
    if not mod then return nil end
    return create_badge(mod.display_name, mod.badge_colour, mod.badge_text_colour)
end

function SEALS.copy_card(card, new_card, area)
    if not card then return nil end
    local area = area or (new_card and new_card.area) or card.area or G.jokers
    local cardwasindeck = new_card and new_card.added_to_deck or nil
    local copy = copy_card(card, new_card)
    if new_card and cardwasindeck then copy:remove_from_deck() end
    if card.playing_card then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        copy.playing_card = G.playing_card
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, copy)
    end
    if (new_card and cardwasindeck) or not new_card then copy:add_to_deck() end
    if not new_card then area:emplace(copy) end
    return copy
end

if not Card.is_rarity then
    function Card:is_rarity(rarity)
        if self.ability.set ~= "Joker" then return false end
        local rarities = {"Common", "Uncommon", "Rare", "Legendary"}
        rarity = rarities[rarity] or rarity
        local own_rarity = rarities[self.config.center.rarity] or self.config.center.rarity
        return own_rarity == rarity or SMODS.Rarities[own_rarity] == rarity
    end
end

function SEALS.move_card(card, area)
    if not card or not area then return nil end
    card.area:remove_card(card)
    area:emplace(card)
    return card
end

function SEALS.use_card(card)
    if not card then return nil end
    return G.FUNCS.use_card({config = {ref_table = card}})
end

function SEALS.forcetriggerseals(card)
    if not card then return nil end
    local context = {main_scoring = true, cardarea = G.play, discard = true, pre_discard = true, full_hand = G.play.cards, scoring_hand = {}, scoring_name = '', poker_hands = {}, forcetrigger = true}
	for _, v in ipairs(SMODS.PokerHandPart.obj_buffer) do
        context.poker_hands[v] = {}
	end
    local effects = {}
    local old_seal = card.seal
    card.drawseal = old_seal or 'none'
    local old_ability_seal = copy_table(card.ability.seal)
    for i, v in ipairs(SEALS.get_seals(card)) do
        if next(SEALS.get_seals(card, true)) and i > 1 and card.seal ~= v then
            SEALS.safe_set_seal(card, v)
        end
        local eval
        if G.P_SEALS[v].forcetrigger then
            eval = G.P_SEALS[v]:forcetrigger(card)
            goto skip
        end
        if card.playing_card and (v == 'Gold' or v == 'Blue') then
            eval = SEALS.calculate_hardcoded_seals(card, context)
        elseif v == 'Purple' then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card({ set = 'Tarot', key_append = '8ba' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            eval = {message = localize('k_plus_tarot'), colour = G.C.PURPLE}
        else
            eval = card:calculate_seal(context)
        end
        ::skip::
        table.insert(effects, eval)
    end
    card.seal = old_seal
    card.drawseal = nil
    card.ability.seal = old_ability_seal
    return effects
end

function SEALS.safe_change_base(card, suit, rank)
    local _suit = SMODS.Suits[suit or card.base.suit]
    local _rank = SMODS.Ranks[rank or card.base.value]
    if not _suit or not _rank then
        return nil, ('Tried to call SEALS.safe_change_base with invalid arguments: suit="%s", rank="%s"'):format(suit, rank)
    end
    card.base.value = _rank.key
    card.base.suit = _suit.key
    card.base.id = _rank.id
    card.base.nominal = _rank.nominal or 0
    card.base.colour = G.C.SUITS[_suit.key]
    return card
end

function SEALS.fix_broken_cards()
    for i=1, 500 do
        for i, v in ipairs(G.I.CARDAREA) do
            if v and type(v) == 'table' and v.is and v:is(CardArea) and v.cards and type(v.cards) == 'table' then
                for ii, vv in ipairs(v.cards) do
                    if vv and vv:is(Card) and vv.REMOVED and vv.remove then
                        vv:remove()
                    end
                end
            end
        end
    end
end

function SEALS.reload_atlases()
    SMODS.injectObjects(SMODS.Atlas)
end

function SEALS.reload_loc(loc, mod)
    mod = SMODS.Mods[mod] or SEALS
    SMODS.handle_loc_file(mod.path, mod.id)
    SEALS.parse_loc_txt(loc)
end

function SEALS.add_metatable(table, metatable)
    local oldmetatable = getmetatable(table)
    if not oldmetatable or not next(oldmetatable) then return setmetatable(table, metatable) end
    local matches = {}
    for k, v in pairs(oldmetatable) do
        if metatable[k] then
            matches[k] = true
        end
    end
    local newmetatable = {}
    if not next(matches) then
        for k, v in pairs(oldmetatable) do
            metatable[k] = v
        end
        print(metatable)
        return setmetatable(table, metatable)
    else
        for k, v in pairs(metatable) do
            if oldmetatable[k] then
                newmetatable[k] = function(...)
                    local params = {...}
                    if k ~= '__index' then
                        local g = metatable[k](...)
                        if g ~= nil then return g end
                        return oldmetatable[k](...)
                    else
                        local currentfunction, oldfunction = metatable[k], oldmetatable[k]
                        if type(metatable[k]) == 'table' then
                            currentfunction = function(...) return metatable[k](...) end
                        end
                        if type(oldmetatable[k]) == 'table' then
                            oldfunction = function(...) return oldmetatable[k](...) end
                        end
                        local g = currentfunction(...)
                        if g ~= nil then return g end
                        return oldfunction(...)
                    end
                end
            else
                newmetatable[k] = v
            end
        end
    end
    return setmetatable(table, newmetatable)
end

function SEALS.is_return_entry_this_type(entry, type)
    if type == 'chips' then
        return SEALS.perform_checks({entry}, '==', {'chips', 'h_chips', 'chip_mod'})
    elseif type == 'mult' then
        return SEALS.perform_checks({entry}, '==', {'mult', 'h_mult', 'mult_mod'})
    elseif type == 'xchips' then
        return SEALS.perform_checks({entry}, '==', {'x_chips', 'xchips', 'Xchip_mod'})
    elseif type == 'xmult' then
        return SEALS.perform_checks({entry}, '==', {'x_mult', 'Xmult', 'xmult', 'x_mult_mod', 'Xmult_mod'})
    elseif type == 'dollars' then
        return SEALS.perform_checks({entry}, '==', {'p_dollars', 'dollars', 'h_dollars'})
    end
end

SEALS.realenhancementcalculatefunctions = {}
for i, v in ipairs({G.P_CENTERS, SMODS.Enhancement.obj_table}) do
    for k, vv in pairs(v) do
        if vv.set == "Enhanced" then
            SEALS.realenhancementcalculatefunctions[vv.key] = function(self, card, context)
                context.extra_enhancement = true
                local old_ability = copy_table(card.ability)
                local old_center = card.config.center
                local old_center_key = card.config.center_key
                SEALS.safe_set_ability(card, vv)
                card.ability.extra_enhancement = vv.key
                G.GAME.triggered_enhancement = {card.sort_id, vv.key}
                local eval = eval_card(card, context)
                G.GAME.triggered_enhancement = nil
                context.extra_enhancement = nil
                card.ability = old_ability
                card.config.center = old_center
                card.config.center_key = old_center_key
                local effects = {}
                if eval.playing_card then table.insert(effects, eval.playing_card) end
                if eval.enhancement then table.insert(effects, eval.enhancement) end
                if eval.end_of_round then table.insert(effects, eval.end_of_round) end
                return SMODS.merge_effects(effects)
            end
            if (vv.replace_base_card and vv.mod ~= SEALS) or vv.key == 'm_stone' then
                SMODS.Joker {
                    key = (vv.key == 'm_stone' and 'stone' or vv.original_key or vv.key)..'cardjoker',
                    atlas = 'Enhancers',
                    pos = vv.pos,
                    rarity = 3,
                    cost = 10,
                    unlocked = true,
                    discovered = true,
                    blueprint_compat = true,
                    eternal_compat = true,
                    perishable_compat = true,
                    soe_is_enhancement_joker = true,
                    soe_enhancement_mod = vv.mod,
                    soe_enhancement_key = vv.key,
                    config = vv.key == 'm_stone' and {
                        chips = 50
                    } or vv.config or nil,
                    loc_txt = {
                        name =  ((not vv.original_mod) and (localize({type = 'name_text', key = vv.key, set = 'Enhanced'}) or "Unknown Enhancement") .. ' Joker') or '',
                        text = ((not vv.original_mod) and (G.localization.descriptions.Enhanced[vv.key] or {}).text) or {''},
                    },
                    loc_vars = vv.key == 'm_stone' and function(self, info_queue, card)
                        return {vars = {card.ability.chips}}
                    end or vv.loc_vars or nil,
                    add_to_deck = function(self, card, from_debuff)
                        G.soe_initial_adding = true
                        SEALS.set_joker_enhancement(card, vv)
                        G.soe_initial_adding = nil
                    end,
                    in_pool = function(self)
                        return false
                    end,
                    set_badges = function(self, card, badges)
                        if vv.mod ~= SEALS then
                            badges[#badges+1] = SEALS.create_mod_badge(vv.mod)
                        end
                    end
                }
            end
        end
    end
end

function SEALS.set_joker_enhancement(card, center)
    if not card or not center then return nil end
    if type(center) == 'string' then
        assert(G.P_CENTERS[center], ("Could not find center \"%s\""):format(center))
        center = G.P_CENTERS[center]
    end
    if not G.soe_initial_adding and (center.replace_base_card or center.key == 'm_stone') then card:set_ability('j_soe_'..(center.key == 'm_stone' and 'stone' or center.original_key or center.key)..'cardjoker') end
    card.ability.soe_legalenhancements = card.ability.soe_legalenhancements or {}
    card.ability.soe_legalenhancements[center.key] = card.ability.soe_legalenhancements[center.key] or {}
    if next(SMODS.find_card('j_soe_sealjoker2')) then
        table.insert(card.ability.soe_legalenhancements[center.key], {})
    else
        card.ability.soe_legalenhancements[center.key][1] = {}
    end
    local current = (next(SMODS.find_card('j_soe_sealjoker2')) and card.ability.soe_legalenhancements[center.key][#card.ability.soe_legalenhancements[center.key]]) or card.ability.soe_legalenhancements[center.key][1]
    current.config = copy_table(center.config)
    current.mod = (center.mod or {}).id
end

function SEALS.calculate_joker_enhancements(card, context, noscoring)
    if not card or not card.ability.soe_legalenhancements or not next(card.ability.soe_legalenhancements) then return nil end
    local other_context = SMODS.shallow_copy(context)
    other_context.main_scoring = not noscoring or nil
    other_context.cardarea = G.play
    other_context.destroy_card = context.after and card or nil
    other_context.playing_card_end_of_round = context.end_of_round
    local effects, beforeorafter = {}, {}
    for k, v in pairs(card.ability.soe_legalenhancements) do
        for i, v in ipairs(v) do
            local enhancement = SEALS.realenhancementcalculatefunctions[k](v, card, other_context)
            if not enhancement then
                other_context.cardarea = G.hand
                enhancement = SEALS.realenhancementcalculatefunctions[k](v, card, other_context)
                other_context.cardarea = G.play
            end
            if enhancement then
                local oldsmodsshatters = SMODS.shatters
                function SMODS.shatters(card2)
                    if card2 == card and (G.P_CENTERS[k].shatters or G.P_CENTERS[k].key == "m_glass") then return true end
                    return oldsmodsshatters(card)
                end
                if other_context.destroy_card and enhancement.remove then SMODS.destroy_cards(card) return nil end
                SMODS.shatters = oldsmodsshatters
                local eval = SMODS.shallow_copy(enhancement)
                repeat
                    for kk, v in pairs(eval) do
                        if SEALS.is_return_entry_this_type(kk, 'xmult') or SEALS.is_return_entry_this_type(kk, 'xchips') then beforeorafter[#effects+1] = 'after' break end
                    end
                    beforeorafter[#effects+1] = beforeorafter[#effects+1] or 'before'
                    eval = eval.extra
                until not eval
                table.insert(effects, enhancement)
            end
        end
    end
    return effects, beforeorafter
end

--[[
function SEALS.get_line_range_from_file(path, linestart, lineend)
    if not NFS.getInfo(path) then return nil end
    local i = 0
    local text = {}
    local lines = NFS.lines(path)
    if not lines then return nil end
    for line in lines do
        i = i + 1
        if i >= linestart then text[#text + 1] = line end
        if i >= lineend then break end
    end
    return text
end

function SEALS.fix_id(info)
    if not info then return nil end
    local modid, path = info.source:match("=%[SMODS (.+) \"(.+)\"%]")
    if modid then return nil end
    local fullpath = SMODS.MODS_DIR.."/lovely/dump/"..(info.source:sub(2))
    if not NFS.getInfo(fullpath) then fullpath = SMODS.MODS_DIR.."/lovely/dump/SMODS/"..modid.."/"..path end
    if not NFS.getInfo(fullpath) then fullpath = SMODS.Mods[modid].path..path end
    if not NFS.getInfo(fullpath) then return nil end
    local line = unpack(SEALS.get_line_range_from_file(fullpath, info.currentline, info.currentline) or {})
    if not line then return nil end
    local operator, number = line:match(":get_id%(%s*%)%s*([=<>]+)%s*(%d+)")
    return operator, tonumber(number)
end
]]

SMODS.Voucher{
    key = 'blueprint',
    cost = 10,
    atlas = 'BlueprintVouchers',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {localize({type = "name_text", set = "Voucher", key = G.GAME.blueprintvouchertocopy}) or "Nothing"}}
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
                return SMODS.blueprint_effect(card, other_voucher, context)
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
        return {vars = {localize({type = "name_text", set = "Voucher", key = G.GAME.brainstormvouchertocopy}) or "Nothing"}}
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
            return SMODS.blueprint_effect(card, other_voucher, context)
        else
            G.GAME.brainstormvouchertocopy = nil
        end
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

function SEALS.deep_copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[SEALS.deep_copy(k, s)] = SEALS.deep_copy(v, s)
	end
	return res
end

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
	self.soe_jokerhandsbutton = UIBox {
		definition = { n = G.UIT.ROOT, config = { align = 'cm', colour = G.C.CLEAR, minw = G.deck.T.w, minh = 0.5 }, nodes = {
			{ n = G.UIT.R, nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "tm",
						minw = 2,
						padding = 0.1,
						r = 0.1,
						hover = true,
						colour = G.C.UI.BACKGROUND_DARK,
						shadow = true,
						button = "calc_joker_hands",
						func = "can_calc_joker_hands",
					},
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "bcm", padding = 0 },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = "Joker Hands",
										scale = 0.35,
										colour = G.C.UI.TEXT_LIGHT,
										id = "calculate_joker_hands"
									}
								}
							}
						},
					}
				}
			} }
		} },
		config = { major = G.deck, align = 'tm', offset = { x = 0, y = -0.85 }, bond = 'Weak' }
	}
    self.soe_jokerhandsbutton.states.visible = false
    self.jokers.config.highlighted_limit = 1000
    return g
end

--assert(SMODS.load_file('allinone.lua'))()
assert(SMODS.load_file('bigfuncs.lua'))()

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
                    if (SMODS.pseudorandom_probability(card, 'egg', 1, (if_skill_obtained("ygg_egg_upgrade5") and 2 or 4)) or (if_skill_obtained("soe_egg_upgrade5") and G.GAME.blind.boss)) then
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
        if context.joker_main then
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
                if context.other_card:is_suit("Hearts") and SMODS.pseudorandom_probability(self, 'bloodstone', 1, card.ability.extra.bloodstone.odds) then
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

for i, c in ipairs({G.P_CENTERS, SMODS.Planet.obj_table}) do
    for k, v in pairs(c) do
        if v.set == 'Planet' and v.config.hand_type then
            SMODS.Joker{
                key = v.key .. 'joker',
                atlas = 'Tarots',
                pos = v.pos,
                rarity = 3,
                soe_is_planet_joker = true,
                soe_planet_mod = v.mod,
                soe_planet_key = v.key,
                loc_txt = {
                    name =  ((not v.original_mod) and (localize({type = 'name_text', key = v.key, set = 'Planet'}) or "Unknown Planet") .. ' Joker') or '',
                    text = {
                        "If played {C:attention}poker hand{} is",
                        "{C:attention}#1#{}",
                        "Upgrade played hand",
                    },
                },
                cost = v.cost * 2,
                unlocked = true,
                discovered = true,
                blueprint_compat = true,
                eternal_compat = true,
                perishable_compat = true,
                loc_vars = function(self, info_queue, card)
                    return {vars = {localize(v.config.hand_type, 'poker_hands')}}
                end,
                calculate = function(self, card, context)
                    if context.before and context.scoring_name == v.config.hand_type then
                        return {
                            level_up = true,
                            card = card,
                            message = localize('k_level_up_ex'),
                        }
                    end
                end,
                in_pool = function(self)
                    if SMODS.is_poker_hand_visible(v.config.hand_type) then
                        return true
                    end
                    return false
                end,
                set_badges = function(self, card, badges)
                    if v.mod ~= SEALS then
                        badges[#badges+1] = SEALS.create_mod_badge(v.mod)
                    end
                end
            }
        end
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
            local cards = {}
            for k, v in pairs(context.scoring_hand) do
                if IsEligibleForSeal(v) then
                    table.insert(cards, v)
                end
            end
            if #cards <= 0 then
                return {
                    message = localize('k_nope_ex'),
                    card = card,
                }
            end
            local randomcard = pseudorandom_element(cars, pseudoseed('talisman'))
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
                card:set_ability(G.P_CENTERS.j_soe_v_antimatterjoker)
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
        for k, v in pairs(SMODS.find_card('j_soe_v_antimatterjoker')) do
            weight = weight * v.ability.extra.weightmult
        end
        return weight
    end
}, true)

SMODS.DrawStep{
    key = 'boostershader',
    order = 10,
    func = function(self)
        if self.config.center.boostershader or self.ability.set == "soe_Phantom" then
            self.children.center:draw_shader('booster',nil, self.ARGS.send_to_shader)
        end
    end
}

--[[
SMODS.DrawStep{
    key = 'editionshaders',
    order = 21,
    func = function(self)
        if self and self.edition and self.ability and self.ability.soe_editions then
            for k, v in pairs(self.ability.soe_editions) do
                if "e_"..v ~= self.edition.key then
                    self.children.center:draw_shader(G.P_CENTERS["e_"..v].shader,nil, self.ARGS.send_to_shader)
                end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}
]]

SMODS.DrawStep{
    key = 'vouchershader',
    order = 20,
    func = function(self)
        if self.config.center.vouchershader or (self.ability and self.ability.soe_detached_seal == "Gold") then
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
        if (context.other_joker and (context.other_joker:get_seal() or (context.other_joker.ability.soe_legalenhancements and next(context.other_joker.ability.soe_legalenhancements)) or context.other_joker.ability.legallysleeve)) or (context.other_consumeable and context.other_consumeable:get_seal()) then
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
        extra = {
            lives = 1
        }
    },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.lives}}
    end,
    calculate = function(self, card, context)
        if context.game_over then
            card.ability.extra.lives = card.ability.extra.lives - 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    if card.ability.extra.lives < 1 then
                        card:start_dissolve()
                    end
                    return true
                end
            }))
            return {
                message = localize('k_saved_ex'),
                saved = "k_life_used",
                colour = G.C.RED
            }
        end
    end,
    in_pool = function(self)
        return false
    end,
    add_to_deck = function (self, card, from_debuff)
        if next(SMODS.find_card('j_soe_extralife')) then
            local total = 0
            for i, v in ipairs(G.jokers.cards) do
                if v ~= card and v.config.center.key == 'j_soe_extralife' then
                    total = total + (v.ability.extra.lives or 0)
                    v:start_dissolve()
                end
            end
            card.ability.extra.lives = (card.ability.extra.lives or 0) + total
        end
        card:set_edition("e_negative", true)
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
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "sealevolve", set = "Other" }
        info_queue[#info_queue + 1] = G.P_CENTERS.j_soe_sealjoker2
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local passed = true
            for k, v in pairs(G.playing_cards) do
                if not (v.edition and next(SMODS.get_enhancements(v)) and v.seal and v.ability and #SEALS.get_seals(v) >= 2) then
                    passed = false
                    break
                end
            end
            if passed then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card:juice_up(0.3, 0.5)
                        card:flip()
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        if card then
                            card:set_ability(G.P_CENTERS.j_soe_sealjoker2)
                        end
                        return true
                    end,
                }))
                delay(0.5)
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        play_sound("tarot2")
                        card:set_cost()
                        card:flip()
                        return true
                    end,
                }))
            end
        end
    end
}

SMODS.Joker{
    name = 'SealJoker2',
    key = 'sealjoker2',
    atlas = 'Exotics',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = (Entropy and "entr_entropic") or exoticrarity,
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    in_pool = function(self)
        return false
    end
}

local oldauracanuse = G.P_CENTERS.c_aura.can_use
SMODS.Spectral:take_ownership('c_aura',
    {
        can_use = function(self, card)
            if next(SMODS.find_card('j_soe_sealjoker2')) then
                return G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1]
            else
                if oldauracanuse then
                    return oldauracanuse(self, card)
                else
                    return G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] and (not G.hand.highlighted[1].edition)
                end
            end
        end
    },
true)

local oldevenstevencalc = G.P_CENTERS.j_even_steven.calculate
SMODS.Joker:take_ownership('j_even_steven',
    {
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                for _, id in ipairs(SEALS.get_ids(context.other_card)) do
                    if id <= 10 and id >= 0 and id % 2 == 0 then
                        return {
                            mult = card.ability.extra,
                            card = card
                        }
                    end
                end
            end
            if oldevenstevencalc then
                return oldevenstevencalc(self, card, context)
            end
        end
    },
true)

local oldoddtoddcalc = G.P_CENTERS.j_odd_todd.calculate
SMODS.Joker:take_ownership('j_odd_todd',
    {
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                for _, id in ipairs(SEALS.get_ids(context.other_card)) do
                    if ((id <= 10 and id >= 0 and id % 2 == 1) or (id == 14)) then
                        return {
                            chips = card.ability.extra,
                            card = card
                        }
                    end
                end
            end
            if oldoddtoddcalc then
                return oldoddtoddcalc(self, card, context)
            end
        end
    },
true)

if JokerDisplay then
    JokerDisplay.Definitions["j_even_steven"].calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                for _, id in ipairs(SEALS.get_ids(scoring_card)) do
                    if id <= 10 and id >= 0 and id % 2 == 0 then
                        mult = mult + card.ability.extra * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        break
                    end
                end
            end
        end
        card.joker_display_values.mult = mult
    end

    JokerDisplay.Definitions["j_odd_todd"].calc_function = function(card)
        local chips = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                for _, id in ipairs(SEALS.get_ids(scoring_card)) do
                    if ((id <= 10 and id >= 0 and id % 2 == 1) or (id == 14)) then
                        chips = chips + card.ability.extra * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        break
                    end
                end
            end
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.localized_text = "(" .. localize("Ace", "ranks") .. ",9,7,5,3)"
    end
end

function SEALS.parse_loc_txt(center)
    if not center then return nil end
	center.text_parsed = {}
    if center.text then
        for _, line in ipairs(center.text) do
            if type(line) == 'table' then
                center.text_parsed[#center.text_parsed + 1] = {}
                for _, new_line in ipairs(line) do
                    center.text_parsed[#center.text_parsed][#center.text_parsed[#center.text_parsed] + 1] =
                    loc_parse_string(new_line)
                end
            else
                center.text_parsed[#center.text_parsed + 1] = loc_parse_string(line)
            end
        end
        center.name_parsed = {}
        for _, line in ipairs(type(center.name) == 'table' and center.name or { center.name }) do
            center.name_parsed[#center.name_parsed + 1] = loc_parse_string(line)
        end
        if center.unlock then
            center.unlock_parsed = {}
            for _, line in ipairs(center.unlock) do
                center.unlock_parsed[#center.unlock_parsed + 1] = loc_parse_string(line)
            end
        end
    end
end

function SEALS.get_card_name(card, ui, vars)
    if not (card and card.ability and (card.ability.soe_quantum_suits or card.ability.soe_quantum_ranks)) then
        localize{type = 'other', key = 'playing_card', set = 'Other', nodes = ui, vars = {localize(vars.value, 'ranks'), localize(vars.suit, 'suits_plural'), colours = {vars.colour}}}
        return nil
    elseif card and card.ability and (card.ability.soe_quantum_suits or card.ability.soe_quantum_ranks) then
        G.localization.descriptions.Other.playing_card2 = {
            text_part1 = {
                "{C:light_black}#1#"
            },
            text_part2 = {
                "{V:1}#2#",
            },
        }
        local ize = {type = 'other', key = 'playing_card2', set = 'Other', nodes = ui, vars = {localize(vars.value, 'ranks'), localize(vars.suit, 'suits_plural'), colours = {vars.colour}}}
        local total = 0
        if card.ability.soe_quantum_ranks then
            for i = 1, #card.ability.soe_quantum_ranks do
                total = total + 1
                G.localization.descriptions.Other.playing_card2.text_part1[1] = G.localization.descriptions.Other.playing_card2.text_part1[1] .. ("/#%s#"):format(total + 2)
                table.insert(ize.vars, localize(card.ability.soe_quantum_ranks[i], 'ranks'))
            end
        end
        if card.ability.soe_quantum_suits then
            for i = 1, #card.ability.soe_quantum_suits do
                total = total + 1
                G.localization.descriptions.Other.playing_card2.text_part2[1] = G.localization.descriptions.Other.playing_card2.text_part2[1] .. ("{}/{V:%s}#%s#"):format(total + 1, total + 2)
                table.insert(ize.vars, localize(card.ability.soe_quantum_suits[i], 'suits_plural'))
                table.insert(ize.vars.colours, G.C.SUITS[card.ability.soe_quantum_suits[i]])
            end
        end
        G.localization.descriptions.Other.playing_card2.text = {" "..G.localization.descriptions.Other.playing_card2.text_part1[1].." of "..G.localization.descriptions.Other.playing_card2.text_part2[1].." "}
        SEALS.parse_loc_txt(G.localization.descriptions.Other.playing_card2)
        localize(ize)
    end
end

if cryptidyeohna and Talisman then
    SMODS.Joker{
        name = 'ThinkingEmoji',
        key = 'thinkingemoji',
        atlas = 'Think',
        pos = {x = 0, y = 0},
        soul_pos = {x = 1, y = 0},
        config = {extra = {emult_mod = 0.2, idea_count = 19, sealemult = 2.2}},
        rarity = "cry_exotic",
        cost = 62,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.emult_mod, card.ability.extra.emult or (1 + (card.ability.extra.emult_mod * card.ability.extra.idea_count)), card.ability.extra.sealemult}}
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                card.ability.extra.emult = 1 + (card.ability.extra.emult_mod * card.ability.extra.idea_count)
                return {
                    emult = card.ability.extra.emult,
                    emult_message = {
                        message = "^"..card.ability.extra.emult.." "..localize("k_mult"),
                        colour =  G.C.DARK_EDITION,
                        sound = Talisman and "talisman_emult" or "cry_emult",
                    }
                }
            end
            if context.other_main and context.other_main ~= card then
                local key, set = context.other_main.config.center.key, context.other_main.config.center.set
                local name = localize({type = 'name_text', key = key, set = set})
                local description = ''
                if type(G.localization.descriptions[set][key].text[1]) == 'string' then
                    description = table.concat(G.localization.descriptions[set][key].text)
                elseif type(G.localization.descriptions[set][key].text[1]) == 'table' then
                    for i, v in ipairs(G.localization.descriptions[set][key].text) do
                        description = description .. table.concat(v)
                    end
                end
                local searchline = name .. description
                searchline = string.gsub(searchline, "{[^}]+}", "")
                searchline = string.gsub(searchline, "#[^#]+#", "")
                searchline = string.gsub(searchline, "{}", "")
                searchline = string.gsub(searchline, " ", "")
                searchline = string.lower(searchline)
                if searchline:match("seal") then
                    return {
                        emult = card.ability.extra.sealemult,
                        emult_message = {
                            message = "^"..card.ability.extra.sealemult.." "..localize("k_mult"),
                            colour =  G.C.DARK_EDITION,
                            sound = Talisman and "talisman_emult" or "cry_emult",
                        }
                    }
                end
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
		if context.post_trigger and context.other_card.set_seal and not context.other_card:is_rarity('soe_infinity') then
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                card = card,
                message_card = card,
                func = function()
                    local other_card = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:set_seal('Red', nil, true)
                            return true
                        end
                    }))
                end
            }
		end
        if context.individual and context.cardarea == G.play then
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                card = card,
                message_card = card,
                func = function()
                    local other_card = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:set_seal('Red', nil, true)
                            return true
                        end
                    }))
                end
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
    calculate = function (self, card, context)
        if ((context.individual and context.cardarea == G.play) or (context.post_trigger)) and next(SEALS.get_seals(context.other_card)) then
            return {func = function()
                local results = SEALS.forcetriggerseals(context.other_card)
                if results then
                    for i, v in ipairs(results) do
                        v.message_card = card
                        v.remove_default_message = true
                        v.message = "Sealtrigger!"
                        v.colour = G.C.PURPLE
                        if cryptidyeohna then v.sound = "cry_demitrigger" end
                    end
                    results = SMODS.merge_effects(results)

                    SMODS.calculate_effect(results, card)
                end
            end}
        end
    end
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
    config = {extra = {dollars = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    calculate = function(self, card, context)
        if context.post_trigger or (context.individual and (context.cardarea == G.play or context.cardarea == G.hand)) then
            local other_card = context.other_main or context.other_card
            local count = #SEALS.get_seals(other_card, nil, true)
            if count > 0 then
                return {
                    message = 'Gold!!!',
                    colour = G.C.GOLD,
                    dollars = count*card.ability.extra.dollars,
                    card = card,
                    message_card = card,
                    remove_default_message = true
                }
            end
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
    config = {extra = {odds = 8}},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function (self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {numerator, denominator}}
    end,
    calculate = function (self, card, context)
        --[[
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            table.insert(card.ability.extra.planets, context.consumeable.config.center.key)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.BLUE
            }
        end
        if context.joker_main and next(card.ability.extra.planets) then
            return {func = function()
                SMODS.calculate_effect({message = "Blue!!!", colour = G.C.BLUE}, card)
                local vals_after_level
                if SMODS.displaying_scoring then
                    vals_after_level = copy_table(G.GAME.current_round.current_hand)
                    vals_after_level.level = (G.GAME.hands[vals_after_level.handname] or {}).level or ''
                end
                for i, v in ipairs(card.ability.extra.planets) do
                    local center = G.P_CENTERS[v]
                    local fake_card = {config = {}}
                    SEALS.safe_set_ability(fake_card, center, true)
                    for k, v in pairs(Card) do
                        if type(v) == 'function' then
                            fake_card[k] = v
                        end
                    end
                    fake_card.juice_up = function(self, ...) return card:juice_up(...) end
                    SMODS.calculate_effect({message = localize({type = "name_text", key = v, set = "Planet"}), colour = G.C.BLUE}, card)
                    Card.use_consumeable(fake_card)
                end
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, vals_after_level or {mult = 0, chips = 0, handname = '', level = ''})
            end}
        end
        ]]
        if context.individual and context.cardarea == G.play and not (context.other_card.area == G.jokers and context.other_card.ability.set == 'Joker') then
            if SMODS.pseudorandom_probability(card, 'infinityblue', 1, card.ability.extra.odds) then
                return {
                    message = localize('k_copied_ex'),
                    message_card = card,
                    colour = G.C.BLUE,
                    func = function()
                        local other_card = context.other_card
                        SEALS.event(function()
                            local enhancements, seals, editions = SEALS.get_enhancements(other_card), SEALS.get_seals(other_card), {}
                            if other_card.edition then table.insert(editions, other_card.edition.type) end
                            for i, v in ipairs(SEALS.get_quantum_editions(other_card)) do
                                table.insert(editions, v)
                            end
                            editions[1] = 'negative'
                            local newcard = SMODS.add_card({key = 'j_joker', seal = seals[1], edition = 'e_negative'})
                            if enhancements[1] and G.P_CENTERS[enhancements[1]] and (G.P_CENTERS[enhancements[1]].replace_base_card or enhancements[1] == 'm_stone') then
                                newcard:set_ability('j_soe_'..(enhancements[1] == 'm_stone' and 'stone' or G.P_CENTERS[enhancements[1]].original_key or enhancements[1])..'cardjoker')
                            end
                            newcard:set_base(other_card.config.card)
                            newcard.ability.soe_quantum_suits = other_card.ability.soe_quantum_suits
                            newcard.ability.soe_quantum_ranks = other_card.ability.soe_quantum_ranks
                            newcard.ability.soe_editions = editions
                            for i, v in ipairs(enhancements) do
                                if i > 1 or not (enhancements[1] and G.P_CENTERS[enhancements[1]] and (G.P_CENTERS[enhancements[1]].replace_base_card or enhancements[1] == 'm_stone')) then
                                    SEALS.set_joker_enhancement(newcard, v)
                                end
                            end
                            for i, v in ipairs(seals) do
                                if i > 1 then
                                    newcard:set_seal(v, true, true)
                                end
                            end
                            return true
                        end)
                    end
                }
            end
        end
    end
}

if cryptidyeohna then
    local oldsmodssoundscrymusicexoticselectmusictrack = SMODS.Sounds.cry_music_exotic.select_music_track
    SMODS.Sounds.cry_music_exotic.select_music_track = function()
        return (Cryptid_config and Cryptid_config.Cryptid and Cryptid_config.Cryptid.exotic_music and (not not next(Cryptid.advanced_find_joker(nil, "soe_infinity", nil, nil, true)))) or oldsmodssoundscrymusicexoticselectmusictrack()
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
        if card.ability.soe_quantum_seals and #card.ability.soe_quantum_seals > 0 and context.before then
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
    atlas = 'RainbowSeal',
    pos = { x = 0, y = 0 },
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

function SEALS.has_seal(card, seal)
    if card.seal == seal then
        return true
    end
    if table.contains(SEALS.get_seals(card, true), seal) then
        return true
    end
    if card.ability and card.ability['soe_has_'..seal] then
        return true
    end
    return false
end

function SEALS.remove_seal(card, seal)
    seal = seal or card.seal or (card.ability.soe_quantum_seals and card.ability.soe_quantum_seals[1]) or nil
    if not seal then return nil end
    card:set_seal(card.ability.soe_quantum_seals and card.ability.soe_quantum_seals[1] or nil, true, true, true)
    if card.ability.soe_quantum_seals and card.ability.soe_quantum_seals[1] then
        table.remove(card.ability.soe_quantum_seals, 1)
    end
end

function SEALS.weighted_random(table, seed)
    local total = 0
    for _, weight in pairs(table) do
        total = total + weight
    end
    local random = pseudorandom(seed) * total
    local number = 0
    for key, weight in pairs(table) do
        number = number + weight
        if random <= number then
            return key
        end
    end
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

SMODS.Seal{
    key = 'foilseal',
    name = 'FoilSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    draw = function(self, card, layer)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('foil', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

--[[
function SEALS.predict_pseudoseed(key, key2)
    local pseudokey = key2 or G.GAME.pseudorandom[key]
    local g = pseudokey or pseudohash(key .. (G.GAME.pseudorandom.seed or ""))
    local g2 = math.abs(tonumber(string.format("%.13f", (2.134453429141 + g * 1.72431234) % 1)))
    return (g2 + (G.GAME.pseudorandom.hashed_seed or 0)) / 2, g2
end

function SEALS.get_pseudoseed_forecast(seed, untilfunc)
    local result, depth, results, fakekey
    repeat
        if not fakekey then
            fakekey = pseudohash(seed..(G.GAME.pseudorandom.seed or ''))
        end
        result, fakekey = SEALS.predict_pseudoseed(seed, fakekey)
        table.insert(results, result)
        depth = depth + 1
    until untilfunc(result, depth)
    return results, depth
end

local oldsmodspseudorandomprobability = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, seed, base_numerator, base_denominator)
	local numerator, denominator = SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator)
    local card = trigger_obj or {}
    _, card.retriggersuntilhit = SEALS.get_pseudoseed_forecast(seed, function (result, depth)
        if pseudorandom(result) < numerator / denominator then
            return true
        end
        return false
    end)
	return oldsmodspseudorandomprobability(trigger_obj, seed, base_numerator, base_denominator)
end

SMODS.Seal{
    key = 'holoseal',
    name = 'HolographicSeal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    draw = function(self, card, layer)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('holo', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}
]]

SMODS.Seal{
    key = 'rustyseal',
    name = 'RustySeal',
    badge_colour = HEX("D3795C"),
    atlas = 'Seals',
    config = {extra = {xmult = 1.5}},
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.seal.extra.xmult}}
    end,
    forcetrigger = function(self, card)
        return {x_mult = card.ability.seal.extra.xmult}
    end
}

local oldsmodscalculaterepetitions = SMODS.calculate_repetitions
SMODS.calculate_repetitions = function(card, context, reps)
    G.repetitioned_card = card
    local g = oldsmodscalculaterepetitions(card, context, reps)
    G.repetitioned_card = nil
    return g
end

local oldsmodscalculateretriggers = SMODS.calculate_retriggers
SMODS.calculate_retriggers = function(card, context, _ret)
    G.repetitioned_card = card
    local g = oldsmodscalculateretriggers(card, context, _ret)
    G.repetitioned_card = nil
    return g
end

local oldcalculateedition = Card.calculate_edition
function Card:calculate_edition(context)
    if self and self.ability and self.ability.set == "Joker" and SEALS.has_seal(self, 'soe_foilseal') then
        if context.post_trigger and context.other_card == self then
            local thunk = {context.pre_joker, context.post_joker, context.edition, self.config.trigger}
            context.pre_joker = true
            context.post_joker = true
            context.edition = true
            self.config.trigger = true
            local g = oldcalculateedition(self, context)
            context.pre_joker = thunk[1]
            context.post_joker = thunk[2]
            context.edition = thunk[3]
            self.config.trigger = thunk[4]
            if g then
                g.message_card = self
                return g
            end
        elseif (context.pre_joker or context.post_joker or context.edition) then
            return nil
        end
    end
    return oldcalculateedition(self, context)
end

local oldhighlight = Card.highlight
function Card:highlight(highlighted)
    local g = oldhighlight(self, highlighted)
    if SEALS.has_seal(self, 'soe_negativeseal') then
        if not highlighted and self.config.negative_enabled then
            self.config.negative_enabled = false
            SMODS.change_play_limit(-1)
            SMODS.change_discard_limit(-1)
        end
    end
    return g
end

local oldaddhighlighted = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if SEALS.has_seal(card, 'soe_negativeseal') and not card.config.negative_enabled then
        card.config.negative_enabled = true
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
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
            if deckkey and G.P_CENTERS[deckkey] then
                self.config = G.P_CENTERS[deckkey].config
                local vars
                if G.P_CENTERS[deckkey].loc_vars then
                    vars = (G.P_CENTERS[deckkey]:loc_vars() or {}).vars
                end
                tempstring = table.concat(localize({type = 'raw_descriptions', key = deckkey, set = 'Back', vars = vars}), ' ')
            end
            return {vars = {tempstring or "Nothing"}, key = key}
        end,
        apply = function(self, sleeve)
            CardSleeves.Sleeve.apply(self)
            local deckkey = self.get_current_deck_key()
            if deckkey and G.P_CENTERS[deckkey] and G.P_CENTERS[deckkey].apply then
                G.P_CENTERS[deckkey]:apply(G.P_CENTERS[deckkey])
            end
        end,
        calculate = function(self, sleeve, context)
            local deckkey = self.get_current_deck_key()
            if deckkey and G.P_CENTERS[deckkey] and G.P_CENTERS[deckkey].calculate then
                return G.P_CENTERS[deckkey]:calculate(G.P_CENTERS[deckkey], context)
            end
        end
    }
    CardSleeves.Sleeve {
        key = "goldseal",
        atlas = "DeckSeals",
        pos = { x = 3, y = 0 },
        calculate = function(self, sleeve, context)
            if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
                return {
                    dollars = 3,
                    message_card = context.other_card
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
        rank = SMODS.Ranks[_card.value].id
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

local configoptions = {}

if SEALS.find_mod("JokerDisplay") then
    configoptions[#configoptions + 1] = create_toggle({
		label = "Enable JokerDisplay on Non-Jokers (Quite unstable!)",
        ref_table = SEALS.config,
        ref_value = "nonjokerdisplay",
		callback = function()
        end,
	})
    JokerDisplay.Definitions["c_temperance"] = { -- Temperance
        text = {
            { text = "$", colour = G.C.MONEY },
            { ref_table = "card.joker_display_values", ref_value = "count", colour = G.C.MONEY },
        },
        calc_function = function(card)
            local count = 0
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.set == 'Joker' then
                        count = count + G.jokers.cards[i].sell_cost
                    end
                end
            end
            card.joker_display_values.count = math.min(50, count)
        end,
    }
end

configoptions[#configoptions + 1] = create_toggle({
    label = "Disable synonym music",
    ref_table = SEALS.config,
    ref_value = "synonymmusicdisable",
    callback = function()
    end,
})

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
        nodes = configoptions,
    }
end

SEALS.seal_dt = 0
SEALS.rainbow_seal_dt = 0
SEALS.detached_red_seal_dt = 0
local oldgameupdate = Game.update
function Game:update(dt)
    local g = oldgameupdate(self, dt)
    if G.title_top and G.title_top.cards and G.title_top.cards[1] then
        SEALS.seal_dt = SEALS.seal_dt + dt
        if SEALS.seal_dt > 0.2 then 
            SEALS.seal_dt = SEALS.seal_dt - 0.2
            for i, v in ipairs(G.title_top.cards) do
                local seal, _ = pseudorandom_element(G.P_SEALS, pseudoseed('seal'))
                v:set_seal(seal.key, true, true)
            end
        end
    end
    if G.P_SEALS.soe_rainbowseal and G.shared_seals.soe_rainbowseal then
        SEALS.rainbow_seal_dt = SEALS.rainbow_seal_dt + dt
        if SEALS.rainbow_seal_dt > 0.02 then
            SEALS.rainbow_seal_dt = SEALS.rainbow_seal_dt - 0.02
			local rainbow = G.P_SEALS.soe_rainbowseal
			if rainbow.pos.x == 19 and rainbow.pos.y == 17 then --Last frame of animation
				rainbow.pos.x = 0
				rainbow.pos.y = 0
			elseif rainbow.pos.x < 19 then --If it isnt the right most image
				rainbow.pos.x = rainbow.pos.x + 1
			elseif rainbow.pos.y < 17 then --If it isnt the bottom most image
				rainbow.pos.x = 0
				rainbow.pos.y = rainbow.pos.y + 1
			end
            G.shared_seals.soe_rainbowseal:set_sprite_pos(rainbow.pos)
        end
    end
    if G.STAGE == G.STAGES.RUN and G.GAME.soe_detached_seals and not G.GAME.SEALS_Scoring_Active and not G.soe_event_scoring and next(G.GAME.soe_detached_seals) then
        SEALS.detached_red_seal_dt = SEALS.detached_red_seal_dt + dt
        if SEALS.detached_red_seal_dt > 2 then
            --sendInfoMessage("Updating Detached Red Seals", "SEALS")
            --play_sound('generic1')
            SEALS.detached_red_seal_dt = SEALS.detached_red_seal_dt - 2
            for i, v in ipairs(G.GAME.soe_detached_seals) do
                if v and v.ability and v.ability.soe_detached_seal == 'Red' then
                    v.ability.extra.card = SEALS.get_closest_card(v, true).sort_id
                end
            end
        end
    end
    return g
end

local oldupdate = Card.update
function Card:update(dt)
    if self.playing_card and SEALS and JokerDisplay and SEALS.config.nonjokerdisplay then
        self.base.soe_chip_value = self:get_chip_bonus()
    end
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

local oldcardstartdissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.added_to_deck and G.STAGE == G.STAGES.RUN and not self.playing_card and not G.CONTROLLER.locks.selling_card then
        SMODS.calculate_context({soe_remove = true, soe_removed = self})
    end
    return oldcardstartdissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

local oldcardareaemplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if card and type(card) == "table" then
        card.soe_lastcardarea = self
    end
    return oldcardareaemplace(self, card, location, stay_flipped)
end

local oldcardsetcardarea = Card.set_card_area
function Card:set_card_area(area)
    local g = oldcardsetcardarea(self, area)
    if area and type(area) == "table" then
        self.soe_lastcardarea = area
    end
    return g
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
            if context.game_over and to_big(G.GAME.chips)/G.GAME.blind.chips >= to_big(0.25) and not context.retrigger_joker then
                local effects = {{
                    no_retrigger = true,
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED,
                }}
                if SEALS.has_seal(card, 'Red') then
                    table.insert(effects, {
                        message = localize('k_again_ex'),
                        colour = G.C.FILTER
                    })
                    table.insert(effects, {
                        message = 'Extra Life!',
                        func = function()
                            SEALS.event(function()
                                local extralife = SMODS.add_card({key = 'j_soe_extralife'})
                                extralife.ability.extra.lives = SEALS.get_seal_count(card, 'Red')
                                return true
                            end)
                        end
                    })
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
                return SMODS.merge_effects(effects)
            end
        end
    },
    true
)

SMODS.DrawStep{
    key = 'sealsforall',
    order = 100,
    func = function(self)
        if (self.ability.set ~= 'Joker' and (self.ability.set ~= 'Default' and self.ability.set ~= 'Enhanced')) and self.seal then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

local oldmainmenu = Game.main_menu
function Game:main_menu(change_context)
    local g = oldmainmenu(self, change_context)
    G.shared_secondseals = {Red = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_SecondSeals"], {x = 5, y = 4})}
    G.shared_jokerenhancements = {m_bonus = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 1, y = 1}), m_mult = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 2, y = 1}), m_wild = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 3, y = 1})}
    G.shared_sleeves = {Plasma = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_VanillaSleeves"], {x = 3, y = 2})}
    G.shared_jokerfronts = {}
    G.shared_psyche = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_Enhancers"], {x = 0, y = 1})
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        if v.soe_is_planet_joker and v.soe_planet_mod then
            v.atlas = G.P_CENTERS[v.soe_planet_key].atlas
            G.localization.descriptions.Joker[v.key].name = localize({type = 'name_text', key = v.soe_planet_key, set = 'Planet'}).." Joker"
            SEALS.parse_loc_txt(G.localization.descriptions.Joker[v.key])
        end
        if v.soe_is_enhancement_joker and v.soe_enhancement_mod then
            v.atlas = G.P_CENTERS[v.soe_enhancement_key].atlas
            G.localization.descriptions.Joker[v.key].name = localize({type = 'name_text', key = v.soe_enhancement_key, set = 'Enhanced'}).." Joker"
            G.localization.descriptions.Joker[v.key].text = G.localization.descriptions.Enhanced[v.soe_enhancement_key].text
            SEALS.parse_loc_txt(G.localization.descriptions.Joker[v.key])
        end
        if not v.original_mod then
            G.shared_jokerfronts[v.key] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["soe_JokerFronts"], v.pos or {x = 0, y = 0})
        end
    end
    for k, v in pairs(G.P_CENTER_POOLS.Consumeables) do
        if v.atlas == 'soe_What' then
            v.set_badges = function(self, card, badges)
                badges[#badges+1] = create_badge('Art: poundpound0209', SMODS.Gradients.soe_synonym_gradient, HEX('FFFFFF'))
            end
        end
    end
    for k, v in pairs(SMODS.Stickers) do
        local oldapply = v.apply
        v.apply = function(self, card, val)
            if val and card.ability[self.key] then
                card.ability.soe_quantum_stickers = card.ability.soe_quantum_stickers or {}
                card.ability.soe_quantum_stickers[self.key] = (card.ability.soe_quantum_stickers[self.key] or 0) + 1
            end
            return oldapply(self, card, val)
        end
    end
    return g
end

--[[
SMODS.DrawStep{
    key = 'randomplacedsealsforall',
    order = 110,
    func = function(self)
        if self and self.ability and SEALS.get_seals(self, true) then
            for i, v in ipairs(SEALS.get_seals(self, true)) do
                if not self.children["extraseal"..i] then
                    self.children["extraseal"..i] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS[G.P_SEALS[v].atlas], G.P_SEALS[v].pos)
                    self.children["extraseal"..i].role.draw_major = self
                    self.children["extraseal"..i].scale.x = 32*self.T.scale
                    self.children["extraseal"..i].scale.y = 32*self.T.scale
                    local pos = {x = pseudorandom("seal"), y = pseudorandom("seal2")}
                    self.children["extraseal"..i]:draw_shader('dissolve', 0, nil, nil, self.children.center, nil, nil, pos.x*(self.T.w/71), pos.y*(self.T.h/95) + (0.1+0.03*math.sin(1.8*G.TIMERS.REAL)), nil, 0.6)
                    self.children["extraseal"..i]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, pos.x*(self.T.w/71), pos.y*(self.T.h/95))
                end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}
]]

SMODS.DrawStep{
    key = 'threeenhancementsforjokers',
    order = 90,
    func = function(self, card)
        local passed = {}
        for k, v in pairs(self.ability.soe_legalenhancements or {}) do
            if (k == 'm_wild' or k == 'm_bonus' or k == 'm_mult') and not passed[k] then
                G.shared_jokerenhancements[k].role.draw_major = self
                G.shared_jokerenhancements[k]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                passed[k] = true
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.DrawStep{
    key = 'sleevesforjokersandplayingcards',
    order = 200,
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
    order = 0,
    func = function(self, card)
        if self.ability.soe_legalenhancements and (self.ability.soe_legalenhancements.m_lucky or self.ability.soe_legalenhancements.m_gold or self.ability.soe_legalenhancements.m_steel or self.ability.soe_legalenhancements.m_glass) and not self.config.center.original_mod and G.shared_jokerfronts[self.config.center.key] then
            if not self.oldatlas or not self.oldpos then
                self.oldatlas = self.children.center.atlas
                self.oldpos =  self.children.center.sprite_pos
            end
            self.children.center.atlas = G.ASSET_ATLAS["soe_Enhancers"]
            local center
            for k, v in pairs(self.ability.soe_legalenhancements) do
                if k == 'm_lucky' or k == 'm_gold' or k == 'm_steel' or k == 'm_glass' then
                    center = G.P_CENTERS[k]
                    break
                end
            end
            self.children.center:set_sprite_pos(center.pos)
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
            if not (joker.ability.soe_legalenhancements and next(joker.ability.soe_legalenhancements)) then
                print('Highlighted joker is not enhanced')
                return nil
            end
            print("Highlighted joker is enhanced with:")
            for k, v in pairs(joker.ability.soe_legalenhancements) do
                if v and next(v) then
                    print(localize({type = 'name_text', key = k, set = 'Enhanced'})..' '..#v..' time'..((#v == 1) and '' or 's'))
                end
            end
        end
    end
}