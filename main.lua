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
    key = 'EnhancementsForJokers',
    path = 'EnhancementsForJokers.png',
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
    key = 'JokerSynonyms',
    path = 'Jokersynonyms.png',
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
    px = 73,
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
    path = 'RainbowSeal.png',
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
    py = 95
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

SMODS.Atlas{
    key = 'Stickers',
    path = 'Stickers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Indicators',
    path = 'Indicators.png',
    px = 71,
    py = 95
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

SMODS.Sound{
    key = 'frozen',
    path = 'frozen.ogg',
}

SMODS.Font {
    key = '11x6m',
    path = '11x6m.ttf',
    render_scale = 200,
    TEXT_HEIGHT_SCALE = 0.83,
    TEXT_OFFSET = {x = 10, y = 0},
    FONTSCALE = 0.1,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Shader {
    key = 'invisible',
    path = 'invisible.fs',
    send_vars = function(sprite, _)
        return {pixel_x_range_start = sprite.pixel_x_range_start or 0, pixel_x_range_end = sprite.pixel_x_range_end or 71, pixel_y_range_start = sprite.pixel_y_range_start or 0, pixel_y_range_end = sprite.pixel_y_range_end or 95}
    end
}

SMODS.Shader {
    key = 'frozen',
    path = 'frozen.fs',
}

local fl, ps, pe, is, sc, emptyfunc = math.floor, pseudoseed, pseudorandom_element, Object.is, SMODS.shallow_copy, function() end

local NFS = SMODS.NFS or NFS

SEALS = SMODS.current_mod

SEALS.no_marquee = true
SEALS.optional_features = function()
    return {
        retrigger_joker = true,
        post_trigger = true,
    }
end

to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

function SEALS.find_mod(id)
    local mod = SMODS.Mods[id]
    return mod and mod.can_load
end

local has_cryptid = SEALS.find_mod('Cryptid')

local function tc(t, e)
    if e == nil then return false end
    if t and type(t) == 'table' then
        for _, v in pairs(t) do
            if v == e then
                return true
            end
        end
    end
    return false
end

local function true_localize(...)
    local ize = localize(...)
    if ize ~= 'ERROR' then return ize end
end

function SEALS.is_eligible_for_seal(card)
    if not card.seal then return true end
    if G.deck and SEALS.has_seal(card, 'soe_sealseal') then return true end
    if SMODS.find_card('j_soe_sealjoker')[1] or SMODS.find_card('j_soe_sealjoker2')[1] then return true end
    return false
end

function SEALS.counts_as_everything(card)
    if not G.deck then return end
    if card.seal == 'soe_upgradedsoe_rainbowsealseal' then return true end
    for _, area in ipairs(SMODS.get_card_areas('jokers')) do
        if area.cards then
            for _, v in pairs(area.cards) do
                if v.config.center_key == 'j_soe_infinityomega' then
                    return true
                end
            end
        end
    end
end

local oldwingame = win_game
function win_game()
    if not G.GAME.seeded and not G.GAME.challenge then
        for _, v in ipairs(G.playing_cards) do
            local key = v.base.value..v.base.suit..(v.seal or '')..v.config.center_key..(v.edition and v.edition.key or '')
            local card_stickers = G.PROFILES[G.SETTINGS.profile].soe_card_stickers or {}
            G.PROFILES[G.SETTINGS.profile].soe_card_stickers = card_stickers
            card_stickers[key] = card_stickers[key] or {count = 1, wins = {}, losses = {}, wins_by_key = {}, losses_by_key = {}}
            if card_stickers[key] then
                card_stickers[key].wins = card_stickers[key].wins or {}
                card_stickers[key].wins[G.GAME.stake] = (card_stickers[key].wins[G.GAME.stake] or 0) + 1
                card_stickers[key].wins_by_key[SMODS.stake_from_index(G.GAME.stake)] = (card_stickers[key].wins_by_key[SMODS.stake_from_index(G.GAME.stake)] or 0) + 1
            end
        end
        G:save_settings()
    end
    oldwingame()
end

SMODS.Consumable{
    key = 'dejavuq',
    set = 'Spectral',
    atlas = 'What',
    pos = {x = 0, y = 0},
    config = {mod_conv = 'Red', cards = 1},
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'red_seal_joker', set = 'Other'}
    end,
    unlocked = true,
    discovered = true,
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('dejavu'))
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
                        highlighted:set_seal('Red', nil, true)
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
    config = {mod_conv = 'Blue', cards = 1},
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'blue_seal_joker', set = 'Other'}
    end,
    unlocked = true,
    discovered = true,
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('trance'))
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
                        highlighted:set_seal('Blue', nil, true)
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
    config = {mod_conv = 'Gold', cards = 1},
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'gold_seal_joker', set = 'Other'}
    end,
    unlocked = true,
    discovered = true,
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('talisman'))
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
                        highlighted:set_seal('Gold', nil, true)
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
    config = {mod_conv = 'Purple', cards = 1},
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'purple_seal_joker', set = 'Other'}
    end,
    unlocked = true,
    discovered = true,
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if SEALS.is_eligible_for_seal(v) then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('medium'))
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
                        highlighted:set_seal('Purple', nil, true)
                    end
                    return true
                end,
            }))
        end
    end
}

if has_cryptid then
    SMODS.Consumable{
        key = 'typhoonq',
        set = 'Spectral',
        atlas = 'What',
        pos = {x = 4, y = 0},
        config = {mod_conv = 'cry_azure', cards = 1},
        loc_vars = function(_, info_queue)
            info_queue[#info_queue+1] = {key = 'cry_azure_seal_joker', set = 'Other'}
        end,
        unlocked = true,
        discovered = true,
        can_use = function()
            for _, v in ipairs(G.jokers.cards) do
                if SEALS.is_eligible_for_seal(v) then
                    return true
                end
            end
            return false
        end,
        use = function()
            local eligible = {}
            for _, v in ipairs(G.jokers.cards) do
                if SEALS.is_eligible_for_seal(v) then
                    eligible[#eligible+1] = v
                end
            end
            local highlighted = pe(eligible, ps('typhoon'))
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
                            highlighted:set_seal('cry_azure', nil, true)
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
        config = {mod_conv = 'cry_green', cards = 1},
        loc_vars = function(_, info_queue)
            info_queue[#info_queue+1] = {key = 'cry_green_seal_joker', set = 'Other'}
        end,
        unlocked = true,
        discovered = true,
        can_use = function()
            for _, v in ipairs(G.jokers.cards) do
                if SEALS.is_eligible_for_seal(v) then
                    return true
                end
            end
            return false
        end,
        use = function()
            local eligible = {}
            for _, v in ipairs(G.jokers.cards) do
                if SEALS.is_eligible_for_seal(v) then
                    eligible[#eligible+1] = v
                end
            end
            local highlighted = pe(eligible, ps('source'))
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
                            highlighted:set_seal('cry_green', nil, true)
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
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('devil'))
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
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements)) and not v.config.center.soe_is_enhancement_joker) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements)) and not v.config.center.soe_is_enhancement_joker) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('tower'))
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
    can_use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('chariot'))
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
    can_use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('empress'))
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
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('hierophant'))
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
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('magician'))
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
    can_use = function()
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.jokers.cards) do
            if (not (v.ability.soe_legalenhancements and next(v.ability.soe_legalenhancements))) or SMODS.find_card('j_soe_sealjoker2')[1] then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('justice'))
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
    can_use = function()
        for _, v in ipairs(G.hand.cards) do
            if not v.ability.eternal then
                return true
            end
        end
        return false
    end,
    use = function()
        local eligible = {}
        for _, v in ipairs(G.hand.cards) do
            if not v.ability.eternal then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('eternal'))
        if highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    highlighted:juice_up(0.3, 0.5)
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    highlighted:add_sticker('eternal', true)
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
    config = {mod_conv = 'Red', cards = 1},
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'red_seal_joker', set = 'Other'}
    end,
    unlocked = true,
    discovered = true,
    can_use = function(_, card)
        for _, v in ipairs(G.consumeables.cards) do
            if SEALS.is_eligible_for_seal(v) and v ~= card then
                return true
            end
        end
        return false
    end,
    use = function(_, card)
        local eligible = {}
        for _, v in ipairs(G.consumeables.cards) do
            if SEALS.is_eligible_for_seal(v) and v ~= card then
                eligible[#eligible+1] = v
            end
        end
        local highlighted = pe(eligible, ps('dejavu'))
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
    key = 'tdejince',
    set = 'Spectral',
    atlas = 'Confusion',
    pos = {x = 2, y = 0},
    config = {max_highlighted = 1},
    unlocked = true,
    discovered = true,
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'soe_upgrade_seal', set = 'Other'}
    end,
    use = function(_, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                G.hand.highlighted[1]:set_seal(SMODS.poll_seal({guaranteed = true}), nil, true)
                return true
            end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}

local function calculate_distance(point1, point2)
    return math.sqrt((point2[1] - point1[1])^2 + (point2[2] - point1[2])^2)
end

local function find_closest_point(target_point, points)
    local min_distance = 1e309
    local closest_point
    for i = 1, #points do
        local distance = calculate_distance(target_point, points[i])
        if distance < min_distance then
            min_distance = distance
            closest_point = points[i]
        end
    end
    return closest_point
end

function SEALS.get_closest_card(card, fromred)
    local points = {}
    local target_point = {card.T.x + card.T.w/2, card.T.y + card.T.h/2}
    for _, v in ipairs(G.I.CARD) do
        if v ~= card and v.area then
            if fromred then v.ability.soe_has_Red = nil end
            points[#points+1] = {v.T.x + v.T.w/2, v.T.y + v.T.h/2, card = v}
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
    oldcardstopdrag(self)
    if G.deck then
        if self and self.ability and self.ability.soe_detached_seal == 'Red' then
            self.ability.extra.card = SEALS.get_closest_card(self, true).unique_val
        end
    end
end

SEALS.detached_seals = {
    Red = {
        config = {extra = {retriggers = 1}},
        calculate = function(_, card, context)
            if context.press_play then
                card.ability.extra.card = SEALS.get_closest_card(card, true).unique_val
            end
            if card.ability.extra.card and (context.retrigger_joker_check or context.repetition) and context.other_card and context.other_card.area and is(context.other_card, Card) and context.other_card.unique_val == card.ability.extra.card then
                return {repetitions = card.ability.extra.retriggers}
            end
        end,
        loc_vars = function(_, card)
            return {vars = {card.ability.extra.retriggers}}
        end
    },
    Blue = {
        calculate = function(_, _, context)
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
                return {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet}
            end
        end
    },
    Gold = {
        config = {extra = {dollars = 3}},
        calculate = function(_, card, context)
            if context.before or context.forcetrigger then
                return {dollars = card.ability.extra.dollars, card = card}
            end
        end,
        loc_vars = function(_, card)
            return {vars = {card.ability.extra.dollars}}
        end
    },
    Purple = {
        calculate = function(_, _, context)
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
    v.set = 'Seal'
    v.original_seal = G.P_SEALS[k]
    v.original_key = v.original_seal.original_key
    v.mod = SEALS
    v.original_mod = SEALS
end

local oldgeneratecardui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local oldset, oldkey = _c.set, _c.key
    if card and card.ability and card.ability.soe_detached_seal then
        card_type = "Seal"
        _c.set = 'soe_DetachedSeal'
        _c.key = card.ability.soe_detached_seal
    end
    local g = oldgeneratecardui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if card and card.ability and card.ability.soe_detached_seal then
        localize({type = 'descriptions', key = _c.key, set = _c.set, nodes = g.main, vars = (SEALS.detached_seals[_c.key].loc_vars and SEALS.detached_seals[_c.key]:loc_vars(card).vars) or {}})
        _c.set = oldset
        _c.key = oldkey
    end
    return g
end

local oldguidefcardhpopup = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    G.soe_ui_card = card
    local g = oldguidefcardhpopup(card)
    G.soe_ui_card = nil
    return g
end

local oldinfotipfromrows = info_tip_from_rows
function info_tip_from_rows(desc_nodes, name)
    local g = oldinfotipfromrows(desc_nodes, name)
    if G.soe_ui_card and G.soe_ui_card.ability and G.soe_ui_card.ability.soe_mergedcards and G.soe_ui_card.ability.soe_mergedcards[1] then
        local passed = false
        for _, v in ipairs(G.soe_ui_card.ability.soe_mergedcards) do
            if localize({type = 'name_text', key = v.key, set = v.set}) == name then
                passed = true
            end
        end
        if not passed then return g end
        for _, v in ipairs(G.soe_ui_card.ability.soe_mergedcards) do
            local copy = SEALS.copy_card_but_not(G.soe_ui_card, v.key, v)
            local h_popup = G.UIDEF.card_h_popup(copy)
            local badges = h_popup.nodes[1].nodes[1].nodes[1].nodes[#h_popup.nodes[1].nodes[1].nodes[1].nodes]
            g.nodes[#g.nodes+1] = badges
        end
    end
    return g
end

local oldfuncsselfreroll = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function()
    oldfuncsselfreroll()
    if G.GAME.rerollbuttonseal == 'Gold' then
        ease_dollars(3)
    elseif G.GAME.rerollbuttonseal == 'Red' then
        oldfuncsselfreroll()
    elseif G.GAME.rerollbuttonseal == 'Blue' and G.GAME.last_hand_played then
        local planet
        for _, v in ipairs(G.P_CENTER_POOLS.Planet) do
            if v.config.hand_type == G.GAME.last_hand_played then
                planet = v.key
                break
            end
        end
        if planet then
            SMODS.add_card({key = planet})
        end
    elseif G.GAME.rerollbuttonseal == 'Purple' then
        SMODS.add_card({set = 'Tarot'})
    end
end

SMODS.ObjectType{
    key = 'soe_Synonyms',
    default = 'c_soe_idiot'
}

SMODS.ObjectType{
    key = 'soe_SynonymJokers',
    default = 'j_soe_jokester'
}

SMODS.ObjectType{
    key = 'soe_Infinity',
    cards = {
        j_soe_infinityred = true,
        j_soe_infinityblue = true,
        j_soe_infinitygold = true,
        j_soe_infinitypurple = true,
        j_soe_sealjoker = true,
    },
}

local oldcreatecard = create_card
function create_card(_type, a, b, c, d, e, forced_key, key_append)
    local card = oldcreatecard(_type, a, b, c, d, e, forced_key, key_append)
    local deception_poll
    if G.GAME.used_vouchers.v_soe_deception then
        _, deception_poll = pe({edition = G.GAME.used_vouchers.v_soe_legerdemain, enhancement = G.GAME.used_vouchers.v_soe_phantasm, seal = true}, 'deception')
    end
    if G.GAME.used_vouchers.v_soe_legerdemain and ((_type ~= 'Joker' and not card.playing_card) or deception_poll == 'edition') and not card.edition then
        local edition = poll_edition('legerdemain'..(key_append or '')..G.GAME.round_resets.ante, nil, nil, (deception_poll == 'edition'))
        if edition then
            card:set_edition(edition)
        end
    end
    if G.GAME.used_vouchers.v_soe_phantasm and not card.playing_card and not (card.ability.soe_legalenhancements and next(card.ability.soe_legalenhancements)) then
        local options = get_current_pool('Enhanced')
        for i, v in ipairs(options) do
            if v ~= 'UNAVAILABLE' and G.P_CENTERS[v] and (G.P_CENTERS[v].replace_base_card or G.P_CENTERS[v].mod == SEALS or v == 'm_stone') then
                table.remove(options, i)
            end
        end
        local enhancement = SMODS.poll_enhancement({key = 'phantasm', guaranteed = (deception_poll == 'enhancement'), options = options})
        if enhancement then
            SEALS.set_joker_enhancement(card, G.P_CENTERS[enhancement])
        end
    end
    if G.GAME.used_vouchers.v_soe_phantasm and card.playing_card and deception_poll == 'enhancement' then
        local enhancement = SMODS.poll_enhancement({key = 'phantasm', guaranteed = true})
        if enhancement then
            card:set_ability(G.P_CENTERS[enhancement])
        end
    end
    if G.GAME.used_vouchers.v_soe_deception and (not card.playing_card or deception_poll == 'seal') and not card.seal then
        local seal = SMODS.poll_seal({key = 'deception', guaranteed = (deception_poll == 'seal')})
        if seal then
            card:set_seal(seal)
        end
    end
    return card
end

local oldsmodscreatecard = SMODS.create_card
function SMODS.create_card(t)
    if not t.area and t.set == 'soe_Synonyms' then
        t.area = G.consumeables
    end
    return oldsmodscreatecard(t)
end

local oldeventmanageraddevent = G.E_MANAGER.add_event
function G.E_MANAGER:add_event(event, ...)
    if is(event, Event) then
        if G.soe_redsealretriggering or G.soe_mergedcardusing then
            local oldeventfunc = event.func
            event.func = function()
                local ok, err = pcall(oldeventfunc)
                if not ok then sendErrorMessage(err, 'SEALS') end
                return ok and err or true
            end
        end
        oldeventmanageraddevent(self, event, ...)
    end
end

local oldcardsetability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
	if type(center) ~= 'table' then
		assert(G.P_CENTERS[center], ('Could not find center "%s"'):format(center))
		center = G.P_CENTERS[center]
	end
    if self.playing_card and self.config.center_key ~= 'c_base' and not initial and delay_sprites ~= 'quantum' and not self.soe_from_copy and center.key ~= 'c_base' and SMODS.find_card('j_soe_sealjoker2')[1] then
        self.ability.soe_quantum_enhancements = self.ability.soe_quantum_enhancements or {}
        self.ability.soe_quantum_enhancements[#self.ability.soe_quantum_enhancements+1] = center.key
        return
    end
    if self.base and self.base.soe_old_base then
        self.base = self.base.soe_old_base
    end
    local g = oldcardsetability(self, center, initial, delay_sprites)
    if has_cryptid then
        if G.GAME and G.GAME.modifiers.cry_force_seal then
            self:set_seal(G.GAME.modifiers.cry_force_seal, true, true)
        end
    end
    return g
end

local oldcardsetbase = Card.set_base
function Card:set_base(card, initial, ...)
    local oldbase
    if self.config.center.soe_blueprint then oldbase = self.base end
    if initial or self.soe_from_copy or not SMODS.find_card('j_soe_sealjoker2')[1] then return oldcardsetbase(self, card, initial, ...) end
    local newrank = card and card.value and SMODS.Ranks[card.value]
    local newsuit = card and card.suit and SMODS.Suits[card.suit]
    if newrank then
        if self.playing_card and self.base and self.base.id and self.base.id ~= newrank.id and not tc(self.ability.soe_quantum_ranks, newrank.key) then
            self.ability.soe_quantum_ranks = self.ability.soe_quantum_ranks or {}
            self.ability.soe_quantum_ranks[#self.ability.soe_quantum_ranks+1] = newrank.key
        end
    end
    if newsuit then
        if self.playing_card and self.base and self.base.suit and self.base.suit ~= newsuit.key and not tc(self.ability.soe_quantum_suits, newsuit.key) then
            self.ability.soe_quantum_suits = self.ability.soe_quantum_suits or {}
            self.ability.soe_quantum_suits[#self.ability.soe_quantum_suits+1] = newsuit.key
        end
    end
    if (newsuit or newrank) and (self.base and self.base.value and self.base.suit) then return end
    oldcardsetbase(self, card, initial, ...)
    if oldbase then
        local newbase = self.base
        self.base = oldbase
        self.base.soe_old_base = newbase
    end
end

local oldcardsetedition = Card.set_edition
function Card:set_edition(edition, immediate, silent, ...)
    if edition and self.edition and not self.soe_from_copy and SMODS.find_card('j_soe_sealjoker2')[1] then
        local edition_key = edition.type and 'e_'..edition.type
        if not edition_key then
            if type(edition) == 'table' then
                local _type = next(edition)
                edition_key = 'e_'.._type
            else
                edition_key = edition
            end
        end
        self.ability.soe_quantum_editions = self.ability.soe_quantum_editions or {}
        self.ability.soe_quantum_editions[#self.ability.soe_quantum_editions+1] = edition_key
        if not silent then
            local ed = G.P_CENTERS[edition_key]
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
        SEALS.recalc_quantum_editions(self)
        return
    end
    if G.soe_creatingmergedcard then silent = true end
    oldcardsetedition(self, edition, immediate, silent, ...)
end

local oldcardgetchipbonus = Card.get_chip_bonus
function Card:get_chip_bonus()
    local ranks = SEALS.get_ranks(self)
    table.sort(ranks, function(a, b) return SMODS.Ranks[a].nominal > SMODS.Ranks[b].nominal end)
    self.base.nominal = (SMODS.Ranks[ranks[1]] or {}).nominal or self.base.nominal
    return oldcardgetchipbonus(self)
end

local oldcardissuit = Card.is_suit
function Card:is_suit(suit, ...)
    if SEALS.counts_as_everything(self) then return true end
    local g = oldcardissuit(self, suit, ...)
    if not g and self.ability.soe_quantum_suits and self.ability.soe_quantum_suits[1] then
        for _, v in ipairs(self.ability.soe_quantum_suits) do
            if v == suit then
                return true
            end
        end
    end
    if not g and self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] and (not G.GAME.SEALS_Scoring_Active or G.soe_evaluating_poker_hand) then
        for _, v in ipairs(self.ability.soe_mergedcards) do
            local copy = SEALS.copy_card_but_not(self, v.key, v)
            if copy:is_suit(suit, ...) then return true end
            if copy.ability.soe_quantum_suits and copy.ability.soe_quantum_suits[1] then
                for _, vv in ipairs(copy.ability.soe_quantum_suits) do
                    if vv == suit then return true end
                end
            end
        end
    end
    return g
end

local oldisface = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
    local extra_ranks = self.ability.soe_quantum_ranks
    if extra_ranks and extra_ranks[1] then
        for _, v in ipairs(extra_ranks) do
            if SMODS.Ranks[v].face then return true end
        end
    end
    return oldisface(self, from_boss)
end

if Card.is_numbered then
    local oldisnumbered = Card.is_numbered
    function Card:is_numbered(from_boss)
        if self.debuff and not from_boss then return end
        local extra_ranks = self.ability.soe_quantum_ranks
        if extra_ranks and extra_ranks[1] then
            for _, v in ipairs(extra_ranks) do
                if not SMODS.Ranks[v].face then return true end
            end
        end
        if SEALS.face_check(self, true, from_boss) then return true end
        return oldisnumbered(self, from_boss)
    end
end

local oldcardisrarity = Card.is_rarity
function Card:is_rarity(...)
    if SEALS.counts_as_everything(self) then
        return true
    end
    return oldcardisrarity(self, ...)
end

function SEALS.perform_checks(table1, op, table2, mod)
    for _, v in ipairs(table1) do
        for _, vv in ipairs(table2) do
            if op == '==' and v == vv then return true end
            if op == '~=' and v ~= vv then return true end
            if op == '>' and v > vv then return true end
            if op == '>=' and v >= vv then return true end
            if op == '<' and v < vv then return true end
            if op == '<=' and v <= vv then return true end
            if op == 'mod' and v % vv == mod then return true end
            if type(op) == 'function' and op(v, vv) then return true end
        end
    end
    return false
end

local oldidsop = ids_op
function ids_op(card, op, b, c)
    if oldidsop ~= nil then
        local other_results = oldidsop(card, op, b, c)
        if other_results == true then return true end
    end
    return SEALS.perform_checks(SEALS.convert_ranks_to_ids(SEALS.get_ranks(card)), op, {b}, c)
end

function SEALS.is_ids(card, ids)
    for _, v in ipairs(ids) do
        if ids_op(card, '==', v) then return true end
    end
end

function SEALS.is_suits(card, suits)
    for _, v in ipairs(suits) do
        if card:is_suit(v) then return true end
    end
end

function SEALS.face_check(card, nonface, from_boss)
    G.soe_from_face_check = true
    if SMODS.find_card('j_soe_apophenia')[1] and card:is_face() then
        G.soe_from_face_check = nil
        return true
    end
    local result
    if nonface then
        result = not card:is_face(from_boss)
    else
        result = card:is_face(from_boss)
    end
    G.soe_from_face_check = nil
    return result
end

--[[
function SEALS.NOT(func, ...)
    if func == Card.is_face then return true end
    return (func(...) and false) or true
end
]]

SMODS.DynaTextEffect {
    key = 'circle',
    func = function (_, _, letter)
        letter.offset.x = math.cos(G.TIMERS.REAL*2)*20
        letter.offset.y = math.sin(G.TIMERS.REAL*2)*20
    end
}

local oldtableinsert = table.insert
function table.insert(t, i, e)
    if e == nil then t[#t+1] = i else
		oldtableinsert(t, i, e)
	end
end

local oldevaluatepokerhand = evaluate_poker_hand
function evaluate_poker_hand(hand)
    G.soe_evaluating_poker_hand = true
    local g = oldevaluatepokerhand(hand)
    G.soe_evaluating_poker_hand = nil
    return g
end

function SEALS.get_ranks(card, extra_only)
    if SMODS.has_no_rank(card) then return {} end
    if not G.deck then
        if extra_only then
            return {}
        else
            local id = card:get_id()
            for _, v in ipairs(SMODS.Rank.obj_buffer) do
                if SMODS.Ranks[v].id == id then return {v} end
            end
        end
    end
    local ranks = {}
    if SEALS.counts_as_everything(card) then
        for _, v in ipairs(SMODS.Rank.obj_buffer) do
            ranks[#ranks+1] = v
        end
        return ranks
    end
    if not extra_only then
        local id = card:get_id()
        for _, v in ipairs(SMODS.Rank.obj_buffer) do
            if SMODS.Ranks[v].id == id then ranks[v] = true; break end
        end
    end
    if has_cryptid and find_joker('cry-Maximized')[1] and SEALS.face_check(card, true) then
        ranks['10'] = true
    end
    if card.ability.soe_quantum_ranks and card.ability.soe_quantum_ranks[1] then
        for _, v in ipairs(card.ability.soe_quantum_ranks) do
            ranks[v] = true
        end
    end
    if card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] and (not G.GAME.SEALS_Scoring_Active or G.soe_evaluating_poker_hand or G.soe_calculating_joker_seals or G.soe_calculating_jokers_as_playing_cards) then
        for _, v in ipairs(card.ability.soe_mergedcards) do
            local copy = SEALS.copy_card_but_not(card, v)
            local id = copy:get_id()
            for _, v in ipairs(SMODS.Rank.obj_buffer) do
                if SMODS.Ranks[v].id == id then ranks[v] = true; break end
            end
            if copy.ability.soe_quantum_ranks and copy.ability.soe_quantum_ranks[1] then
                for _, vv in ipairs(copy.ability.soe_quantum_ranks) do
                    ranks[vv] = true
                end
            end
        end
    end
    local ranks_array = {}
    for _, v in ipairs(SMODS.Rank.obj_buffer) do
        if ranks[v] then
            ranks_array[#ranks_array+1] = v
        end
    end
    return ranks_array
end

function SEALS.convert_ranks_to_ids(ranks)
    local ids = {}
    for _, v in ipairs(ranks) do
        ids[#ids+1] = SMODS.Ranks[v].id
    end
    return ids
end

local oldgetxsame = get_X_same
function get_X_same(num, hand, or_more)
    local passed = false
    for _, v in ipairs(hand) do
        if SEALS.get_ranks(v, true)[1] then
            passed = true
            break
        end
    end
    if not passed then return oldgetxsame(num, hand, or_more) end
    local rank_tally = {}
    local rank_cards = {}
    for _, card in ipairs(hand) do
        for _, rank in ipairs(SEALS.get_ranks(card)) do
            rank_tally[rank] = (rank_tally[rank] or 0) + 1
            local rank_card = rank_cards[rank]
            if rank_card then rank_card[#rank_card+1] = card else rank_cards[rank] = {card} end
        end
    end
    local ret = {}
    for _, v in ipairs(SMODS.Rank.obj_buffer) do
        local tally = rank_tally[v]
        if tally then
            if or_more and (tally >= num) or (tally == num) then
                ret[#ret+1] = rank_cards[v]
            end
        end
    end
    return ret
end

local oldgetstraight = get_straight
function get_straight(hand, min_length, skip, wrap)
    local passed = false
    for _, v in ipairs(hand) do
        if SEALS.get_ranks(v, true)[1] then
            passed = true
            break
        end
    end
    if not passed then return oldgetstraight(hand, min_length, skip, wrap) end
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    for _, v in ipairs(SMODS.Rank.obj_buffer) do ranks[v] = {} end
    for _, card in ipairs(hand) do
        local card_ranks = SEALS.get_ranks(card)
        for _, rank in ipairs(card_ranks) do
            ranks[rank][#ranks[rank]+1] = card
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
                for _, l in ipairs(next_ranks(tuple[i-1], i == 2)) do
                    if next(ranks[l]) then
                        local new_tuple = {}
                        for _, v in ipairs(tuple) do new_tuple[#new_tuple + 1] = v end
                        new_tuple[#new_tuple+1] = l
                        new_tuples[#new_tuples+1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i > min_length and not any_tuple then
                local straight = {}
                for _, v in ipairs(tuple) do
                    for _, card in ipairs(ranks[v]) do
                        straight[#straight+1] = card
                    end
                end
                ret[#ret+1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a, b) return #a > #b end)
    return ret
end

if SEALS.find_mod('paperback') then
    local oldpbutilremovepaperclip = PB_UTIL.remove_paperclip
    function PB_UTIL.remove_paperclip(card)
        if SMODS.find_card('j_soe_sealjoker2')[1] then return end
        return oldpbutilremovepaperclip(card)
    end
end

if SEALS.find_mod('LuckyRabbit') then
    local oldlrutilsetmarking = LR_UTIL.set_marking
    function LR_UTIL.set_marking(card, mark)
        if not SMODS.find_card('j_soe_sealjoker2')[1] then return oldlrutilsetmarking(card, mark) end
        local key = 'fmod_'..mark..'_mark'
        if card and LR_UTIL.is_marking(key) then
            SMODS.Stickers[key]:apply(card, true)
        end
    end
end

if AKYRS then
    local oldcardsetletters = Card.set_letters
    function Card:set_letters(letter)
        if SMODS.find_card('j_soe_sealjoker2')[1] then letter = (self.ability.aikoyori_letters_stickers or '')..letter end
        return oldcardsetletters(self, letter)
    end

    local oldaikoyorilocvars = SMODS.Centers.j_akyrs_aikoyori.loc_vars
    SMODS.Joker:take_ownership('j_akyrs_aikoyori',
        {
            loc_vars = function(self, info_queue, card)
                local g = oldaikoyorilocvars(self, info_queue, card)
                info_queue[#info_queue+1] = {set = 'Other', key = 'dd_akyrs_seals_on_everything_ability'}
                return g
            end
        },
        true
    )
end

G.FUNCS.soe_purchaseitems = function()
    G.GAME.soe_purchasingitems = true
    G.FUNCS.overlay_menu({definition = SEALS.create_UIBox_your_purchases()})
end

G.FUNCS.soe_can_purchaseitems = function(e)
    if to_big(G.GAME.dollars) > to_big(G.GAME.bankrupt_at) then
        e.config.colour = G.C.DARK_EDITION
        e.config.button = 'soe_purchaseitems'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.soe_exit_purchaseitems = function()
    G.GAME.soe_purchasingitems = nil
    G.FUNCS.exit_overlay_menu()
end

G.FUNCS.soe_fusesealjokers = function()
    ease_dollars(-G.soe_fusion_card.ability.extra.fusion_cost)
    SMODS.destroy_cards({G.soe_fusion_card, SMODS.find_card('j_soe_infinityred')[1], SMODS.find_card('j_soe_infinityblue')[1], SMODS.find_card('j_soe_infinitygold')[1], SMODS.find_card('j_soe_infinitypurple')[1]}, true, true)
    SMODS.add_card({key = 'j_soe_infinityomega'})
end

G.FUNCS.soe_can_fusesealjokers = function(e)
    G.soe_fusion_card = e.config.ref_table
    if to_big(G.soe_fusion_card.ability.extra.fusion_cost) <= to_big(G.GAME.dollars-G.GAME.bankrupt_at) and SMODS.find_card('j_soe_infinityred')[1] and SMODS.find_card('j_soe_infinityblue')[1] and SMODS.find_card('j_soe_infinitygold')[1] and SMODS.find_card('j_soe_infinitypurple')[1] then
        e.config.colour = G.C.DARK_EDITION
        e.config.button = 'soe_fusesealjokers'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.soe_exit_purchase_key = function()
    if G.CHOOSE_PURCHASE then G.CHOOSE_PURCHASE:remove() end
end

local oldcardinit = Card.init
function Card:init(...)
    oldcardinit(self, ...)
    G.soe_indexable_cards = G.soe_indexable_cards or {}
    G.soe_indexable_cards[self.unique_val] = self
    if G.GAME.soe_purchasingitems and self.config.center.set == 'Partner' and not G.soe_creating_card_during_purchase then
        self.cost = SEALS.get_cost(self.config.center_key)
        create_shop_card_ui(self)
    end
end

local oldtaginit = Tag.init
function Tag:init(...)
    oldtaginit(self, ...)
    if not G.soe_creating_merged_tag and not G.SETTINGS.paused and SEALS.check_deck('merged', true) then
        self.ability.soe_mergedtags = self.ability.soe_mergedtags or {}
        local oldselfkey = G.GAME.banned_keys[self.key]
        G.GAME.banned_keys[self.key] = true
        self.ability.soe_mergedtags[#self.ability.soe_mergedtags+1] = get_next_tag_key('merged')
        G.GAME.banned_keys[self.key] = oldselfkey
    end
end

local oldtagapplytorun = Tag.apply_to_run
function Tag:apply_to_run(_context)
    local g = oldtagapplytorun(self, _context)
    if g and ({store_joker_create=true,new_blind_choice=true,store_joker_modify=true})[_context.type] then return g end
    if self.ability.soe_mergedtags and self.ability.soe_mergedtags[1] then
        self.soe_savedtags = self.soe_savedtags or {}
        for _, v in ipairs(self.ability.soe_mergedtags) do
            local other_tag = self.soe_savedtags[v]
            if not other_tag then
                G.soe_creating_merged_tag = true
                other_tag = Tag(v)
                G.soe_creating_merged_tag = nil
            end
            self.soe_savedtags[v] = other_tag
            other_tag.soe_truetag = self
            other_tag.HUD_tag = self.HUD_tag
            other_tag:apply_to_run(_context)
        end
    end
    return g
end

local oldtagremove = Tag.remove
function Tag:remove()
    if self.soe_truetag then
        self.HUD_tag.states.visible = true
        local soe_mergedtags = self.soe_truetag.ability.soe_mergedtags
        for i, v in ipairs(soe_mergedtags) do
            if self.key == v then
                table.remove(soe_mergedtags, i)
                break
            end
        end
        return
    end
    oldtagremove(self)
    if self.ability.soe_mergedtags and self.ability.soe_mergedtags[1] then
        for _, v in ipairs(self.ability.soe_mergedtags) do
            G.soe_creating_merged_tag = true
            local tag = Tag(v)
            add_tag(tag)
            G.soe_creating_merged_tag = nil
        end
    end
end

local function reset_merged_blinds(boss_only)
    G.GAME.round_resets.soe_mergedblinds = {}
    for k, v in pairs(G.GAME.round_resets.blind_choices) do
        local soe_mergedblinds = {}
        G.GAME.round_resets.soe_mergedblinds[k] = soe_mergedblinds
        if (not boss_only or k == 'Boss') and G.P_BLINDS[v].boss then
            local oldbleye, oldblmouth
            local oldselfkey = G.GAME.banned_keys[v]
            G.GAME.banned_keys[v] = true
            if v == 'bl_mouth' then
                oldbleye = G.GAME.banned_keys.bl_eye
                G.GAME.banned_keys.bl_eye = true
            elseif v == 'bl_eye' then
                oldblmouth = G.GAME.banned_keys.bl_mouth
                G.GAME.banned_keys.bl_mouth = true
            end
            soe_mergedblinds[#soe_mergedblinds+1] = get_new_boss()
            if oldbleye then
                G.GAME.banned_keys.bl_eye = oldbleye
            end
            if oldblmouth then
                G.GAME.banned_keys.bl_mouth = oldblmouth
            end
            G.GAME.banned_keys[v] = oldselfkey
        end
    end
end

local oldresetblinds = reset_blinds
function reset_blinds()
    oldresetblinds()
    if G.GAME.round_resets.blind_states.Boss == 'Defeated' and SEALS.check_deck('merged', true) then
        reset_merged_blinds()
    end
end

local oldgfuncsrerollboss = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(...)
    oldgfuncsrerollboss(...)
    if SEALS.check_deck('merged', true) then
        SEALS.event(function()
            reset_merged_blinds(true)
            return true
        end)
    end
end

local oldblindcalculate = Blind.calculate
function Blind:calculate(...)
    local g, post = oldblindcalculate(self, ...)
    if G.GAME.blind_on_deck and G.GAME.round_resets.soe_mergedblinds then
        local soe_mergedblinds = G.GAME.round_resets.soe_mergedblinds[G.GAME.blind_on_deck]
        if soe_mergedblinds[1] then
            local effects = {g}
            for _, v in ipairs(soe_mergedblinds) do
                local center = G.P_BLINDS[v]
                local old_effect, old_center, old_name, old_debuff =    copy_table(self.effect), self.config.blind, self.name, self.debuff
                self.effect, self.config.blind, self.name, self.debuff = center.config and type(center.config) == 'table' and copy_table(center.config) or {}, center, center.name, center.debuff
                effects[#effects+1], other_post = oldblindcalculate(self, ...)
                post = post or other_post
                self.effect, self.config.blind, self.name, self.debuff = old_effect, old_center, old_name, old_debuff
            end
            g = SMODS.merge_effects(effects)
        end
    end
    return g, post
end

local olduiboxinit = UIBox.init
function UIBox:init(args)
    local config = args.config
    local parent = config.parent
    if parent and parent.soe_realcard then
        config.parent = parent.soe_realcard
    end
    olduiboxinit(self, args)
end

--[[
local oldcardload = Card.load
function Card:load(...)
	oldcardload(self, ...)
    G.soe_indexable_cards[self.unique_val] = self
end
]]

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
    oldcardsetcost(self)
    if self.config.center.set == 'Partner' then
        self.cost = SEALS.get_cost(self.config.center_key)
    end
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        for _, v in ipairs(self.ability.soe_mergedcards) do
            local center = G.P_CENTERS[v.key]
            if center then
                self.cost = self.cost + (center.cost or 0)
                self.sell_cost = self.sell_cost + fl((center.cost or 0)/2)
            end
        end
        if self.area and self.ability.couponed and (self.area == G.shop_jokers or self.area == G.shop_booster) then self.cost = 0 elseif SEALS.check_deck('merged') then
            self.cost = math.max(1, fl(self.cost-self.cost/5))
            self.sell_cost = math.max(1, fl(self.cost/2))
        end
        self.sell_cost_label = (self.facing == 'back' and '?') or self.sell_cost
    end
end

local oldcontrollerkeypressupdate = Controller.key_press_update
function Controller:key_press_update(key, ...)
    if key == 'escape' and G.OVERLAY_MENU and G.GAME and G.GAME.soe_purchasingitems then
        G.GAME.soe_purchasingitems = nil
    end
    return oldcontrollerkeypressupdate(self, key, ...)
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
        e.UIBox.definition.nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[1].config.text = 'Purchase'
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

function G.FUNCS.soe_purchase_key()
    local enteredpurchase = SEALS.convert_to_key(G.ENTERED_PURCHASE)
    if enteredpurchase and G.P_CENTERS[enteredpurchase] then
        SEALS.purchase_key(enteredpurchase)
    end
end

function G.FUNCS.soe_purchase_all()
    for _, v in ipairs(G.P_CENTER_POOLS.Back) do
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
    local center = G.P_CENTERS[key]
    if center.set == "Back" or center.set == "Sleeve" then
        G.GAME.soe_creating_card_during_purchase = true
        for k, v in pairs(center.config) do
            if k == "jokers" then for _, vv in ipairs(v) do SMODS.add_card({key = vv}) end end
            if k == "voucher" then G.GAME.used_vouchers[v] = true; Card.apply_to_run(nil, G.P_CENTERS[v]) end
            if k == "hands" then G.GAME.round_resets.hands = G.GAME.round_resets.hands + v; ease_hands_played(v, true) end
            if k == "consumables" then for _, vv in ipairs(v) do SMODS.add_card({key = vv}) end end
            if k == "dollars" then ease_dollars(v, true) end
            if k == "remove_faces" then for _, vv in ipairs(G.playing_cards) do if SMODS.Ranks[vv.base.value].face then vv:remove() end end end
            if k == "spectral_rate" then G.GAME.spectral_rate = v end
            if k == "discards" then G.GAME.round_resets.discards = G.GAME.round_resets.discards + v; ease_discard(v, true) end
            if k == "reroll_discount" then G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - v; G.GAME.current_round.reroll_cost = G.GAME.current_round.reroll_cost - v end
            if k == "vouchers" then for _, vv in ipairs(v) do G.GAME.used_vouchers[vv] = true; Card.apply_to_run(nil, G.P_CENTERS[vv]) end end
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
        G.GAME.soe_extra_decks[#G.GAME.soe_extra_decks+1] = key
    elseif center.set == "Partner" then
        G.soe_creating_card_during_purchase = true
        if G.GAME.selected_partner_card then
            G.GAME.soe_extra_partners = G.GAME.soe_extra_partners or {}
            G.GAME.soe_extra_partners[#G.GAME.soe_extra_partners+1] = key
            G.GAME.soe_extra_partner_cards = G.GAME.soe_extra_partner_cards or {}
            local soe_extra_partner_cards = G.GAME.soe_extra_partner_cards
            soe_extra_partner_cards[#soe_extra_partner_cards+1] = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, nil, center)
            soe_extra_partner_cards[#soe_extra_partner_cards]:juice_up(0.3, 0.5)
            local ret = soe_extra_partner_cards[#soe_extra_partner_cards]:calculate_partner_begin()
            if ret then SMODS.trigger_effects({{individual = ret}}, soe_extra_partner_cards[#soe_extra_partner_cards]) end
        else
            G.GAME.selected_partner = key
            G.GAME.selected_partner_card = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, nil, center)
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
            'You may purchase',
            'any Deck'..(SEALS.find_mod('CardSleeves') and ' or Sleeve' or '')..(SEALS.find_mod('partner') and ' or Partner' or ''),
        },
        contents = {
            {
                n = G.UIT.C,
                config = {align = 'cm', padding = 0.15},
                nodes = {
                    UIBox_button({button = 'soe_enter_key_to_purchase', label = {'Enter Key/Name'}, minw = 5}),
                }
            },
            SEALS.find_mod('partner') and {
                n = G.UIT.C,
                config = {align = 'cm', padding = 0.15},
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
    local g = oldguidefuseandsellbuttons(card)
    if card.area and card.area.config.type == 'joker' then
        if card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] and not card.ability.consumeable then
            local nodes = g.nodes[1].nodes or {}
            g.nodes[1].nodes = nodes
            for _, v in ipairs(card.ability.soe_mergedcards) do
                if G.P_CENTERS[v.key] and G.P_CENTERS[v.key].consumeable then
                    nodes[#nodes+1] = {n=G.UIT.R, config={align = 'cl'}, nodes={
                        {
                            n = G.UIT.C,
                            config = {align = 'cr'},
                            nodes = {

                                {
                                    n = G.UIT.C,
                                    config = { ref_table = card, align = 'cr', maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'soe_use_joker', func = 'soe_can_use_joker' },
                                    nodes = {
                                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                                        { n = G.UIT.T, config = { text = localize('b_use'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
                                    }
                                }
                            }
                        }
                    }}
                    break
                end
            end
        end
    end
    return g
end

function G.UIDEF.soe_purchase_and_fuse_buttons(card)
    local purchase = {n=G.UIT.R, config={align = 'cl'}, nodes={{
        n = G.UIT.C,
        config = { align = "cl" },
        nodes = {

            {
                n = G.UIT.C,
                config = { ref_table = card, align = "cl", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, button = 'soe_purchaseitems', func = 'soe_can_purchaseitems' },
                nodes = {
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
                    },
                    { n = G.UIT.B, config = { w = 0.1, h = 0.6 } }
                }
            },
        },
    }}}
    local fuse = {n=G.UIT.R, config={align = 'cl'}, nodes={
        {n=G.UIT.C, config={align = "cl"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'soe_fusesealjokers', func = 'soe_can_fusesealjokers'}, nodes={
                {n=G.UIT.C, config={align = "tm"}, nodes={
                    {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                        {n=G.UIT.T, config={text = localize('b_fuse'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                    }},
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                        {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                        {n=G.UIT.T, config={ref_table = card.ability.extra, ref_value = 'fusion_cost',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                    }}
                }},
                {n=G.UIT.B, config = {w=0.1,h=0.6}}
            }}
        }}
    }}
    return {
      n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            purchase
          }},
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            fuse
          }},
        }},
    }}
end

SMODS.draw_ignore_keys.soe_seal2buttons = true
SMODS.DrawStep{
    key = 'seal2buttons',
    order = -30,
    func = function(self)
        if self.children.soe_seal2buttons then
            self.children.soe_seal2buttons:draw()
        end
    end
}

function G.FUNCS.soe_can_use_joker(e)
    if e.config.ref_table:can_use_consumeable() then
        e.config.colour = G.C.RED
        e.config.button = 'soe_use_joker'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

function G.FUNCS.soe_use_joker(e)
    local card = e.config.ref_table
    local area = card.area
    local prev_state = G.STATE
    G.TAROT_INTERRUPT = prev_state
    if card.ability.set == 'Booster' then G.GAME.PACK_INTERRUPT = prev_state end
    G.STATE = (G.STATE == G.STATES.TAROT_PACK and G.STATES.TAROT_PACK) or (G.STATE == G.STATES.PLANET_PACK and G.STATES.PLANET_PACK) or (G.STATE == G.STATES.SPECTRAL_PACK and G.STATES.SPECTRAL_PACK) or (G.STATE == G.STATES.STANDARD_PACK and G.STATES.STANDARD_PACK) or (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and G.STATES.SMODS_BOOSTER_OPENED) or (G.STATE == G.STATES.BUFFOON_PACK and G.STATES.BUFFOON_PACK) or G.STATES.PLAY_TAROT
    G.CONTROLLER.locks.use = true
    local select_to = area == G.pack_cards and G.pack_cards and booster_obj and SMODS.card_select_area(card, booster_obj) and card:selectable_from_pack(booster_obj)
    if G.booster_pack and not G.booster_pack.alignment.offset.py and ((not select_to and card.ability.consumeable) or not (G.GAME.pack_choices or 0) > 1) then
        G.booster_pack.alignment.offset.py = G.booster_pack.alignment.offset.y
        G.booster_pack.alignment.offset.y = G.ROOM.T.y + 29
    end
    if G.shop and not G.shop.alignment.offset.py then
        G.shop.alignment.offset.py = G.shop.alignment.offset.y
        G.shop.alignment.offset.y = G.ROOM.T.y + 29
    end
    if G.blind_select and not G.blind_select.alignment.offset.py then
        G.blind_select.alignment.offset.py = G.blind_select.alignment.offset.y
        G.blind_select.alignment.offset.y = G.ROOM.T.y + 39
    end
    if G.round_eval and not G.round_eval.alignment.offset.py then
        G.round_eval.alignment.offset.py = G.round_eval.alignment.offset.y
        G.round_eval.alignment.offset.y = G.ROOM.T.y + 29
    end
    if not card.from_area then card.from_area = card.area end
    if card.area then card.area:remove_card(card) end
    G.GAME.soe_usingmergedconsumables = true
    if not select_to then
        if (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) then
            card.T.x = G.hand.T.x + G.hand.T.w/2 - card.T.w/2
            card.T.y = G.hand.T.y + G.hand.T.h/2 - card.T.h/2 - 0.5
            discover_card(card.config.center)
        else
            draw_card(G.hand, G.play, 1, 'up', true, card)
        end
    end
    G.soe_mergedcardusing = true
    if card.soe_using_card then
        if card.ability.consumeable then
            card:use_consumeable(area)
        end
        if card.ability.set == 'Voucher' then
            card:redeem()
        end
        --[[
        if card.ability.set == 'Booster' then
            card:open()
        end
        ]]
    end
    if card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] then
        for _, v in ipairs(card.ability.soe_mergedcards) do
            local center = G.P_CENTERS[v.key]
            if center then
                local copy = SEALS.copy_card_but_not(card, v)
                if center.consumeable then
                    local ok, err = pcall(copy.use_consumeable, copy, area)
                    if not ok then sendErrorMessage(err, 'SEALS') end
                end
                if v.set == 'Voucher' then
                    copy.cost = 0
                    local ok, err = pcall(copy.redeem, copy)
                    if not ok then sendErrorMessage(err, 'SEALS') end
                end
                if v.set == 'Booster' then
                    local ok, err = pcall(copy.open, copy)
                    if not ok then sendErrorMessage(err, 'SEALS') end
                end
            end
        end
    end
    G.soe_mergedcardusing = nil
    SEALS.event(function()
        G.GAME.soe_usingmergedconsumables = nil
        return true
    end)
    SEALS.event(function()
        card:start_dissolve()
        G.hand:unhighlight_all()
        SEALS.event(function()
            G.CONTROLLER.locks.use = false
            G.STATE = prev_state
            G.TAROT_INTERRUPT = nil
            if (prev_state == G.STATES.TAROT_PACK or prev_state == G.STATES.PLANET_PACK or prev_state == G.STATES.SPECTRAL_PACK or prev_state == G.STATES.STANDARD_PACK or prev_state == G.STATES.SMODS_BOOSTER_OPENED or prev_state == G.STATES.BUFFOON_PACK) and G.booster_pack then
                if G.booster_pack.alignment.offset.py then
                    G.booster_pack.alignment.offset.y = G.booster_pack.alignment.offset.py
                    G.booster_pack.alignment.offset.py = nil
                end
                if (G.GAME.pack_choices or 0) > 1 then G.GAME.pack_choices = G.GAME.pack_choices - 1 elseif area == G.pack_cards then
                    G.CONTROLLER.interrupt.focus = true
                    if prev_state == G.STATES.SMODS_BOOSTER_OPENED and booster_obj.name:find('Arcana') then inc_career_stat('c_tarot_reading_used', 1) end
                    if prev_state == G.STATES.SMODS_BOOSTER_OPENED and booster_obj.name:find('Celestial') then inc_career_stat('c_planetarium_used', 1) end
                    G.FUNCS.end_consumeable()
                end
            else
                if G.shop then
                    G.shop.alignment.offset.y = G.shop.alignment.offset.py
                    G.shop.alignment.offset.py = nil
                end
                if G.blind_select then
                    G.blind_select.alignment.offset.y = G.blind_select.alignment.offset.py
                    G.blind_select.alignment.offset.py = nil
                end
                if G.round_eval then
                    G.round_eval.alignment.offset.y = G.round_eval.alignment.offset.py
                    G.round_eval.alignment.offset.py = nil
                end
            end
            return true
        end, 'after', 0.1)
        return true
    end, 'after', 0.2)
end

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
    requires = {'v_soe_phantasm'},
    unlocked = true,
    discovered = true,
}

local oldcalculatererollcost = calculate_reroll_cost
function calculate_reroll_cost(...)
    oldcalculatererollcost(...)
    if G.GAME.soe_reroll_discount_percent > 0 then
        G.GAME.current_round.reroll_cost = math.max(0, fl((G.GAME.current_round.reroll_cost + 0.5)*(100-G.GAME.soe_reroll_discount_percent)/100))
    end
end

SMODS.Gradient{
    key = 'synonym_gradient',
    cycle = 5,
    colours = {
        HEX('2D5E5A'),
        HEX('A2334C'),
        HEX('882D33'),
    }
}

function SEALS.fix_context(t)
    local new_t = {}
    for k, v in pairs(t) do
        if type(v) ~= 'table' and type(v) ~= 'function' then
            new_t[k] = v
        elseif is(v, Card) then
            new_t[k] = v.unique_val
        --else
        --    new_t[k] = fix_context(v)
        end
    end
    return new_t
end

function SEALS.cache_context(card, center)
    local k = center.key
    if not G.soe_quantum_context_cache[k] then
        G.soe_quantum_context_cache[k] = {center.set == 'Enhanced' and 'main_scoring' or nil}
        if center.calculate then
            local copy = SEALS.copy_card_but_not(card, k, nil, true)
            --local func = function(t) return sc(t) end
            --local fake_card = setmetatable({}, {__newindex = function() end, __call = func, __index = func, __add = func, __sub = func, __mul = func, __div = func, _mod = func, __pow = func, __eq = func, __lt = func, __le = func})
            local anything
            local fake_context = setmetatable({}, {__index = function(_, kk)
                G.soe_quantum_context_cache[k][#G.soe_quantum_context_cache[k]+1] = kk
                anything = true
            end})
            center:calculate(copy, fake_context)
            if not anything then
                G.soe_quantum_context_cache[k] = true
            end
        end
    end
end

local files = {
    {'consumeables',
        'vice.lua',
        'orbital.lua',
        'phantom.lua'
    },
    'jokers.lua'
}

for _, file in ipairs(files) do
    if type(file) == 'table' then
        local folder = file[1]
        for i=2, #file do
            local f, err = SMODS.load_file('synonyms/'..folder..'/'..file[i])
            if err then
                error(err)
            end
            f()
        end
    else
        local f, err = SMODS.load_file('synonyms/'..file)
        if err then
            error(err)
        end
        f()
    end
end

for i, v in ipairs({'normal', 'jumbo', 'mega'}) do
    SMODS.Booster {
        key = 'synonym_'..v,
        weight = i == 3 and 0.07 or 0.3,
        kind = 'soe_Synonym',
        cost = 2*(i+1),
        atlas = 'Boosters',
        pos = {x = i-1, y = i>1 and 1 or 0},
        unlocked = true,
        discovered = true,
        config = {extra = i>1 and 5 or 3, choose = i==3 and 2 or 1},
        group_key = 'k_synonym_pack',
        draw_hand = true,
        loc_vars = function(self, _, card)
            local cfg = (card and card.ability) or self.config
            return {vars = {cfg.choose, cfg.extra}}
        end,
        ease_background_colour = function()
            ease_colour(G.C.DYN_UI.MAIN, SMODS.Gradients.soe_synonym_gradient)
            ease_background_colour({new_colour = SMODS.Gradients.soe_synonym_gradient, special_colour = darken(G.C.BLACK, 0.2), contrast = 1.5})
        end,
        update_pack = function(self, ...)
            SMODS.Booster.update_pack(self, ...)
            if G.STATE_COMPLETE then
                self:ease_background_colour()
                if G.booster_pack_sparkles then G.booster_pack_sparkles.colours = {lighten(SMODS.Gradients.soe_synonym_gradient, 0.1), SMODS.Gradients.soe_synonym_gradient, darken(SMODS.Gradients.soe_synonym_gradient, 0.1)} end
            end
        end,
        particles = function()
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
        create_card = function()
            local _card = {area = G.pack_cards, skip_materialize = true, soulable = true, key_append = 'soe_synonympack'}
            if G.GAME.soe_joker_hands_available then
                _card.set = SEALS.weighted_random({
                    soe_Synonyms = #G.P_CENTER_POOLS.soe_Synonyms,
                    soe_SynonymJokers = #G.P_CENTER_POOLS.soe_SynonymJokers,
                }, 'synonym_pack')
                return _card
            end
            _card.set = SEALS.weighted_random({
                soe_Vice = #G.P_CENTER_POOLS.soe_Vice,
                soe_Phantom = #G.P_CENTER_POOLS.soe_Phantom,
                soe_SynonymJokers = #G.P_CENTER_POOLS.soe_SynonymJokers,
            }, 'synonym_pack')
            return _card
        end,
    }
end

local oldsmodshasnorank = SMODS.has_no_rank
function SMODS.has_no_rank(card)
    if card.seal ~= 'soe_upgradedsoe_rainbowsealseal' then
        return not card.base.id or oldsmodshasnorank(card)
    end
end

local oldsmodshasnosuit = SMODS.has_no_suit
function SMODS.has_no_suit(card)
    if card.seal ~= 'soe_upgradedsoe_rainbowsealseal' then
        return not card.base.suit or oldsmodshasnosuit(card)
    end
end

local oldsmodsneverscores = SMODS.never_scores
function SMODS.never_scores(card)
    if card.seal ~= 'soe_upgradedsoe_rainbowsealseal' then
        return oldsmodsneverscores(card)
    end
end

local oldsmodsalwaysscores = SMODS.always_scores
function SMODS.always_scores(card)
    return card.config.center.set == 'Joker' or oldsmodsalwaysscores(card)
end

local oldcardgetnominal = Card.get_nominal
function Card:get_nominal(...)
    if rawget(self.base, 'nominal') then
        return oldcardgetnominal(self, ...)
    end
    return -10000
end

local oldgfuncscanplay = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
    if SEALS.check_deck('inverse') then
        if not G.jokers.highlighted[1] or G.GAME.blind.block_play or #G.jokers.highlighted > math.max(G.GAME.starting_params.play_limit, 1) then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.BLUE
            e.config.button = 'soe_play_jokers_from_highlighted'
        end
    else
        return oldgfuncscanplay(e)
    end
end

local oldgfuncscandiscard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    if SEALS.check_deck('inverse') then
        if G.GAME.current_round.discards_left <= 0 or not G.jokers.highlighted[1] or #G.jokers.highlighted > math.max(G.GAME.starting_params.discard_limit, 0) then 
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.RED
            e.config.button = 'soe_discard_jokers_from_highlighted'
        end
    else
        return oldgfuncscandiscard(e)
    end
end

SEALS.order_of_rarities = {'akyrs_supercommon', 'Common', 'soe_basic', 'Uncommon', 'soe_unusual', 'Rare', 'soe_unique', 'cry_epic', 'Legendary', 'cry_exotic', 'entr_entropic', 'soe_infinity'}

function SEALS:custom_card_areas()
    if SEALS.check_deck('inverse') then
        self.soe_joker_deck = CardArea(G.TILE_W - G.deck.T.w - 0.5, 3, G.CARD_W*1.1, 0.95*G.CARD_H, {card_limit = 20, type = 'deck'})
        self.soe_joker_discard = CardArea(G.jokers.T.x + G.jokers.T.w/2 + 0.3 + 15, 5.2, G.CARD_W, G.CARD_H, {card_limit = 1e308, type = 'discard'})
        self.soe_joker_deck.draw_uibox = true
        --local rarity = SEALS.check_deck('synonym') and 'soe_basic' or 'Common'
        for _=1, 20 do
            self.soe_joker_deck:emplace(SMODS.create_card({set = 'Joker', rarity = 'Common', area = self.soe_joker_deck, no_edition = true, key_append = 'soe_initial_joker_deck'}))
        end
    end
end

G.FUNCS.soe_draw_from_joker_deck_to_jokers = function(e)
    local hand_space = e
    local cards_to_draw = {}
    local space_taken = 0
    local limit = G.jokers.config.card_limit - #G.jokers.cards
    local unfixed = not G.jokers.config.fixed_limit
    local n = 0
    while n < #G.soe_joker_deck.cards and limit > 0 do
        local card = G.soe_joker_deck.cards[#G.soe_joker_deck.cards-n]
        local mod = unfixed and (card.ability.card_limit - card.ability.extra_slots_used) or 0
        if limit - 1 + mod < 0 then
        else    
            limit = limit - 1 + mod
            cards_to_draw[#cards_to_draw+1] = card
            space_taken = space_taken + (1 - mod)
        end
        n = n + 1
    end
    hand_space = #cards_to_draw
    delay(0.3)
    for i=1, hand_space do
        draw_card(G.soe_joker_deck,G.jokers, i*100/hand_space,'up', true, cards_to_draw[i])
    end
end

G.FUNCS.soe_draw_from_joker_discard_to_joker_deck = function()
    G.E_MANAGER:add_event(Event({
        func = function()
            local discard_count = #G.soe_joker_discard.cards
            for i=1, discard_count do
                draw_card(G.soe_joker_discard, G.soe_joker_deck, i*100/discard_count, 'up', nil, nil, 0.005, i%2==0, nil, math.max((21-i)/20, 0.7))
            end
            return true
        end
    }))
end

G.FUNCS.soe_play_jokers_from_highlighted = function()
    local oldghand, oldgdeck, oldgdiscard = G.hand, G.deck, G.discard
    G.hand, G.deck, G.discard = G.jokers, G.soe_joker_deck, G.soe_joker_discard
    G.FUNCS.play_cards_from_highlighted()
    G.hand, G.deck, G.discard = oldghand, oldgdeck, oldgdiscard
end

G.FUNCS.soe_discard_jokers_from_highlighted = function()
    local oldghand, oldgdeck, oldgdiscard = G.hand, G.deck, G.discard
    G.hand, G.deck, G.discard = G.jokers, G.soe_joker_deck, G.soe_joker_discard
    G.FUNCS.discard_cards_from_highlighted()
    G.hand, G.deck, G.discard = oldghand, oldgdeck, oldgdiscard
end

local oldsmodsgetenhancements = SMODS.get_enhancements
function SMODS.get_enhancements(card, ...)
    SEALS.extra_enhancement_check_in_progress = true
    local g = oldsmodsgetenhancements(card, ...)
    SEALS.extra_enhancement_check_in_progress = nil
    if G.soe_normal_smods_quantum then return g end
    for _, v in ipairs(SEALS.get_quantum_enhancements(card)) do
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
    loc_vars = function(_, _, card)
        return {vars = {card.ability.mult}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 0, y = 0},
    config = {mult = 4},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    soe_is_joker_enhancement = true,
    weight = 0,
    in_pool = function()
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
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.type}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 2, y = 0},
    config = {extra = {mult = 8, type = 'Pair'}},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    soe_is_joker_enhancement = true,
    weight = 0,
    in_pool = function()
        return false
    end,
    calculate = function(_, card, context)
        if context.cardarea == G.play and context.main_scoring and next(context.poker_hands[card.ability.extra.type]) then
            return {mult = card.ability.extra.mult}
        end
    end
}

SMODS.Enhancement{
    key = 'j_zany',
    loc_txt = {
        name = 'Zany Joker',
        text = {
            '{C:red}+#1#{} Mult if played',
            'hand contains',
            'a {C:attention}#2#',
        },
    },
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.type}}
    end,
    atlas = 'JokerEnhancements',
    pos = {x = 3, y = 0},
    config = {extra = {mult = 12, type = 'Three of a Kind'}},
    replace_base_card = true,
    always_scores = true,
    no_suit = true,
    no_rank = true,
    soe_is_joker_enhancement = true,
    weight = 0,
    in_pool = function()
        return false
    end,
    calculate = function(_, card, context)
        if context.main_scoring and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.type]) then
            return {mult = card.ability.extra.mult}
        end
    end
}

SMODS.Enhancement{
    key = 'j_blueprint',
    loc_txt = {
        name = 'Blueprint',
        text = {
            'Copies ability of',
            '{C:attention}Playing Card{} to the right',
        },
    },
    atlas = 'JokerEnhancements',
    pos = {x = 0, y = 3},
    replace_base_card = true,
    overrides_base_rank = true,
    always_scores = true,
    soe_is_joker_enhancement = true,
    soe_blueprint = true,
    weight = 0,
    in_pool = function()
        return false
    end,
    calculate = function(_, card, context)
        if card.area then
            local other_card = card.area.cards[card.rank+1]
            if other_card then
                if (context.blueprint or 0) > #card.area.cards then return end
                local old_context_blueprint = context.blueprint
                context.blueprint = (context.blueprint or 0) + 1
                local old_context_blueprint_card = context.blueprint_card
                context.blueprint_card = context.blueprint_card or card
                context.blueprint_copiers_stack = context.blueprint_copiers_stack or {}
                context.blueprint_copiers_stack[#context.blueprint_copiers_stack+1] = card
                context.blueprint_copier = context.blueprint_copiers_stack[#context.blueprint_copiers_stack]
                local eff_card = context.blueprint_card
                local eval = eval_card(other_card, context)
                context.blueprint = old_context_blueprint
                context.blueprint_card = old_context_blueprint_card
                table.remove(context.blueprint_copiers_stack, #context.blueprint_copiers_stack)
                context.blueprint_copier = context.blueprint_copiers_stack[#context.blueprint_copiers_stack]
                local ret = {}
                for k, v in pairs(eval) do
                    if type(v) == 'table' and (k == 'playing_card' or k == 'enhancement' or k == 'end_of_round') then
                        if not v.card then v.card = eff_card end
                        ret[#ret+1] = v
                    end
                end
                return SMODS.merge_effects(ret)
            end
        end
    end,
    set_ability = function(_, card)
        local oldbase = card.base
        card.base = SEALS.add_metatable({soe_old_base = oldbase}, {__index = function(_, k, b)
            if not card.area or (b or 0) > #card.area.cards then return end
            local other_card = card.area.cards[card.rank+1]
            if not other_card then return end
            local mt = getmetatable(other_card.base)
            local v
            if mt and mt.__index and type(mt.__index) == 'function' then
                v = mt.__index(other_card.base, k, (b or 0)+1)
            else
                v = other_card.base[k]
            end
            if v then return v end
        end})
    end
}

SMODS.Enhancement{
    key = 'j_brainstorm',
    loc_txt = {
        name = 'Brainstorm',
        text = {
            'Copies the ability',
            'of leftmost {C:attention}Playing Card',
        },
    },
    atlas = 'JokerEnhancements',
    pos = {x = 7, y = 7},
    replace_base_card = true,
    always_scores = true,
    soe_is_joker_enhancement = true,
    soe_blueprint = true,
    weight = 0,
    in_pool = function()
        return false
    end,
    calculate = function(_, card, context)
        if card.area then
            local other_card = card.area.cards[1]
            if other_card and other_card ~= card then
                if (context.blueprint or 0) > #card.area.cards then return end
                local old_context_blueprint = context.blueprint
                context.blueprint = (context.blueprint or 0) + 1
                local old_context_blueprint_card = context.blueprint_card
                context.blueprint_card = context.blueprint_card or card
                context.blueprint_copiers_stack = context.blueprint_copiers_stack or {}
                context.blueprint_copiers_stack[#context.blueprint_copiers_stack+1] = card
                context.blueprint_copier = context.blueprint_copiers_stack[#context.blueprint_copiers_stack]
                local eff_card = context.blueprint_card
                local eval = eval_card(other_card, context)
                context.blueprint = old_context_blueprint
                context.blueprint_card = old_context_blueprint_card
                table.remove(context.blueprint_copiers_stack, #context.blueprint_copiers_stack)
                context.blueprint_copier = context.blueprint_copiers_stack[#context.blueprint_copiers_stack]
                local ret = {}
                for k, v in pairs(eval) do
                    if type(v) == 'table' and (k == 'playing_card' or k == 'enhancement' or k == 'end_of_round') then
                        if not v.card then v.card = eff_card end
                        ret[#ret+1] = v
                    end
                end
                return SMODS.merge_effects(ret)
            end
        end
    end,
    set_ability = function(_, card)
        local oldbase = card.base
        card.base = SEALS.add_metatable({soe_old_base = oldbase}, {__index = function(_, k, b)
            if not card.area or (b or 0) > #card.area.cards then return end
            local other_card = card.area.cards[1]
            if other_card == card then return end
            local mt = getmetatable(other_card.base)
            local v
            if mt and mt.__index and type(mt.__index) == 'function' then
                v = mt.__index(other_card.base, k, (b or 0)+1)
            else
                v = other_card.base[k]
            end
            if v then return v end
        end})
    end
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
    soe_is_joker_enhancement = true,
    weight = 0,
    in_pool = function()
        return false
    end,
    calculate = function(_, _, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook and (context.cardarea == G.play or context.cardarea == G.hand) then
            local hand = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            return {level_up = true, level_up_hand = hand}
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
    soe_is_joker_enhancement = true,
    weight = 0,
    in_pool = function()
        return false
    end,
    calculate = function(_, _, context)
        if G.consumeables.cards[1] and context.main_scoring and context.cardarea == G.play then
            return {message = localize('k_duplicated_ex'), func = function()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = copy_card(pe(G.consumeables.cards, ps('perkeo')), nil)
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        card:juice_up()
                        return true
                    end
                }))
            end}
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
if has_cryptid then
    abovehand = 'cry_WholeDeck'
else
    abovehand = 'Flush Five'
end

SMODS.PokerHand {
    key = 'joker_central',
    above_hand = abovehand,
    visible = false,
    chips = 250,
    mult = 250,
    l_chips = 25,
    l_mult = 10,
    example = {
        {nil, true, enhancement = 'j_joker'},
        {nil, true, enhancement = 'j_lusty_joker'},
        {nil, true, enhancement = 'j_blueprint'},
        {nil, true, enhancement = 'j_brainstorm'},
        {nil, true, enhancement = 'j_perkeo'},
    },
    evaluate = function(_, hand)
        if #hand < 5 or SEALS.check_deck('inverse') then return {} end
        local t = {}
        local flush_count = 0
        for i=1, #hand do
            local v = hand[i]
            if v.config.center.set == 'Joker' or v.config.center.soe_is_joker_enhancement or SEALS.get_quantum_jokers(v)[1] then
                flush_count = flush_count + 1; t[#t+1] = v
            end
        end
        if flush_count >= 5 then
            return {t}
        end
        return {}
    end,
}

SMODS.PokerHand {
    key = 'joker_flush',
    above_hand = 'soe_seal_flush',
    visible = false,
    chips = 4,
    mult = 35,
    l_chips = 15,
    l_mult = 2,
    example = {
        {nil, true, enhancement = 'j_joker'},
        {nil, true, enhancement = 'j_lusty_joker'},
        {nil, true, enhancement = 'j_blue_joker'},
        {nil, true, enhancement = 'j_ice_cream'},
        {nil, true, enhancement = 'j_square'},
    },
    evaluate = function(_, hand)
        local ret = {}
        local four_fingers = SMODS.four_fingers()
        if #hand < four_fingers then
            return ret
        end
        local rarities = SMODS.Rarity.obj_buffer
        for j=1, #rarities do
            local t = {}
            local rarity = rarities[j]
            local flush_count = 0
            for i=1, #hand do
                if hand[i]:is_rarity(rarity) then
                    flush_count = flush_count + 1; t[#t+1] = hand[i]
                end
            end
            if flush_count >= four_fingers then
                ret[#ret+1] = t
                return ret
            end
        end
        return {}
    end,
}

SMODS.PokerHand {
    key = 'seal_flush',
    above_hand = 'Straight Flush',
    visible = false,
    chips = 120,
    mult = 20,
    l_chips = 50,
    l_mult = 10,
    example = {
        {'H_T', true, seal = 'Red'},
        {'C_2', true, seal = 'Red'},
        {'C_5', true, seal = 'Red'},
        {'S_7', true, seal = 'Red'},
        {'D_3', true, seal = 'Red'},
    },
    evaluate = function(_, hand)
        local ret = {}
        local four_fingers = SMODS.four_fingers()
        if #hand < four_fingers then
            return ret
        end
        local seals = {}
        for _, v in ipairs(G.P_CENTER_POOLS.Seal) do
            seals[#seals+1] = v.key
        end
        for j=1, #seals do
            local t = {}
            local seal = seals[j]
            local flush_count = 0
            for i=1, #hand do
                if SEALS.has_seal(hand[i], seal) then
                    flush_count = flush_count + 1; t[#t+1] = hand[i]
                end
            end
            if flush_count >= four_fingers then
                ret[#ret+1] = t
                return ret
            end
        end
        return {}
    end,
}

SMODS.Consumable {
	set = 'Planet',
	key = 'planeter',
	config = {hand_type = 'soe_joker_central', softlock = true},
	pos = {x = 0, y = 0},
	atlas = 'Planets',
    unlocked = true,
    discovered = true,
	loc_vars = function()
		return {
			vars = {
				localize('soe_joker_central', 'poker_hands'),
				G.GAME.hands.soe_joker_central.level,
				G.GAME.hands.soe_joker_central.l_mult,
				G.GAME.hands.soe_joker_central.l_chips,
				colours = {
					(
						to_big(G.GAME.hands.soe_joker_central.level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands.soe_joker_central.level)))]
					),
				},
			},
		}
	end,
}

function string.starts(string, start)
    return string.sub(string, 1, string.len(start)) == start
end

function SEALS.fake_retrigger(card, context)
    context.retrigger_joker = card
    local rt_eval, rt_post = eval_card(card, context)
    if rt_eval.jokers then
        local temp = {}
        SMODS.insert_repetitions(temp, {repetitions = 1}, card, 'joker_retrigger')
        local effect = temp[1]
        temp = nil
        local oldprefunc = rt_eval.jokers.pre_func
        rt_eval.jokers.pre_func = function()
            SMODS.calculate_effect(effect, card)
            if oldprefunc then oldprefunc() end
        end
        if next(rt_post) then SMODS.trigger_effects({rt_post}, card) end
    end
    context.retrigger_joker = nil
    return rt_eval
end

local oldcalcseal = Card.calculate_seal
function Card:calculate_seal(context)
    local seal = self.seal
    if self.debuff or not seal then return end
    if not SEALS.is_in_area(self, 'playing_cards') then
        local obj = G.P_SEALS[self.seal]
        if obj.soe_jokercalculate and type(obj.soe_jokercalculate) == 'function' then
            local o = obj:soe_jokercalculate(self, context)
            if o then
                if not o.card then o.card = self end
                return o
            end
        elseif obj.original_mod == SEALS and type(obj.calculate) == 'function' then
            context.soe_joker = true
            local o = obj:calculate(self, context)
            context.soe_joker = nil
            if o then
                if not o.card then o.card = self end
                return o
            end
        end
        if seal == 'Red' and context.retrigger_joker_check and context.other_card == self and not context.other_context.retrigger_joker then
            return {repetitions = 1, soe_seal_bypass_retrigger_restrictions = true}
        end
        if seal == 'Gold' and ((context.post_trigger and context.other_card == self) or context.forcetrigger) then
            return {dollars = 3, message_card = self}
        end
        if seal == 'Blue' and ((#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and context.end_of_round and context.main_eval) or context.forcetrigger) then
            local card_type = 'Planet'
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
                        local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)}))
            return {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet}
        end
        if seal == 'Purple' and ((SEALS.check_deck('inverse') and (context.discard and context.other_card == self) or context.selling_self) or context.forcetrigger) then
            if (#G.consumeables.cards + G.GAME.consumeable_buffer < (G.consumeables.config.card_limit + (self.area == G.consumeables and 1 or 0))) or context.forcetrigger then
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
        if seal == 'soe_reverseseal' then
            if (context.joker_main and self.facing == 'back') or context.forcetrigger then
                return {xmult = 3}
            end
        end
        if seal == 'soe_carmineseal' or seal == 'phanta_ghostseal' then
            if context.before then
                self.soe_scored = false
            end
            if context.post_trigger and context.other_card == self then
                self.soe_scored = true
            end
            if (context.after and not self.soe_scored) or context.forcetrigger then
                if seal == 'soe_carmineseal' then
                    if not SMODS.is_eternal(self, self) then
                        return {func = function() SMODS.destroy_cards(self) end}
                    end
                else
                    return {
                        message = localize({type = 'variable', key = 'a_spectral', vars = {1}}),
                        colour = G.C.SECONDARY_SET.Spectral,
                        func = function()
                            SEALS.event(function()
                                if count_consumables() < G.consumeables.config.card_limit then
                                    self:juice_up()
                                    SMODS.add_card {
                                        set = 'Spectral',
                                        key_append = 'ghostseal'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                end
                                return true
                            end)
                        end
                    }
                end
            end
        end
        if seal == 'cry_azure' and (context.after or context.forcetrigger) then
            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.0,
                func = function()
                    local _planet
                    if G.GAME.last_hand_played then
                        for _, v in ipairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                                break
                            end
                        end
                    end
                    for _=1, 3 do
                        SMODS.add_card({key = _planet, edition = 'e_negative', key_append = 'cry_azure'})
                    end
                    return true
                end
            }))
            SMODS.destroy_cards(self)
        end
        if seal == 'cry_green' then
            if context.before then
                self.soe_scored = false
            end
            if context.post_trigger and context.other_card == self then
                self.soe_scored = true
            end
            if (not self.soe_scored and context.after) or context.forcetrigger then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({set = 'Code', key_append = 'cry_green_seal'})
                            self:juice_up()
                            return true
                        end,
                    }))
                end
            end
        end
        if seal == 'crv_ps' then
            if (context.post_trigger and context.other_card == self) or context.forcetrigger then
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.0,
                    func = function()
                        local copy = SEALS.copy_card(self)
                        copy:start_materialize()
                        return true
                    end
                }))
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = 'Printed!'})
            end
        end
        if seal == 'fam_maroon_seal' then
            if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == self.area.cards[1] then
                return {repetitions = 1}
            end
        end
        if seal == 'fam_sapphire_seal' then
            if (context.end_of_round and context.main_eval) or context.forcetrigger then
                if (G.consumeables.config.card_limit > #G.consumeables.cards) or context.forcetrigger then
                    SMODS.add_card({set = 'Spectral', area = G.consumeables})
                    SMODS.calculate_effect({message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral}, self)
                end
            end
        end
        if seal == 'fam_gilded_seal' then
            if (context.post_trigger and context.other_card == self) or context.forcetrigger then
                if SMODS.pseudorandom_probability(self, 'gilded_seal', 1, 4) then
                    SMODS.calculate_effect({dollars = -5}, self)
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 5
                    G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                else
                    SMODS.calculate_effect({dollars = 5}, self)
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 5
                    G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                end
            end
        end
        if seal == 'fam_familiar_seal' then
            if (context.selling_self and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger then
                SMODS.add_card({set = 'Familiar_Tarots', area = G.consumeables})
                return {message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot}
            end
        end
        if seal == 'gb_dual' then
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
        if seal == 'bfdi_naily' then
            if context.joker_main then
                return {xmult = self.ability.seal.extra.h_x_mult}
            end
        end
        return
    else
        if seal == 'soe_reverseseal' then
            if (context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) and self.facing == 'back') or context.forcetrigger then
                return {xmult = 3}
            end
        end
        if seal == 'soe_carmineseal' then
            if (context.cardarea == 'unscored' and context.destroy_card and context.destroy_card == self) or context.forcetrigger then
                return {remove = true}
            end
        end
    end
    local g, post = oldcalcseal(self, context)
    local hardcoded = SEALS.is_in_area(self, 'playing_cards') and (seal == 'Gold' or seal == 'Blue')
    if (g or post or hardcoded) and not G.soe_retriggeringseals and SEALS.has_seal(self, 'soe_sealseal') then
        G.soe_retriggeringseals = true
        local effects = {g}
        for _=1, SEALS.get_seal_count(self, 'soe_sealseal') do
            if g or hardcoded then
                effects[#effects+1] = {message = localize('k_again_ex')}
            else
                SMODS.calculate_effect({message = localize('k_again_ex')}, self)
            end
            if hardcoded then
                effects[#effects+1] = SEALS.calculate_hardcoded_seals(self, context, seal)
            else
                effects[#effects+1] = self:calculate_seal(context)
            end
        end
        g = SMODS.merge_effects(effects)
        G.soe_retriggeringseals = nil
    end
    return g, post
end

function SEALS.get_seal_count(card, seal, extra_only)
    local count = 0
    for _, v in ipairs(SEALS.get_seals(card, extra_only)) do
        if not seal or v == seal then
            count = count + 1
        end
    end
    if seal and SEALS.has_seal(card, seal) and count < 1 then
        count = 1
    end
    return count
end

local oldsetseal = Card.set_seal
function Card:set_seal(_seal, silent, immediate)
    if self.ability.soe_detached_seal then return end
    if _seal then
        if G.soe_creatingmergedcard then silent = true end
        if G.P_CENTERS[_seal] and G.P_CENTERS[_seal].set == 'Joker' then
            self.ability.soe_jokerseals = self.ability.soe_jokerseals or {}
            self.ability.soe_jokerseals[#self.ability.soe_jokerseals+1] = _seal
            if not silent then
                G.CONTROLLER.locks.seal = true
                local sound = {sound = 'gold_seal', per = 1.2, vol = 0.4}
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
            return
        end
        if G.GAME.soe_redsealretriggeringtrue and _seal == self.seal and G.P_SEALS['soe_upgraded'.._seal:lower()..'seal'] then
            self:set_seal(nil, true, true)
            _seal = 'soe_upgraded'.._seal:lower()..'seal'
            if _seal == 'soe_upgradedsoe_rainbowsealseal' and SEALS.find_mod('jen') then
                play_sound('jen_omegacard', 1, 0.4)
                self:juice_up(1.5, 1.5)
                Q(function() Q(function() play_sound('jen_chime', 1, 0.65) return true end); jl.a('Omega!', G.SETTINGS.GAMESPEED, 1, G.C.jen_RGB); jl.rd(1) return true end)
            end
        end
        if self.seal and not self.soe_from_copy and not self.soe_dont_quantum and SEALS.is_eligible_for_seal(self) then
            self.ability.soe_quantum_seals = self.ability.soe_quantum_seals or {}
            self.ability.soe_quantum_seals[#self.ability.soe_quantum_seals+1] = _seal
            if not silent then
                G.CONTROLLER.locks.seal = true
                local sound = G.P_SEALS[_seal].sound or {sound = 'gold_seal', per = 1.2, vol = 0.4}
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
            return
        end
    end
    if self.seal == 'soe_upgradedsoe_rainbowsealseal' then return end
    oldsetseal(self, _seal, silent, immediate)
    if self.seal == 'soe_upgradedsoe_rainbowsealseal' then SEALS.recalc_quantum_editions(self) end
end

local oldgetseal = Card.get_seal
function Card:get_seal(bypass_debuff)
    if self.debuff and not bypass_debuff then return end
    if not self.seal then
        local seals = SEALS.get_seals(self, true)[1]
        if seals then return seals end
    end
    return oldgetseal(self, bypass_debuff)
end

local oldcopycard = copy_card
function copy_card(other, ...)
    local g = oldcopycard(other, ...)
    local extra_editions = SEALS.get_quantum_editions(other)
    if extra_editions[1] then
        for _, v in ipairs(extra_editions) do
            local config = G.P_CENTERS[v].config
            g.ability.card_limit = g.ability.card_limit - (config.card_limit or 0)
            g.ability.extra_slots_used = g.ability.extra_slots_used - (config.extra_slots_used or 0)
        end
    end
    g.soe_from_copy = nil
    return g
end

local oldunhighlightall = CardArea.unhighlight_all
function CardArea:unhighlight_all()
    if not (G.GAME.soe_usedconsumablehasredseal or G.GAME.soe_usingmergedconsumables) then
        oldunhighlightall(self)
    end
end

local oldcanuseconsume = Card.can_use_consumeable
function Card:can_use_consumeable(a, skip_check)
    if not skip_check and ((G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)) then
        return oldcanuseconsume(self, a, skip_check)
    end
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        local min, max
        for _, v in ipairs(self.ability.soe_mergedcards) do
            local center = G.P_CENTERS[v.key]
            if center and center.consumeable then
                if center.config.max_highlighted or center.config.min_highlighted then
                    if v.seal ~= 'soe_negativeseal' and (center.config.max_highlighted or 0) > (max or 0) then
                        max = center.config.max_highlighted
                    end
                    if (center.config.min_highlighted or 0) > (min or 0) then
                        min = center.config.min_highlighted
                    end
                end
            end
        end
        return (#G.hand.highlighted >= (min or max and 1 or 0) and #G.hand.highlighted <= (max == nil and 1e309 or max))
    end
    local oldmaxhighlighted
    local maxhighlighted = self.ability.max_highlighted or (self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.max_highlighted)
    if G.hand.config.soe_old_highlighted_limit and maxhighlighted and SEALS.has_seal(self, 'soe_negativeseal') then
        oldmaxhighlighted = maxhighlighted
        self.ability.max_highlighted, self.ability.consumeable.mod_num, self.ability.consumeable.max_highlighted = 1e309, 1e309, 1e309
        if self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.max_highlighted then
            self.ability.extra.max_highlighted = 1e309
        end
    end
    local g = oldcanuseconsume(self, a, skip_check)
    if oldmaxhighlighted then
        self.ability.max_highlighted, self.ability.consumeable.mod_num = oldmaxhighlighted, oldmaxhighlighted
        if self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.max_highlighted then
            self.ability.extra.max_highlighted = oldmaxhighlighted
        end
    end
    return g
end

local olduseconsume = Card.use_consumeable
function Card:use_consumeable(...)
    local oldmaxhighlighted
    local maxhighlighted = self.ability.max_highlighted or (self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.max_highlighted)
    if G.hand.config.soe_old_highlighted_limit and maxhighlighted and SEALS.has_seal(self, 'soe_negativeseal') then
        oldmaxhighlighted = maxhighlighted
        self.ability.max_highlighted, self.ability.consumeable.mod_num, self.ability.consumeable.max_highlighted = 1e309, 1e309, 1e309
        if self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.max_highlighted then
            self.ability.extra.max_highlighted = 1e309
        end
    end
    if SEALS.has_seal(self, 'Red') or SEALS.has_seal(self, 'soe_upgradedredseal') then
        G.GAME.soe_usedconsumablehasredseal = true
    else
        G.GAME.soe_usedconsumablehasredseal = nil
    end
    if SEALS.has_seal(self, 'crv_ps') then
        local copy = SEALS.copy_card(self, nil, G.consumeables)
        copy.states.visible = false
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.calculate_effect({message = 'Printed!', instant = true}, self)
                copy:start_materialize()
                return true
            end
        }))
        delay(0.9375)
    end
    local g = olduseconsume(self, ...)
    if SEALS.has_seal(self, 'Gold') then
        local effects = {}
        for _=1, SEALS.get_seal_count(self, 'Gold') do
            effects[#effects+1] = {dollars = 3}
        end
        SMODS.calculate_effect(SMODS.merge_effects(effects), self)
    end
    if SEALS.has_seal(self, 'soe_upgradedgoldseal') then
        local effects = {}
        for _=1, SEALS.get_seal_count(self, 'soe_upgradedgoldseal') do
            effects[#effects+1] = {
                dollars = G.GAME.dollars/2,
                remove_default_message = true,
                message = localize('$')..'X1.5',
                colour = G.C.MONEY
            }
        end
        SMODS.calculate_effect(SMODS.merge_effects(effects), self)
    end
    if not G.soe_redsealretriggering and (SEALS.has_seal(self, 'Red') or SEALS.has_seal(self, 'soe_upgradedredseal')) then
        G.soe_redsealretriggering = true
        G.GAME.soe_redsealretriggeringtrue = true
		local count = SEALS.get_seal_count(self, 'Red')
        local other_count = SEALS.get_seal_count(self, 'soe_upgradedredseal')+1
        for j=1, other_count do
            if count<=0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.soe_usedconsumablehasredseal = nil
                        return true
                    end
                }))
            end
            if j>1 then
                SMODS.calculate_effect({message = 'Again!!', colour = G.C.RED}, self)
                local ok, err = pcall(self.use_consumeable, self, ...)
                if not ok then sendErrorMessage(err, 'SEALS') end
            end
            local jiscount = j == other_count
            if count>0 then
                for i=1, count do
                    if i == count and jiscount then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.soe_usedconsumablehasredseal = nil
                                return true
                            end
                        }))
                    end
                    SMODS.calculate_effect({message = localize('k_again_ex')}, self)
                    local ok, err = pcall(self.use_consumeable, self, ...)
                    if not ok then sendErrorMessage(err, 'SEALS') end
                end
            end
            if jiscount then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.soe_redsealretriggeringtrue = nil
                        return true
                    end
                }))
            end
        end
        G.soe_redsealretriggering = nil
    end
    if oldmaxhighlighted then
        self.ability.max_highlighted, self.ability.consumeable.mod_num = oldmaxhighlighted, oldmaxhighlighted
        if self.ability.extra and type(self.ability.extra) == 'table' and self.ability.extra.max_highlighted then
            self.ability.extra.max_highlighted = oldmaxhighlighted
        end
    end
    return g
end

local oldopen = Card.open
function Card:open()
    if self.ability.set == 'Booster' then
        if SEALS.has_seal(self, 'Gold') then
            local effects = {}
            for _=1, SEALS.get_seal_count(self, 'Gold') do
                effects[#effects+1] = {dollars = 3}
            end
            SMODS.calculate_effect(SMODS.merge_effects(effects), self)
        end
    end
    oldopen(self)
end

local oldredeem = Card.redeem
function Card:redeem()
    if self.ability.set == 'Voucher' then
        if SEALS.has_seal(self, 'Gold') then
            local effects = {}
            for _=1, SEALS.get_seal_count(self, 'Gold') do
                effects[#effects+1] = {dollars = 3}
            end
            SMODS.calculate_effect(SMODS.merge_effects(effects), self)
        end
    end
    oldredeem(self)
end

local oldbacktriggereffect = Back.trigger_effect
function Back:trigger_effect(args)
    local chips, mult = oldbacktriggereffect(self, args)
    if G.GAME.soe_extra_decks and G.GAME.soe_extra_decks[1] then
        for _, v in ipairs(G.GAME.soe_extra_decks) do
            local center = G.P_CENTERS[v]
            if center.name == 'Anaglyph Deck' and args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_double'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
            if center.name == 'Plasma Deck' and args.context == 'final_scoring_step' then
                chips = chips or args.chips
                mult = mult or args.mult
                local tot = chips + mult
                chips = math.floor(tot/2)
                mult = math.floor(tot/2)
                update_hand_text({delay = 0}, {mult = mult, chips = chips})
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
    return chips, mult
end

local oldgfuncsevaluateplay = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    G.soe_scoring_name, _, G.soe_poker_hands = G.FUNCS.get_poker_hand_info(G.play.cards)
    oldgfuncsevaluateplay(e)
    G.soe_scoring_name, G.soe_poker_hands, G.soe_scoring_hand = nil, nil, nil
end

local oldsmodsgetcardareas = SMODS.get_card_areas
function SMODS.get_card_areas(_type, _context)
    local output = oldsmodsgetcardareas(_type, _context)
    if not G.deck then return output end
    --[[
    if _type == 'jokers' then
        local fake_cardarea = {cards = {}}
        for _, v in ipairs(G.I.CARD) do
            if v.ability.soe_calculate_like_normal_joker then
                fake_cardarea.cards[#fake_cardarea.cards+1] = v
            end
        end
        output[#output+1] = fake_cardarea
    end
    ]]
    if _type == 'individual' then
        if G.GAME.soe_extra_decks and G.GAME.soe_extra_decks[1] then
            for _, v in ipairs(G.GAME.soe_extra_decks) do
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
        end
        if SEALS.find_mod('partner') and G.GAME.soe_extra_partner_cards and G.GAME.soe_extra_partner_cards[1] then
            for _, v in ipairs(G.GAME.soe_extra_partner_cards) do
                if is(v, Card) then
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
        if G.GAME.soe_detached_seals and G.GAME.soe_detached_seals[1] then
            for _, v in ipairs(G.GAME.soe_detached_seals) do
                if is(v, Card) and v.ability.soe_detached_seal then
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
        for i=1, 2 do
            local cards
            if i==1 then cards = G.soe_scoring_hand else cards = G.hand.cards end
            if cards and ((i==1 and G.GAME.SEALS_Scoring_Active) or (i==2 and not G.GAME.SEALS_Scoring_Active)) then
                for _, vv in ipairs(cards) do
                    if is(vv, Card) then
                        if vv.ability.set ~= 'Enhanced' and vv.ability.set ~= 'Default' then
                            output[#output+1] = {
                                object = {calculate = function(_, context)
                                    if not context.joker_main and not context.other_main and not context.individual then
                                        return vv:calculate_joker(context)
                                    end
                                end},
                                scored_card = vv,
                            }
                        end
                        local jokers = SEALS.get_quantum_jokers(vv)
                        if jokers[1] then
                            output[#output+1] = {
                                object = {calculate = function(_, context)
                                    if not context.joker_main and not context.other_main and not context.individual then
                                        return SEALS.calculate_quantum_jokers(vv, context, jokers)
                                    end
                                end},
                                scored_card = vv,
                            }
                        end
                        local jokerseals = vv.ability.soe_jokerseals
                        if jokerseals and jokerseals[1] then
                            output[#output+1] = {
                                object = {calculate = function(_, context)
                                    if not context.joker_main and not context.other_main and not context.individual then
                                        return SEALS.calculate_quantum_jokers(vv, context, jokerseals)
                                    end
                                end},
                                scored_card = vv,
                            }
                        end
                    end
                end
            end
        end
    end
    return output
end

if SEALS.find_mod('partner') then
    local oldsaverun = save_run
    function save_run()
        if G.GAME.soe_extra_partner_cards and G.GAME.soe_extra_partner_cards[1] then
            for i, v in ipairs(G.GAME.soe_extra_partner_cards) do
                if v.ability then
                    G.GAME.soe_extra_partners_tables = G.GAME.soe_extra_partners_tables or {}
                    for k, vv in pairs(v.ability) do
                        G.GAME.soe_extra_partners_tables[i] = G.GAME.soe_extra_partners_tables[i] or {}
                        G.GAME.soe_extra_partners_tables[i][k] = vv
                    end
                end
            end
        end
        oldsaverun()
    end

    local oldgamestartrun2 = Game.start_run
    function Game:start_run(args)
        oldgamestartrun2(self, args)
        local any_unlocked
        for _, v in ipairs(G.P_CENTER_POOLS.Partner) do
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
                            centers[#centers+1] = G.P_CENTERS[v]
                        end
                    end
                    G.GAME.soe_extra_partner_cards = {}
                    for i, v in ipairs(centers) do
                        G.GAME.soe_extra_partner_cards[i] = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W*46/71, G.CARD_H*58/95, nil, v)
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
    end
end

local oldsaverun = save_run
function save_run()
    G.GAME.soe_detached_seals_tables, G.GAME.soe_detached_seal_positions = {}, {}
    if G.GAME.soe_detached_seals and G.GAME.soe_detached_seals[1] then
        for i, v in ipairs(G.GAME.soe_detached_seals) do
            if v and v.ability then
                G.GAME.soe_detached_seals_tables[i] = {}
                for k, vv in pairs(v.ability) do
                    G.GAME.soe_detached_seals_tables[i][k] = vv
                end
            end
            if v and v.T then
                G.GAME.soe_detached_seal_positions[i] = {x = v.T.x, y = v.T.y}
            end
        end
    end
    oldsaverun()
end

local oldcardsave = Card.save
function Card:save()
    if self.soe_savedobjects and next(self.soe_savedobjects) then
        self.ability.soe_savedobjectvalues = {}
        for k, v in pairs(self.soe_savedobjects) do
            self.ability.soe_savedobjectvalues[k] = {ability = v.ability, edition = v.edition}
        end
    end
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        for _, v in ipairs(self.ability.soe_mergedcards) do
            v.ability = SEALS.copy_card_but_not(self, v).ability
        end
    end
    return oldcardsave(self)
end

local oldgamestartrun = Game.start_run
function Game:start_run(args)
    G.soe_indexable_cards = {}
    G.soe_check_eternal_cache = {}
    G.soe_quantum_context_cache = {Gold = {'main_scoring', 'post_trigger'}, Blue = {'end_of_round'}}
    G.soe_cachedsavedobjects = {}
    G.soe_old_editions = {}
    oldgamestartrun(self, args)
    if SEALS.check_deck('merged', true) and not G.GAME.round_resets.soe_mergedblinds then
        reset_merged_blinds()
    end
    if G.GAME.soe_detached_seal_keys then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.soe_detached_seals = {}
                for i, v in ipairs(G.GAME.soe_detached_seal_keys) do
                    G.GAME.soe_detached_seals[i] = Card(G.GAME.soe_detached_seal_positions[i].x or G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.GAME.soe_detached_seal_positions[i].y or G.deck.T.y-G.CARD_H*1.6, G.CARD_W/2.63, G.CARD_H/3.52, nil, G.P_CENTERS.c_base)
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
	self.soe_jokerhandsbutton = UIBox({
        definition = {n = G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, minw = G.deck.T.w, minh = 0.5}, nodes = {{
            n = G.UIT.R, nodes = {{
                n = G.UIT.C,
                config = {
                    align = 'tm',
                    minw = 2,
                    padding = 0.1,
                    r = 0.1,
                    hover = true,
                    colour = G.C.UI.BACKGROUND_DARK,
                    shadow = true,
                    button = 'calc_joker_hands',
                    func = 'can_calc_joker_hands',
                },
                nodes = {{
                    n = G.UIT.R,
                    config = {align = 'bcm', padding = 0},
                    nodes = {{
                        n = G.UIT.T,
                        config = {
                            text = 'Joker Hands',
                            scale = 0.35,
                            colour = G.C.UI.TEXT_LIGHT,
                            id = 'calculate_joker_hands'
                        }
                    }}
                }}
            }}
        }}},
		config = {major = G.deck, align = 'tm', offset = {x = 0, y = -0.85}, bond = 'Weak'}
	})
    self.soe_jokerhandsbutton.states.visible = false
    self.jokers.config.highlighted_limit = 1000
    self.consumeables.config.highlighted_limit = 1000
end

function SEALS:calculate(context)
    if context.press_play then
        G.soe_event_scoring = true
    end
    if context.soe_calcjokerhands and G.GAME.soe_joker_hands_available then
        for k, v in pairs(context.soe_joker_hands) do
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=v, level=G.GAME.soe_joker_hands[k].level})
            delay(0.9)
            update_hand_text({sound = 'chips1', delay = 0}, {chips = (hand_chips or 0) + G.GAME.soe_joker_hands[k].chips, StatusText = true})
            SMODS.Scoring_Parameters.chips:modify(G.GAME.soe_joker_hands[k].chips)
            delay(0.9)
            update_hand_text({sound = 'multhit1', delay = 0}, {mult = (mult or 0) + G.GAME.soe_joker_hands[k].mult, StatusText = true})
            SMODS.Scoring_Parameters.mult:modify(G.GAME.soe_joker_hands[k].mult)
            delay(0.9)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {handname = localize(context.scoring_name, 'poker_hands'), level = G.GAME.hands[context.scoring_name].level})
            delay(1)
        end
    end
    if context.individual and context.cardarea == G.play then
        if context.other_card.ability.legallysleeve == 'Plasma' then
            SMODS.calculate_effect({balance = true}, context.other_card)
        end
    end
    if context.after and G.GAME.chips+SMODS.calculate_round_score() < G.GAME.blind.chips then
        SEALS.event(function()
            if SEALS.check_deck('inverse') then
                local thunk = G.hand.config.highlighted_limit
                G.hand.config.highlighted_limit = 1000
                for _, v in ipairs(G.hand.cards) do
                    G.hand:add_to_highlighted(v, true)
                end
                play_sound('card1', 1)
                G.FUNCS.discard_cards_from_highlighted(nil, true)
                G.hand.config.highlighted_limit = thunk
            end
            G.soe_event_scoring = nil
            return true
        end)
    end
end

local oldstartdissolve = Card.start_dissolve
function Card:start_dissolve(...)
    if SMODS.is_eternal(self) and self.playing_card then self.getting_sliced = nil; return end
    if SEALS.has_sticker(self, 'soe_epsilon') then self:remove() return end
    oldstartdissolve(self, ...)
end

local oldshatter = Card.shatter
function Card:shatter()
    if SMODS.is_eternal(self) and self.playing_card then self.getting_sliced = nil; return end
    if SEALS.has_sticker(self, 'soe_epsilon') then self:remove() return end
    oldshatter(self)
end

SMODS.Sticker:take_ownership('perishable', {
        calculate = function(_, card, context)
            if context.main_scoring and context.cardarea == G.play then
                return {func = function() card:calculate_perishable() end}
            end
            if context.end_of_round and context.main_eval then
                card:calculate_perishable()
            end
        end
    },
true)

SMODS.Sticker:take_ownership('rental', {
        calculate = function(_, card, context)
            if context.playing_card_end_of_round and context.cardarea == G.hand or context.end_of_round and context.main_eval then
                card:calculate_rental()
            end
        end
    },
true)

local fix_context = SEALS.fix_context
local cache_context = SEALS.cache_context
local function unfix_return(t)
    local new_t = {}
    for k, v in pairs(t) do
        if k == 'card' or G.soe_indexable_cards[v] then
            new_t[k] = G.soe_indexable_cards[v]
        elseif type(v) ~= 'table' then
            new_t[k] = v
        elseif k == 'extra' then
            new_t[k] = unfix_return(v)
        else
            new_t[k] = v
        end
    end
    return new_t
end
local function fix_return(t, self)
    local new_t = {}
    for k, v in pairs(t) do
        if type(v) ~= 'table' and type(v) ~= 'function' then
            new_t[k] = v
        elseif (k ~= 'card' or v ~= self) and is(v, Card) then
            new_t[k] = v.unique_val
        elseif k == 'extra' then
            new_t[k] = fix_return(v)
        elseif k == 'message' or k == 'mult_message' or k == 'chip_message' or k == 'xmult_message' or k == 'xchip_message' or k == 'emult_message' or k == 'echip_message' then
            new_t[k] = sc(v)
        end
    end
    return new_t
end
local oldcalcjoker = Card.calculate_joker
function Card:calculate_joker(context)
    local g, post = oldcalcjoker(self, context)
    if SEALS.has_edition(self, 'e_soe_frozen') and not self.config.center.soe_frozen_immune then
        if self.ability.name == 'Blue Joker' and context.joker_main and not G.deck.cards[1] then
            g, post = {
                message = '+0',
                chip_mod = 0,
                colour = G.C.CHIPS
            }, nil
        end
        if type(g) == 'table' and next(g) then
            local snapshot = self.ability.soe_frozen_snapshot
            local savable_context = STR_PACK(fix_context(context))
            if self.ability.soe_frozen_key == self.config.center_key and snapshot.calculate[savable_context] then
                local other_ret = unfix_return(snapshot.calculate[savable_context])
                for k in pairs(g) do
                    if other_ret[k] ~= nil then
                        g[k] = other_ret[k]
                    end
                end
            else
                snapshot.calculate[savable_context] = fix_return(g, self)
                self.ability.soe_frozen_key = self.config.center_key
            end
        end
    end
    if not G.soe_calculating_playing_card_on_joker and self.base.id and context.joker_main then
        local other_context = sc(context)
        other_context.cardarea = G.play
        other_context.joker_main = nil
        playingcard = {func = function()
            G.soe_calculating_playing_card_on_joker = true
            SMODS.score_card(self, other_context)
            G.soe_calculating_playing_card_on_joker = nil
        end}
        if g then
            g = SMODS.merge_effects({g, playingcard})
        else
            g = playingcard
        end
    end
    if context.joker_main and self.ability.legallysleeve == 'Plasma' then
        SMODS.calculate_effect({balance = true}, self)
    end
    if not G.soe_from_eval_card and G.soe_calculating_merged_cards ~= self and self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        local oldmergedcard = G.soe_calculating_merged_cards
        G.soe_calculating_merged_cards = self
        for _, v in ipairs(self.ability.soe_mergedcards) do
            local passed
            if v.key then
                local center = G.P_CENTERS[v.key]
                cache_context(self, center)
                passed = G.soe_quantum_context_cache[v.key] == true
                if not passed then
                    for _, v in ipairs(G.soe_quantum_context_cache[v.key]) do
                        if context[v] then passed = true; break end
                    end
                end
            end
            if passed or not v.key then
                local copy = SEALS.copy_card_but_not(self, v)
                local my_pos, cards = self.rank, self.area and self.area.cards
                if cards then
                    cards[my_pos] = copy
                    copy.rank = my_pos
                end
                local eval = copy:calculate_joker(context)
                if cards then
                    cards[my_pos] = self
                end
                local effects = {g}
                if eval then effects[#effects+1] = eval end
                g = SMODS.merge_effects(effects)
            end
        end
        G.soe_calculating_merged_cards = oldmergedcard
    end
    if post == true and type(g) == 'table' then return g end
    return g, post
end

local oldcarddraw = Card.draw
function Card:draw(layer)
    if not self.soe_shallow_copied_card then
        oldcarddraw(self, layer)
    end
end

--[[
--local oldmultmodify = SMODS.Scoring_Parameters.mult.modify
local oldmultcalceffect = SMODS.Scoring_Parameters.mult.calc_effect
SMODS.Scoring_Parameter:take_ownership('mult', {
    --[[
    modify = function(self, amount, skip, ...)
        local g = oldmultmodify(self, amount, skip, ...)
        if G.GAME.soe_quantum_numbers and G.GAME.SEALS_Scoring_Active then
            SEALS.event(function()
                local values = {{ref_table = G.GAME.current_round, ref_value = 'hands_left', func = function(x) ease_hands_played(x, true) end}, {ref_table = G.GAME.current_round, ref_value = 'discards_left', func = function(x) ease_discard(x, true) end}, {ref_table = G.GAME, ref_value = 'dollars', func = function(x) ease_dollars(x, true) end}, {ref_table = _G, ref_value = 'hand_chips', func = function(x) SMODS.Scoring_Parameters.chips:modify(x) end}}
                if not G.GAME.soe_quantum_number then
                    G.GAME.soe_quantum_number = 0
                    for _, v in ipairs(values) do
                        G.GAME.soe_quantum_number = to_number(G.GAME.soe_quantum_number + (v.ref_table[v.ref_value] or 0))
                    end
                    for _, v in ipairs(values) do
                        if v.ref_table[v.ref_value] and to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number) ~= 0 then
                            v.func(to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number))
                        end
                    end
                end
                local passed, oldnumber = false, to_number(G.GAME.soe_quantum_number)
                for _, v in ipairs(values) do
                    if v.ref_table[v.ref_value] and to_number(v.ref_table[v.ref_value]) ~= oldnumber then
                        passed = true
                        G.GAME.soe_quantum_number = to_number(G.GAME.soe_quantum_number + (v.ref_table[v.ref_value] - oldnumber))
                    end
                end
                if passed then
                    for _, v in ipairs(values) do
                        if v.ref_table[v.ref_value] and to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number) ~= 0 then
                            v.func(to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number))
                        end
                    end
                end
                G.GAME.round_resets.discards = G.GAME.current_round.discards_left
                G.GAME.round_resets.hands = G.GAME.current_round.hands_left
                return true
            end)
        end
        return g
    end,
    ]]--[[
    calc_effect = function(self, effect, scored_card, key, amount, ...)
        local g = oldmultcalceffect(self, effect, scored_card, key, amount, ...)
        if amount ~= 0 and G.GAME and G.GAME.current_round.current_hand.multseal and SEALS.perform_checks({key}, '==', self.calculation_keys) then
            local seal = G.GAME.current_round.current_hand.multseal
            if seal == 'Red' then
                if not SMODS.silent_calculation[key] then
                    percent = (percent or 0) + (percent_delta or 0.08)
                end
                oldmultcalceffect(self, effect, scored_card, key, amount, ...)
            end
            if seal == 'Gold' then
                ease_dollars(3)
            end
        end
        return g
    end
}, true)

--local oldchipsmodify = SMODS.Scoring_Parameters.chips.modify
local oldchipscalceffect = SMODS.Scoring_Parameters.chips.calc_effect
SMODS.Scoring_Parameter:take_ownership('chips', {
    --[[
    modify = function(self, amount, skip, ...)
        local g = oldchipsmodify(self, amount, skip, ...)
        if G.GAME.soe_quantum_numbers and G.GAME.SEALS_Scoring_Active then
            SEALS.event(function()
                local values = {{ref_table = G.GAME.current_round, ref_value = 'hands_left', func = function(x) ease_hands_played(x, true) end}, {ref_table = G.GAME.current_round, ref_value = 'discards_left', func = function(x) ease_discard(x, true) end}, {ref_table = G.GAME, ref_value = 'dollars', func = function(x) ease_dollars(x, true) end}, {ref_table = _G, ref_value = 'mult', func = function(x) SMODS.Scoring_Parameters.mult:modify(x) end}}
                if not G.GAME.soe_quantum_number then
                    G.GAME.soe_quantum_number = 0
                    for _, v in ipairs(values) do
                        G.GAME.soe_quantum_number = to_number(G.GAME.soe_quantum_number + (v.ref_table[v.ref_value] or 0))
                    end
                    for _, v in ipairs(values) do
                        if v.ref_table[v.ref_value] and to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number) ~= 0 then
                            v.func(to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number))
                        end
                    end
                end
                local passed, oldnumber = false, to_number(G.GAME.soe_quantum_number)
                for _, v in ipairs(values) do
                    if v.ref_table[v.ref_value] and to_number(v.ref_table[v.ref_value]) ~= oldnumber then
                        passed = true
                        G.GAME.soe_quantum_number = to_number(G.GAME.soe_quantum_number + (v.ref_table[v.ref_value] - oldnumber))
                    end
                end
                if passed then
                    for _, v in ipairs(values) do
                        if v.ref_table[v.ref_value] and to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number) ~= 0 then
                            v.func(to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number))
                        end
                    end
                end
                G.GAME.round_resets.discards = G.GAME.current_round.discards_left
                G.GAME.round_resets.hands = G.GAME.current_round.hands_left
                return true
            end)
        end
        return g
    end,
    ]]--[[
    calc_effect = function(self, effect, scored_card, key, amount, ...)
        local g = oldchipscalceffect(self, effect, scored_card, key, amount, ...)
        if amount ~= 0 and G.GAME and G.GAME.current_round.current_hand.chipseal and SEALS.perform_checks({key}, '==', self.calculation_keys) then
            local seal = G.GAME.current_round.current_hand.chipseal
            if seal == 'Red' then
                if not SMODS.silent_calculation[key] then
                    percent = (percent or 0) + (percent_delta or 0.08)
                end
                oldchipscalceffect(self, effect, scored_card, key, amount, ...)
            end
            if seal == 'Gold' then
                ease_dollars(3)
            end
        end
        return g
    end
}, true)
]]

local oldevalcard = eval_card
function eval_card(card, context)
    if context.extra_enhancement then return oldevalcard(card, context) end
    if SEALS.check_deck('inverse') and (card.ability.set ~= 'Enhanced' and card.ability.set ~= 'Default' and G.GAME.SEALS_Scoring_Active and not tc(context.scoring_hand or G.soe_scoring_hand, card)) then return {}, {} end
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards or context.joker_type_destroyed) then G.soe_from_eval_card = nil; return oldevalcard(card, context) end
    G.soe_from_eval_card = true
    local g, post = oldevalcard(card, context)
    if not G.soe_calculating_jokers_as_playing_cards and context.main_scoring and context.cardarea == G.play and (tc(SMODS.get_card_areas('playing_cards'), card.area) and (card.ability.set ~= 'Enhanced' and card.ability.set ~= 'Default' or SEALS.get_quantum_jokers(card)[1])) then
        G.soe_calculating_jokers_as_playing_cards = true
        local effects = {g.playing_card}
        if card.ability.set ~= 'Enhanced' and card.ability.set ~= 'Default' then
            effects[#effects+1] = SEALS.calculate_joker_as_playing_card(card, context)
        end
        local jokers = SEALS.get_quantum_jokers(card)
        if jokers[1] then
            effects[#effects+1] = SEALS.calculate_joker_as_playing_card(card, context, true)
        end
        g.playing_card = SMODS.merge_effects(effects)
        G.soe_calculating_jokers_as_playing_cards = nil
    end
    --[[
    if not (context.mod_probability or context.fix_probability) and SEALS.has_seal(card, 'soe_holoseal') and tc(SMODS.get_card_areas('jokers'), card.area) and SMODS.post_prob and SMODS.post_prob[1] then
        local prob
        for i=#SMODS.post_prob, 1, -1 do
            local v = SMODS.post_prob[i]
            if v.trigger_obj == card then
                prob = v
                break
            end
        end
        if prob and not prob.result then
            G.soe_holoseal_retrigger = true
            local effects = {g.jokers}
            effects[#effects+1] = SEALS.fake_retrigger(card, context).jokers
            g.jokers = SMODS.merge_effects(effects)
            G.soe_holoseal_retrigger = nil
        end
    end
    ]]
    if not G.soe_calculating_joker_enhancements and next(SEALS.get_joker_enhancements(card)) and (context.joker_main or context.before or context.after or (context.end_of_round and context.main_eval)) then
        G.soe_calculating_joker_enhancements = true
        local effects = {g.jokers}
        effects[#effects+1] = SEALS.calculate_joker_enhancements(card, context)
        g.jokers = SMODS.merge_effects(effects)
        G.soe_calculating_joker_enhancements = nil
    end
    if not G.soe_calculating_joker_seals and card.ability.soe_jokerseals and card.ability.soe_jokerseals[1] then
        G.soe_calculating_joker_seals = true
        local effects = {g.jokers}
        effects[#effects+1] = SEALS.calculate_joker_seals(card, context)
        g.jokers = SMODS.merge_effects(effects)
        G.soe_calculating_joker_seals = nil
    end
    if not SEALS.is_in_area(card, 'playing_cards') then
        local effect = SEALS.calculate_quantum_jokers(card, context)
        if effect then
            if g.jokers then
                g.jokers = SMODS.merge_effects({g.jokers, effect})
            else
                g.jokers = effect
            end
        end
    end
    if G.soe_calculating_merged_cards ~= card and G.soe_from_smods_score_card ~= card and card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] then
        local oldmergedcard = G.soe_calculating_merged_cards
        G.soe_calculating_merged_cards = card
        for _, v in ipairs(card.ability.soe_mergedcards) do
            local passed
            if v.key then
                local center = G.P_CENTERS[v.key]
                cache_context(card, center)
                local passed = G.soe_quantum_context_cache[v.key] == true
                if not passed then
                    for _, v in ipairs(G.soe_quantum_context_cache[v.key]) do
                        if context[v] then passed = true; break end
                    end
                end
            end
            if passed or not v.key then
                local copy = SEALS.copy_card_but_not(card, v)
                local my_pos, cards = card.rank, card.area and card.area.cards
                if cards then
                    cards[my_pos] = copy
                    copy.rank = my_pos
                end
                local eval = eval_card(copy, context)
                if cards then
                    cards[my_pos] = card
                end
                for k, vv in pairs(eval) do
                    local effects = {g[k]}
                    effects[#effects+1] = vv
                    g[k] = SMODS.merge_effects(effects)
                end
            end
        end
        G.soe_calculating_merged_cards = oldmergedcard
    end
    G.soe_from_eval_card = nil
    return g, post
end

local oldgfuncsdiscardcardsfromhighlighted = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(...)
    if G.GAME and G.GAME.soe_buttonseals and G.GAME.soe_buttonseals.discard then
        local seal = G.GAME.soe_buttonseals.discard
        if seal == 'Gold' then
            ease_dollars(3)
            SEALS.event(function()
                G.STATE = G.STATES.SELECTING_HAND
                return true
            end)
            SEALS.event(function()
                G.STATE = G.STATES.DRAW_TO_HAND
                return true
            end)
        end
    end
    oldgfuncsdiscardcardsfromhighlighted(...)
end

local oldgfuncsplaycardsfromhighlighted = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(...)
    SEALS.event(function()
        SEALS.event(function()
            for _, area in ipairs(SMODS.get_card_areas('jokers')) do
                for _, v in ipairs(sc(area.highlighted)) do
                    if SEALS.has_seal(v, 'soe_negativeseal') then
                        v.soe_from_negative_seal = true
                        SEALS.move_card(v, G.play)
                    end
                end
            end
            return true
        end)
        return true
    end)
    if G.GAME and G.GAME.soe_buttonseals and G.GAME.soe_buttonseals.play then
        local seal = G.GAME.soe_buttonseals.play
        if seal == 'Gold' then
            ease_dollars(3)
        end
    end
    oldgfuncsplaycardsfromhighlighted(...)
end

local oldclick = Card.click
function Card:click()
    oldclick(self)
    if G.GAME.soe_purchasingitems and (self.config.center.set == "Sleeve" or (self.config.center.set == "Default" and self.area and self.area.cards[52] == self) or self.config.center.set == "Partner") and not G.soe_creating_card_during_purchase then
        if (to_big(G.GAME.dollars) + to_big(G.GAME.bankrupt_at)) >= to_big(SEALS.get_cost(self.config.center_key)) then
            SEALS.purchase_key(self.config.center_key)
        end
    end
    if (self.config.center_key == 'v_soe_blueprint' or self.config.center_key == 'v_soe_brainstorm') and self.area and self.area.config.type == 'voucher' and not self.area.config.collection and not (G.blueprintvoucherchoosecardarea and G.blueprintvoucherchoosecardarea.cards and G.blueprintvoucherchoosecardarea.cards[1]) then
        G.SETTINGS.paused = true
        G.ownerofblueprintvoucherchoosecardarea = self.config.center_key
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
            if G.vouchers.cards[i].config.center_key ~= "v_soe_brainstorm" and G.vouchers.cards[i].config.center_key ~= "v_soe_blueprint" and not G.vouchers.cards[i].ability.soe_from_blueprint then
                G.blueprintvoucherchoosecardarea:emplace(SMODS.create_card({set = 'Vouchers', area = G.blueprintvoucherchoosecardarea, key = G.vouchers.cards[i].config.center_key}))
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
    if self.area == G.blueprintvoucherchoosecardarea and self.ability.set == 'Voucher' and G.blueprintvoucherchoosecardarea and G.blueprintvoucherchoosecardarea.cards and G.blueprintvoucherchoosecardarea.cards[1] and self.config.center_key ~= G.ownerofblueprintvoucherchoosecardarea then
        local key = G.ownerofblueprintvoucherchoosecardarea:sub(7)..'vouchertocopy'
        G.GAME['old'..key] = G.GAME[key]
        G.GAME[key] = self.config.center_key
        G.FUNCS.run_info()
        if G.GAME['old'..key] then
            local other_old_voucher
            for _, v in ipairs(G.vouchers.cards) do
                if v.ability.soe_from_blueprint and v.ability.soe_from_blueprint == G.ownerofblueprintvoucherchoosecardarea then
                    other_old_voucher = v
                    break
                end
            end
            if other_old_voucher then
                other_old_voucher:unapply_to_run()
                other_old_voucher:remove()
            end
        end
        G.soe_blueprinting = true
        Card.apply_to_run(nil, self.config.center)
        G.soe_blueprinting = nil
    end
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] or self.config.center_key == 'j_soe_redfabric' then
        self.soe_clicks = (self.soe_clicks or 0)+1
        if self.soe_timer and self.soe_timer > 0 then
            if self.soe_clicks >= 3 then
                self.soe_timer, self.soe_clicks = nil, nil
                G.SETTINGS.paused = true
                G.soe_mergedcardsviewcardarea = CardArea(G.ROOM.T.x+0.2*G.ROOM.T.w/2, G.ROOM.T.h, 5.3*G.CARD_W, 1.03*G.CARD_H, {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
                local merged_cards = {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0, no_fill = true },
                    nodes = {
                        {n = G.UIT.O, config = {object = G.soe_mergedcardsviewcardarea}},
                    },
                }
                if self.config.center_key == 'j_soe_redfabric' then
                    for i=1, #self.ability.extra.jokers do
                        G.soe_creatingmergedcard = true
                        local v = self.ability.extra.jokers[i]
                        G.soe_mergedcardsviewcardarea:emplace(SMODS.create_card({key = v, skip_materialize = true, no_edition = true}))
                        G.soe_creatingmergedcard = nil
                    end
                else
                    local real_card = SEALS.copy_card(self, nil, G.soe_mergedcardsviewcardarea, true)
                    real_card.ability.soe_mergedcards = nil
                    real_card.debuff = nil
                    for i=1, #self.ability.soe_mergedcards do
                        G.soe_creatingmergedcard = true
                        local v = self.ability.soe_mergedcards[i]
                        local t = sc(v)
                        t.set = t.set == 'Playing Card' and 'Base' or t.set
                        t.skip_materialize = true
                        t.no_edition = true
                        t.force_stickers = true
                        local card = SMODS.create_card(t)
                        card.ability = copy_table(SEALS.copy_card_but_not(self, v).ability)
                        G.soe_mergedcardsviewcardarea:emplace(card)
                        G.soe_creatingmergedcard = nil
                    end
                end
                G.UIBOXGENERICOPTIONSMERGEDCARDSVIEW = create_UIBox_generic_options({
                    snap_back = true,
                    contents = {
                        {
                            n = G.UIT.R,
                            config = {align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05},
                            nodes = {merged_cards},
                        },
                    },
                })
                G.FUNCS.overlay_menu({
                    definition = G.UIBOXGENERICOPTIONSMERGEDCARDSVIEW,
                })
            end
        else
            self.soe_timer = 2
            self.soe_clicks = 1
        end
    end
end

function SEALS.perform_operations(val1, op, val2)
    if type(val2) == 'number' then
        if op == '=' then return val2 end
        if op == '+' then return val1 + val2 end
        if op == '-' then return val1 - val2 end
        if op == '*' then return val1 * val2 end
        if op == '/' then return val1 / val2 end
        if op == '%' then return val1 % val2 end
        if op == '^' then return val1 ^ val2 end
    elseif type(val1) == 'number' and type(val2) == 'table' then
        local final = val1
        for _, v in ipairs(val2) do
            final = SEALS.perform_operations(final, op, v)
        end
        return final
    end
end

local oldsmodsgetprobabilityvars = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, ...)
    if is(trigger_obj, Card) then
        local prevprobs, probmod = trigger_obj.ability.soe_previous_probabilities, trigger_obj.ability.soe_probability_modifier
        local id = identifier or 'soe_no_identifier'
        if not prevprobs or not prevprobs[id] then
            prevprobs = {}
            trigger_obj.ability.soe_previous_probabilities = prevprobs
            prevprobs[id] = {numerator = {value = base_numerator}, denominator = {value = base_denominator}}
        end
        local prevprobsid = prevprobs[id]
        if probmod then
            prevprobsid.numerator.changed = base_numerator ~= prevprobsid.numerator.value
            prevprobsid.denominator.changed = base_denominator ~= prevprobsid.denominator.value
            local ops = {'=', '+', '-', '*', '/', '%', '^'}
            for _, v in ipairs(ops) do
                if probmod[v] then
                    for _, vv in ipairs(probmod[v]) do
                        if vv.numerator and not prevprobsid.numerator.changed then
                            base_numerator = SEALS.perform_operations(base_numerator, v, vv.value)
                        end
                        if vv.denominator and not prevprobsid.denominator.changed then
                            base_denominator = SEALS.perform_operations(base_denominator, v, vv.value)
                        end
                    end
                end
            end
        end
    end
    return oldsmodsgetprobabilityvars(trigger_obj, base_numerator, base_denominator, identifier, ...)
end

SEALS.joker_value_exclusions = {
    x_mult = 1,
    x_chips = 1,
    h_size = 0,
    extra_value = true,
    cry_prob = true,
    d_size = 0,
    card_limit = true,
    extra_slots_used = true,
    t_mult = 0,
    t_chips = 0,
    soe_frozen_snapshot = true,
    soe_mergedcards = true,
    soe_quantum_stickers = true,
    soe_probability_modifier = true,
    soe_previous_probabilities = true,
    soe_savedobjectvalues = true
}

if Cryptid then
    local blacklist = Cryptid.misprintize_value_blacklist
    blacklist.soe_frozen_snapshot = false
    blacklist.soe_mergedcards = false
    blacklist.soe_quantum_stickers = false
    blacklist.soe_probability_modifier = false
    blacklist.soe_previous_probabilities = false
    blacklist.soe_savedobjectvalues = false
end

function SEALS.modify_joker_values(card, modifytbl, exclusions, ignoreimmutable, nodeckeffects)
    if not card or not modifytbl or (SEALS.has_edition(card, 'e_soe_frozen') and not card.config.center.soe_frozen_immune) or (card.config.center.immutable and not ignoreimmutable) then return end
    local cardwasindeck = card.added_to_deck
    if not nodeckeffects and cardwasindeck then card:remove_from_deck(true) end
    exclusions = exclusions or SEALS.joker_value_exclusions
    local ops = {'=', '+', '-', '*', '/', '%', '^'}
    local function modify_value(ref_table, ref_value, isdirectlyinability)
		local value = ref_table[ref_value]
        if type(value) == 'table' and (ignoreimmutable or ref_value ~= 'immutable') and (not isdirectlyinability or exclusions[ref_value] ~= true) then
            for k in pairs(value) do
                modify_value(value, k)
            end
        elseif type(value) == 'number' and (not isdirectlyinability or (not (exclusions[ref_value] == true or exclusions[ref_value] == value))) then
            for _, v in ipairs(ops) do
                if modifytbl[v] then
                    ref_table[ref_value] = SEALS.perform_operations(value, v, modifytbl[v])
                end
            end
        end
    end
    card:generate_UIBox_ability_table(true)
    for k in pairs(card.ability) do
        modify_value(card.ability, k, true)
    end
    local probmod = card.ability.soe_probability_modifier or {}
    for _, v in ipairs(ops) do
        if modifytbl[v] then
            probmod[v] = probmod[v] or {}
            probmod[v][#probmod[v]+1] = {value = modifytbl[v], denominator = true, numerator = true}
        end
    end
    card.ability.soe_probability_modifier = probmod
    if not nodeckeffects and cardwasindeck then card:add_to_deck(true) end
end

function SEALS.safe_get(t, ...)
	local current = t
	for _, k in ipairs({...}) do
		if not current or current[k] == nil then
			return
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
    if not mod then return end
    local badges = {}
    SMODS.create_mod_badges({mod = mod}, badges)
    return badges[1]
end

function SEALS.copy_card(card, new_card, area, nodeckeffects)
    if not card then return end
    area = area or card.area or G.jokers
    local cardwasindeck = new_card and new_card.added_to_deck
    local copy = copy_card(card, new_card, nil, card.playing_card and G.playing_card)
    if not nodeckeffects and new_card and cardwasindeck then copy:remove_from_deck() end
    if card.playing_card then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        copy.playing_card = G.playing_card
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        G.playing_cards[#G.playing_cards+1] = copy
    end
    if not nodeckeffects and ((new_card and cardwasindeck) or not new_card) then copy:add_to_deck() end
    if not new_card then area:emplace(copy) end
    return copy
end

function SEALS.move_card(card, area)
    if not card or not area then return end
    card.soe_moving_card = true
    if card.area then
        card.area:remove_card(card)
    end
    area:emplace(card)
    card.soe_moving_card = nil
    return card
end

function SEALS.forcetriggerseals(card)
    if not card then return end
    local context = {main_scoring = true, cardarea = G.play, discard = true, pre_discard = true, full_hand = G.play.cards, scoring_hand = G.soe_scoring_hand or {}, scoring_name = G.soe_scoring_name or 'High Card', poker_hands = {}, destroying_card = card, destroy_card = card, forcetrigger = true}
	for _, v in ipairs(G.handlist) do
        context.poker_hands[v] = {context.scoring_hand}
	end
    local effects = {}
    local old_seal = card.seal
    card.drawseal = old_seal or 'none'
    local old_ability_seal = copy_table(card.ability.seal)
    card:add_sticker('soe_epsilon', true)
    for i, v in ipairs(SEALS.get_seals(card)) do
        if SEALS.get_seals(card, true)[1] and i > 1 and card.seal ~= v then
            card.seal = v
            card.ability.seal = {}
            local config = G.P_SEALS[v].config
            if config then
                for k, v in pairs(config) do
                    card.ability.seal[k] = copy_table(v)
                end
            end
        end
        local eval
        if G.P_SEALS[v].forcetrigger then
            eval = G.P_SEALS[v]:forcetrigger(card)
            goto skip
        end
        if SEALS.is_in_area(card, 'playing_cards') and (v == 'Gold' or v == 'Blue') then
            eval = SEALS.calculate_hardcoded_seals(card, context, v)
        elseif v == 'Purple' then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card({set = 'Tarot', key_append = '8ba'})
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            eval = {message = localize('k_plus_tarot'), colour = G.C.PURPLE}
        else
            eval = card:calculate_seal(context)
        end
        ::skip::
        effects[#effects+1] = eval
    end
    card:remove_sticker('soe_epsilon')
    card.will_shatter = nil
    card.seal = old_seal
    card.drawseal = nil
    card.ability.seal = old_ability_seal
    return effects
end

function SEALS.add_metatable(table, metatable)
    local getmt, setmt
    if type(table) == 'table' then
        getmt, setmt = getmetatable, setmetatable
    else
        getmt, setmt = debug.getmetatable, debug.setmetatable
    end
    local oldmetatable = getmt(table)
    if not oldmetatable or not next(oldmetatable) then return setmt(table, metatable) end
    local anymatches
    for k in pairs(oldmetatable) do
        if metatable[k] then
            anymatches = true
            break
        end
    end
    if not anymatches then
        for k, v in pairs(oldmetatable) do
            metatable[k] = v
        end
        return setmt(table, metatable)
    end
    local newmetatable = {}
    for k, v in pairs(metatable) do
        if oldmetatable[k] then
            if k ~= '__index' then
                newmetatable[k] = function(...)
                    local g = metatable[k](...)
                    if g ~= nil then return g end
                    return oldmetatable[k](...)
                end
            else
                newmetatable[k] = function(t, kk, ...)
                    local g
                    if type(v) == 'table' then
                        g = v[kk]
                    else
                        g = v(t, kk, ...)
                    end
                    if g ~= nil then return g end
                    if type(oldmetatable[k]) == 'table' then
                        return oldmetatable[k][kk]
                    else
                        return oldmetatable[k](t, kk, ...)
                    end
                end
            end
        else
            newmetatable[k] = v
        end
    end
    return setmt(table, newmetatable)
end

--[[
function SEALS.modify_value_for_saving(value, seen)
    if type(value) == 'function' then
        local new_function = {}
        local info = debug.getinfo(value)
        local words = {}
        for word in info.short_src:gmatch('%S+') do words[#words+1] = word end
        local path = SMODS.MODS_DIR..'/lovely/dump/'..((SMODS.Mods[words[2]]--[[ or words[2] == '_') and 'SMODS/' or '')..((SMODS.Mods[words[2]]--[[ or words[2] == '_') and words[2] or info.short_src)..(SMODS.Mods[words[2]]--[[ and ('/'..words[3]:sub(2, -3)) or '')
        if words[2] == '_' then words[2] = 'Steamodded' end
        if not NFS.getInfo(path) then if SMODS.Mods[words[2]]--[[ then path = SMODS.Mods[words[2]]--[[.path..words[3]:sub(2, -3) else return end end
        local i, text = 0, {}
        local lines = NFS.lines(path)
        if not lines then return end
        for line in lines do
            i = i + 1
            if i >= info.linedefined then text[#text+1] = line end
            if i >= info.lastlinedefined-1 then break end
        end
        words = {}
        for word in text[1]:match('%((.-)%)'):gmatch('[^,]+') do words[#words+1] = word:match('^%s*(.-)%s*$') end
        if text[1]:find(':') then table.insert(words, 1, 'self') end
        table.remove(text, 1)
        new_function.soe_function = table.concat(text, '\n')
        new_function.soe_function_args = words
        return new_function
    elseif type(value) == 'table' then
        local mt, depth, new_mt = getmetatable(value), seen and seen.depth or 1, {}
        local true_seen = seen and seen.seen or (mt and {[mt] = depth} or {})
        if not mt then goto skip_metatable end
        if mt == value then mt = 'soe_metatable_self' goto skip_metatable end
        for k, v in pairs(mt) do
            if type(v) == 'table' then
                if true_seen[v] then
                    new_mt[k] = 'soe_metatable_self_depth_'..true_seen[v]
                elseif v == value then
                    new_mt[k] = 'soe_metatable_true_self'
                else
                    true_seen[v] = depth+1
                    new_mt[k] = SEALS.modify_value_for_saving(v, {seen = true_seen, depth = depth+1})
                end
            elseif type(v) == 'function' or type(v) == 'userdata' then
                new_mt[k] = SEALS.modify_value_for_saving(v)
            else
                new_mt[k] = v
            end
            true_seen = seen and seen.seen or {[mt] = depth}
        end
        ::skip_metatable::
        local new_table = {}
        true_seen = seen and seen.seen or {[value] = depth}
        for k, v in pairs(value) do
            if rawget(value, k) then
                if type(v) == 'table' then
                    if true_seen[v] then
                        new_table[k] = 'soe_table_self_depth_'..true_seen[v]
                    else
                        true_seen[v] = depth+1
                        new_table[k] = SEALS.modify_value_for_saving(v, {seen = true_seen, depth = depth+1})
                    end
                elseif type(v) == 'function' or type(v) == 'userdata' then
                    new_table[k] = SEALS.modify_value_for_saving(v)
                else
                    new_table[k] = v
                end
                true_seen = seen and seen.seen or {[value] = depth}
            end
        end
        if mt then new_table.soe_metatable = new_mt end
        return new_table
    elseif type(value) == 'userdata' then
        return {soe_userdata = serializeLOVEObj(value)}
    else
        return value
    end
end

function SEALS.load_modified_saved_value(value, seen)
    if type(value) == 'table' then
        if value.soe_function then
            local func = 'return function('..table.concat(value.soe_function_args, ', ')..') '..value.soe_function..' end'
            return load(func)()
        elseif value.soe_userdata then
            return deserializeLOVEObj(value.soe_userdata)
        else
            local mt, new_mt, new_table, depth = value.soe_metatable, {}, {}, seen and seen.depth or 1
            local true_seen = seen and seen.seen or (mt and {[depth] = mt} or {})
            if not mt then goto skip_metatable end
            if mt == 'soe_metatable_self' then new_mt = new_table goto skip_metatable end
            for k, v in pairs(mt) do
                if type(v) == 'table' then
                    true_seen[depth+1] = v
                    new_mt[k] = SEALS.load_modified_saved_value(v, {seen = true_seen, depth = depth+1})
                elseif type(v) == 'string' then
                    local identifier = v:gsub('%d+$', '')
                    local true_depth = tonumber(v:match("(%d+)$"))
                    if identifier == 'soe_metatable_self_depth_' then
                        new_mt[k] = true_seen[true_depth]
                    elseif identifier == 'soe_metatable_true_self' then
                        new_mt[k] = new_table
                    end
                else
                    new_mt[k] = v
                end
                true_seen = seen and seen.seen or {[depth] = mt}
            end
            ::skip_metatable::
            true_seen = seen and seen.seen or {[depth] = value}
            for k, v in pairs(value) do
                if type(v) == 'table' then
                    true_seen[depth+1] = v
                    new_table[k] = SEALS.load_modified_saved_value(v, {seen = true_seen, depth = depth+1})
                elseif type(v) == 'string' then
                    local identifier = v:gsub('%d+$', '')
                    local true_depth = tonumber(v:match("(%d+)$"))
                    if identifier == 'soe_table_self_depth_' then
                        new_table[k] = true_seen[true_depth]
                    end
                else
                    new_table[k] = v
                end
                true_seen = seen and seen.seen or {[depth] = value}
            end
            if mt then setmetatable(new_table, new_mt) end
            return new_table
        end
    else
        return value
    end
end
]]

function SEALS.check_deck(key, both)
    local deck = G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and G.GAME.selected_back.effect.center.key == 'b_soe_'..key or key ~= 'true' and SEALS.check_deck('true')
    local sleeve = G.GAME and G.GAME.selected_sleeve == 'sleeve_soe_'..key or key ~= 'true' and SEALS.check_deck('true')
    if both == nil then return deck or sleeve end
    if both == false then return (deck and not sleeve) or (not deck and sleeve) end
    return deck and sleeve
end

--[[
function SEALS.combine_names(name1, name2)
    if (name1 == 'Photograph' and name2 == 'Hanging Chad') or (name1 == 'Hanging Chad' and name2 == 'Photograph') then
        return "Photochad"
    end
    local words1, words2 = {}, {}
    for word in name1:gmatch('%S+') do
        words1[#words1+1] = word
    end
    for word in name2:gmatch('%S+') do
        words2[#words2+1] = word
    end
end

function SEALS.combine_effects(keys)
    local result = {}
    local result_keys = {'first', 'played', 'face', 'scoring', 'in_hand', 'retriggers', 'end_of_round', 'destroy_self', 'card_destroyed', 'ranks', 'suits', 'poker_hands', 'mult', 'xmult', 'chips', 'xchips', 'chance'}
    for i, v in ipairs(keys) do
        result[i] = {}
        local center = G.P_CENTERS[v]
        local ability = copy_table(center.config)
        ability.set = 'Joker'
        ability.name = center.name
        ability.x_mult = center.config.Xmult or center.config.x_mult
        if ability.name == 'To Do List' then
            ability.to_do_poker_hand = "High Card" -- fallback
        end
        local s = table.concat(localize({type = 'raw_descriptions', key = v, set = 'Joker', vars = Card.generate_UIBox_ability_table({ability = ability, config = {center = center}, bypass_lock = true}, true)}), ' '):lower()
        if s:find("first") then result[i].first = true end
        if s:find("played") then result[i].played = true end
        if s:find("face") then result[i].face = true end
        if s:find("when scored") or s:find("per scoring") then result[i].scoring = true end
        if s:find("in hand") then result[i].in_hand = true end
        if s:find("retrigger all") or s:find("retrigger each") then result[i].retriggers = 1 end
        if s:find("end of round") then result[i].end_of_round = true end
        if s:find("is destroyed") then
            if s:find("this card is destroyed") or s:find("self destruct") then
                result[i].destroy_self = true
            else
                result[i].card_destroyed = true
            end
        end
        if s:find("copies ability") or s:find("copies the ability") then
            if s:find('leftmost') then
                result[i].blueprint = 1
            else
                result[i].blueprint = 'card.rank+1'
            end
        end
        for _, v in ipairs(SMODS.Rank.obj_buffer) do
            local rank = SMODS.Ranks[v]
            local is_face
            if v == 'Ace' then
                local a, b = s:find('ace')
                if a then
                    is_face = s:sub(a-1, b) == 'face'
                end
            end
            if s:find(localize(v, 'ranks'):lower()) and not is_face then
                result[i].ranks = result[i].ranks or {}
                result[i].ranks[#result[i].ranks+1] = rank.id
            end
        end
        for _, v in ipairs(SMODS.Suit.obj_buffer) do
            local suit = SMODS.Suits[v]
            if s:find(localize(v, 'suits_plural'):lower()) or s:find(localize(v, 'suits_singular'):lower()) then
                result[i].suits = result[i].suits or {}
                result[i].suits[#result[i].suits+1] = suit.key
            end
        end
        for _, v in ipairs(G.handlist) do
            local hand = SMODS.PokerHands[v]
            if s:find(localize(v, 'poker_hands'):lower()) then
                result[i].poker_hands = result[i].poker_hands or {}
                result[i].poker_hands[#result[i].poker_hands+1] = hand.key
            end
        end
        result[i].mult = tonumber(s:match("+(%d+)%s*mult"))
        result[i].xmult = tonumber(s:match("x(%d+)%s*mult"))
        result[i].chips = tonumber(s:match("+(%d+)%s*chips"))
        result[i].xchips = tonumber(s:match("x(%d+)%s*chips"))
        local numerator, denominator = s:match("(%d+)%s+in%s+(%d+)%s+chance")
        if numerator and denominator then
            result[i].chance = {numerator = tonumber(numerator), denominator = tonumber(denominator)}
        end
    end
    local final_result = copy_table(result[1])
    --[[
    for i, v in ipairs(result_keys) do
        if result[1][v] and result[2][v] then
            final_result[v] = result[pseudorandom('soe_combine_effects', 1, 2)][v]
        else
            final_result[v] = result[1][v] or result[2][v]
        end
    end
    ]]--[[
    for k, v in pairs(result[2]) do
        final_result[k] = v
    end
    local f = final_result
    f.individual = not f.retriggers and (f.played or f.face or f.in_hand or f.scoring)
    f.has_scoring_values = (f.mult or f.xmult or f.chips or f.xchips and true) or nil
    local stringfunc = string.format([[
        return function(_, card, context)
            local effects = {}
            local blueprint = %s
            if blueprint then
                local other_card = card.area.cards[blueprint]
                if other_card then
                    effects[#effects+1] = SMODS.blueprint_effect(card, other_card, context)
                end
            end
            if %s and context.cardarea == %s and %s then
                local other_card = %s or context.other_card
                if context.other_card == other_card and (%s or SEALS.is_ids(other_card, %s)) and (%s or SEALS.is_suits(other_card, %s)) then
                    effects[#effects+1] = %s
                end
            end
            if effects[1] then
                return SMODS.merge_effects(effects)
            end
        end
    ]]--[[,
    f.blueprint or nil,
    (f.individual and 'context.individual') or (f.retriggers and 'context.repetition') or 'nil',
    (f.played and ((f.scoring and 'G.play') or '\'unscored\'')) or (f.in_hand and 'G.hand'),
    (f.end_of_round and 'context.end_of_round') or 'true',
    (f.first and ((f.face and "(function() for i, v in ipairs(context."..((f.scoring and 'scoring') or 'full')..'_hand) do if v:is_face() then return v end end end)()') or ("context."..((f.scoring and "scoring") or "full").."_hand[1]"))) or nil,
    (f.ranks and f.ranks[1] and 'false') or 'true',
    '{'..table.concat(f.ranks or {}, ', ')..'}',
    (f.suits and f.suits[1] and 'false') or 'true',
    '{'..table.concat(f.suits or {}, ', ')..'}',
    (f.retriggers and f.retriggers > 0 and string.format("{repetitions = %s}", f.retriggers)) or (f.has_scoring_values and string.format('{mult = %s, xmult = %s, chips = %s, xchips = %s}', f.mult or nil, f.xmult or nil, f.chips or nil, f.xchips or nil)) or 'nil')
    print(stringfunc)
    local func, err = load(stringfunc)
    if func then
        local ok, calculate = pcall(func)
        if ok then
            return calculate
        else
            error(calculate)
        end
    else
        error(err)
    end
end
]]

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

for _, v in ipairs({G.P_CENTERS, SMODS.Centers}) do
    for _, vv in pairs(v) do
        if vv.set == 'Enhanced' then
            if (vv.replace_base_card and vv.mod ~= SEALS) or vv.key == 'm_stone' then
                SMODS.Joker {
                    key = (vv.key == 'm_stone' and 'stone' or vv.original_key or vv.key)..'cardjoker',
                    atlas = vv.key == 'm_stone' and 'soe_EnhancementsForJokers' or vv.atlas,
                    prefix_config = {atlas = false},
                    pos = vv.key == 'm_stone' and {x = 4, y = 0} or vv.pos,
                    rarity = 3,
                    cost = 10,
                    unlocked = true,
                    discovered = true,
                    blueprint_compat = true,
                    eternal_compat = true,
                    perishable_compat = true,
                    no_collection = true,
                    soe_is_enhancement_joker = true,
                    soe_enhancement_mod = vv.original_mod,
                    soe_enhancement_key = vv.key,
                    config = vv.key == 'm_stone' and {
                        chips = 100
                    } or vv.config or nil,
                    loc_txt = {
                        name =  ((not vv.original_mod) and localize({type = 'name_text', key = vv.key, set = 'Enhanced'})..' Joker') or '',
                        text = ((not vv.original_mod) and (G.localization.descriptions.Enhanced[vv.key] or {}).text) or {''},
                    },
                    loc_vars = vv.key == 'm_stone' and function(_, _, card)
                        return {vars = {card.ability.chips}}
                    end or vv.loc_vars or nil,
                    add_to_deck = function(_, card)
                        G.soe_initial_adding = true
                        SEALS.set_joker_enhancement(card, vv)
                        G.soe_initial_adding = nil
                    end,
                    in_pool = function()
                        return false
                    end,
                    set_badges = function(_, _, badges)
                        if vv.mod ~= SEALS then
                            badges[#badges+1] = SEALS.create_mod_badge(vv.mod)
                        end
                    end
                }
            end
        elseif vv.set == 'Voucher' then
            SMODS.Enhancement{
                key = vv.key,
                loc_txt = {
                    name = ((not vv.original_mod) and localize({type = 'name_text', key = vv.key, set = 'Voucher'})) or '',
                    text = ((not vv.original_mod) and (G.localization.descriptions.Voucher[vv.key] or {}).text) or {''},
                },
                loc_vars = (not vv.original_mod and function()
                    local ability = copy_table(vv.config)
                    ability.name = vv.name
                    local loc_vars, main_start, main_end = Card.generate_UIBox_ability_table({ability = ability, config = {center = vv}}, true)
                    return {vars = loc_vars, main_start = main_start, main_end = main_end}
                end) or vv.loc_vars or nil,
                atlas = vv.atlas or 'Voucher',
                vouchershader = true,
                prefix_config = {atlas = false},
                no_collection = true,
                soe_is_voucher_enhancement = true,
                soe_voucher_mod = vv.mod,
                soe_voucher_key = vv.key,
                pos = vv.pos,
                config = vv.config,
                replace_base_card = true,
                always_scores = true,
                no_suit = true,
                no_rank = true,
                calculate = function(_, _, context)
                    if context.main_scoring and context.cardarea == G.play then
                        return {message = localize('k_redeemed_ex'), func = function()
                            Card.apply_to_run(nil, vv)
                        end}
                    end
                end,
                in_pool = function()
                    return false
                end
            }
        end
    end
end

function SEALS.set_joker_enhancement(card, center)
    if not card or not center then return end
    if type(center) == 'string' then
        assert(G.P_CENTERS[center], ("Could not find center \"%s\""):format(center))
        center = G.P_CENTERS[center]
    end
    if not G.soe_initial_adding and (center.replace_base_card or center.key == 'm_stone') then card:set_ability('j_soe_'..(center.key == 'm_stone' and 'stone' or center.original_key or center.key)..'cardjoker') end
    card.ability.soe_legalenhancements = card.ability.soe_legalenhancements or {}
    card.ability.soe_legalenhancements[center.key] = card.ability.soe_legalenhancements[center.key] or {}
    if SMODS.find_card('j_soe_sealjoker2')[1] then
        card.ability.soe_legalenhancements[center.key][#card.ability.soe_legalenhancements[center.key]+1] = {}
    else
        card.ability.soe_legalenhancements[center.key][1] = {}
    end
    local current = (SMODS.find_card('j_soe_sealjoker2')[1] and card.ability.soe_legalenhancements[center.key][#card.ability.soe_legalenhancements[center.key]]) or card.ability.soe_legalenhancements[center.key][1]
    current.config = copy_table(center.config)
    current.mod = center.mod and center.mod.id
end

function SEALS.get_joker_enhancements(card)
    local enhancements = copy_table(card.ability.soe_legalenhancements) or {}
    if SEALS.counts_as_everything(card) then
        local counts = {}
        for k, v in pairs(enhancements) do
            if v[1] then
                counts[k] = true
            end
        end
        for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
            local k = v.key
            if not counts[k] then
                enhancements[k] = enhancements[k] or {}
                enhancements[k][#enhancements[k]+1] = {config = copy_table(v.config), mod = v.mod and v.mod.id}
            end
        end
    end
    return enhancements
end

function SEALS.calculate_joker_enhancements(card, context)
    local enhancements = SEALS.get_joker_enhancements(card)
    if not card or not next(enhancements) then return end
    local other_context = sc(context)
    other_context.main_scoring = context.joker_main
    other_context.destroy_card = context.after and card
    other_context.playing_card_end_of_round = context.end_of_round
    local effects = {}
    for k, v in pairs(enhancements) do
        for _=1, #v do
            local enhancement
            local areas, i = {G.play, G.hand}, 1
            repeat
                other_context.cardarea = areas[i]
                local true_effects = {}
                SEALS.calculate_quantum_enhancements(card, true_effects, other_context, k)
                local eval = true_effects[1]
                if eval then
                    local other_effects = {}
                    if eval.playing_card then other_effects[#other_effects+1] = eval.playing_card end
                    if eval.enhancement then other_effects[#other_effects+1] = eval.enhancement end
                    if eval.end_of_round then other_effects[#other_effects+1] = eval.end_of_round end
                    enhancement = SMODS.merge_effects(other_effects)
                end
                i=i+1
            until enhancement or not areas[i]
            if enhancement then
                if other_context.destroy_card and enhancement.remove then
                    effects[#effects+1] = {func = function()
                        local oldsmodsshatters = SMODS.shatters
                        function SMODS.shatters(card2)
                            if card2 == card and (G.P_CENTERS[k].shatters or k == 'm_glass') then return true end
                            return oldsmodsshatters(card)
                        end
                        SMODS.destroy_cards(card)
                        SMODS.shatters = oldsmodsshatters
                    end}
                else
                    effects[#effects+1] = enhancement
                end
            end
        end
    end
    return SMODS.merge_effects(effects)
end

function SEALS.copy_card_but_not(card, key, extra, temp)
    if type(key) == 'table' and not extra then extra = key; key = extra.key end
    local copy
    if not extra then
        local soe_savedobjects = card.soe_savedobjects or {}
        card.soe_savedobjects = soe_savedobjects
        local soe_cachedsavedobjects = G.soe_cachedsavedobjects
        if not soe_savedobjects[key] then
            if not soe_cachedsavedobjects[key] then
                copy = sc(card)
                soe_savedobjects[key] = copy
                copy.ability = {immutable = Yorick and {yorick_amount = 1} or nil}
                copy.config = sc(copy.config)
                local func = function() return sc(copy.children) end
                copy.children = setmetatable({}, {__newindex = emptyfunc, __call = func, __index = func})
                local center = G.P_CENTERS[key] or G.P_SEALS[key] or SMODS.Stickers[key]
                if center.set ~= 'Edition' and center.set ~= 'Seal' and center.set ~= 'Sticker' then SEALS.safe_set_ability(copy, center) end
                if center.set == 'Joker' then
                    copy.playing_card = nil
                end
                copy.soe_shallow_copied_card = true
                copy.soe_realcard = card
                copy.added_to_deck = nil
                if copy.base.id then
                    copy:set_base({}, true, true)
                end
                if center.set == 'Seal' then
                    copy.seal = key
                    copy.ability.seal = {}
                    local config = center.config
                    if config then
                        for k, v in pairs(config) do
                            card.ability.seal[k] = copy_table(v)
                        end
                    end
                else
                    copy.seal = nil
                end
                if center.set == 'Edition' then
                    local edition = {
                        [key:sub(3)] = true,
                        type = key:sub(3),
                        key = key
                    }
                    for k, v in pairs(center.config) do
                        edition[k] = copy_table(v)
                    end
                    copy.edition = edition
                elseif card.edition and card.edition.key == 'e_soe_frozen' then
                    copy:set_edition('e_soe_frozen', true, true)
                else
                    copy.edition = nil
                end
                for _, v in ipairs(SMODS.Sticker.obj_buffer) do
                    if v ~= 'akyrs_concealed' then
                        SMODS.Stickers[v]:apply(copy)
                        if v == key then SMODS.Stickers[v]:apply(copy, true) end
                    end
                end
                copy.juice_up = function(_, ...) card:juice_up(...) end
                copy.start_dissolve = function(_, ...) card:start_dissolve(...) end
                copy.remove = function(_, ...) card:remove(...) end
                copy.flip = function(_, ...) card:flip(...) end
                if not temp then
                    local other_copy = sc(copy)
                    soe_cachedsavedobjects[key] = other_copy
                    other_copy.ability = copy_table(other_copy.ability)
                end
            else
                copy = sc(soe_cachedsavedobjects[key])
                soe_savedobjects[key] = copy
                copy.ability = copy_table(copy.ability)
                copy.soe_realcard = card
                copy.juice_up = function(_, ...) card:juice_up(...) end
                copy.start_dissolve = function(_, ...) card:start_dissolve(...) end
                copy.remove = function(_, ...) card:remove(...) end
                copy.flip = function(_, ...) card:flip(...) end
            end
        else
            copy = soe_savedobjects[key]
        end
        if temp then
            soe_savedobjects[key] = nil
        end
        copy.ability.cry_rigged = card.ability.cry_rigged
    elseif type(extra) == 'table' then
        local soe_savedfractionedcards = card.soe_savedfractionedcards or {}
        card.soe_savedfractionedcards = soe_savedfractionedcards
        local newkey = (extra.seal or '')..(extra.enhancement or '')..(extra.edition or '')..table.concat(extra.stickers or {}, '')..(extra.suit or '')..(extra.rank or '')..(key or '')
        if not soe_savedfractionedcards[newkey] then
            copy = sc(card)
            soe_savedfractionedcards[newkey] = copy
            copy.config = sc(copy.config)
            local func = function(t) return sc(t) end
            copy.children = setmetatable({}, {__newindex = emptyfunc, __call = func, __index = func})
            if extra.ability then
                local truekey = key or extra.enhancement or 'c_base'
                copy.ability = extra.ability
                copy.config.center = G.P_CENTERS[truekey]
                copy.config.center_key = truekey
            else
                copy.ability = {}
                SEALS.safe_set_ability(copy, G.P_CENTERS[key or extra.enhancement or 'c_base'])
            end
            if not extra.rank then
                copy.playing_card = nil
            end
            copy.soe_shallow_copied_card = true
            copy.soe_realcard = card
            copy.added_to_deck = nil
            if extra.suit and extra.rank then
                copy:set_base((G.P_CARDS[SMODS.Suits[extra.suit].card_key..'_'..SMODS.Ranks[extra.rank].card_key]), true, true)
            elseif copy.base.id then
                copy:set_base({}, true, true)
            end
            copy.seal = nil
            if extra.seal then
                copy:set_seal(extra.seal, true, true)
            end
            copy.edition = nil
            if extra.edition then
                copy:set_edition(extra.edition, true, true)
            end
            for _, v in ipairs(SMODS.Sticker.obj_buffer) do
                if v ~= 'akyrs_concealed' then
                    SMODS.Stickers[v]:apply(copy)
                end
            end
            if extra.stickers and extra.stickers[1] then
                for _, v in ipairs(extra.stickers) do
                    SMODS.Stickers[v]:apply(copy, true)
                end
            end
            copy.juice_up = function(_, ...) card:juice_up(...) end
            copy.start_dissolve = function(_, ...) card:start_dissolve(...) end
            copy.remove = function(_, ...) card:remove(...) end
            copy.flip = function(_, ...) card:flip(...) end
        else
            copy = soe_savedfractionedcards[newkey]
        end
        if temp then
            soe_savedfractionedcards[newkey] = nil
        end
    end
    copy:update(G.real_dt or 0.016)
    return copy
end

local oldcardevalstatustext = card_eval_status_text
function card_eval_status_text(card, a, b, c, d, extra)
    if card.soe_realcard then
        if extra then extra.focus = nil end
        return oldcardevalstatustext(card.soe_realcard, a, b, c, d, extra)
    elseif G.soe_truer_card and G.soe_truer_card[card] then
        if extra then extra.focus = nil end
        return oldcardevalstatustext(G.soe_truer_card[card], a, b, c, d, extra)
    end
    return oldcardevalstatustext(card, a, b, c, d, extra)
end

local oldsmodsfindcard = SMODS.find_card
function SMODS.find_card(key, count_debuffed)
    local g = oldsmodsfindcard(key, count_debuffed)
    if not G.jokers or not G.jokers.cards then return g end
    if key == 'j_soe_sealjoker2' and SEALS.config.permanentseal2effect then return {''} end
    for _, area in ipairs(SMODS.get_card_areas('jokers')) do
        if area.cards then
            for _, v in ipairs(area.cards) do
                if (count_debuffed or not v.debuff) then
                    local jokers = SEALS.get_quantum_jokers(v)
                    if jokers[1] then
                        for _, vv in ipairs(jokers) do
                            if vv == key then
                                g[#g+1] = SEALS.copy_card_but_not(v, vv)
                                break
                            end
                        end
                    end
                    if v.ability.soe_mergedcards and v.ability.soe_mergedcards[1] then
                        for _, vv in ipairs(v.ability.soe_mergedcards) do
                            if vv.key == key then
                                g[#g+1] = SEALS.copy_card_but_not(v, vv)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    return g
end

local oldfindjoker = find_joker
function find_joker(name, non_debuff)
    local g = oldfindjoker(name, non_debuff)
    if not G.jokers or not G.jokers.cards then return g end
    for _, area in ipairs({G.jokers, G.consumeables}) do
        if area.cards then
            for _, v in ipairs(area.cards) do
                if (non_debuff or not v.debuff) then
                    local jokers = SEALS.get_quantum_jokers(v)
                    if jokers[1] then
                        for _, vv in ipairs(jokers) do
                            if G.P_CENTERS[vv].name == name then
                                g[#g+1] = SEALS.copy_card_but_not(v, vv)
                                break
                            end
                        end
                    end
                    if v.ability.soe_mergedcards and v.ability.soe_mergedcards[1] then
                        for _, vv in ipairs(v.ability.soe_mergedcards) do
                            if v.key and G.P_CENTERS[vv.key].name == name then
                                g[#g+1] = SEALS.copy_card_but_not(v, vv)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    return g
end

function SEALS.calculate_joker_seals(card, context)
    if not card.ability.soe_jokerseals or not card.ability.soe_jokerseals[1] then return end
    if context.main_scoring and context.cardarea == G.play and SEALS.is_in_area(card, 'playing_cards') then
        return SEALS.calculate_joker_as_playing_card(card, context, card.ability.soe_jokerseals)
    else
        return SEALS.calculate_quantum_jokers(card, context, card.ability.soe_jokerseals)
    end
end

function SEALS.calculate_joker_as_playing_card(card, context, quantum)
    local other_context = sc(context)
    other_context.cardarea = G.jokers
    other_context.main_eval = true
    other_context.main_scoring = nil
    other_context.joker_main = true
    local effects, other_jokers = {}, type(quantum) == 'table' and quantum
    if quantum then
        local effect = SEALS.calculate_quantum_jokers(card, other_context, other_jokers)
        local dollars = {}
        for _, v in pairs(other_jokers or SEALS.get_quantum_jokers(card)) do
            local other_dollars = SEALS.copy_card_but_not(card, v):calculate_dollar_bonus()
            if other_dollars then
                dollars[#dollars+1] = {dollars = other_dollars}
            end
        end
        effects[#effects+1] = effect
        effects[#effects+1] = SMODS.merge_effects(dollars)
    else
        local effect = card:calculate_joker(other_context)
        local dollars = card:calculate_dollar_bonus()
        effects[#effects+1] = effect
        if dollars then
            effects[#effects+1] = {dollars = dollars}
        end
    end
    other_context.joker_main = nil
    other_context.individual = true
    other_context.main_eval = nil
    for _, vv in ipairs(SMODS.get_card_areas('playing_cards')) do
        for _, vvv in ipairs(vv.cards) do
            other_context.cardarea = SEALS.check_deck('inverse') and vv == G.hand and G.play or vv == G.play and not SMODS.in_scoring(vvv, context.scoring_hand) and 'unscored' or vv
            other_context.other_card = vvv
            local reps, j = {1}, 1
            while j <= #reps do
                if reps[j] ~= 1 then
                    local eff = sc(reps[j].retriggers)
                    eff.soe_true_card = eff.card
                    while eff.retrigger_flag do
                        effects[#effects+1] = eff; j = j+1; eff = sc(reps[j].retriggers)
                    end
                    effects[#effects+1] = eff
                    percent = percent + percent_delta
                end
                local effect
                if quantum then
                    effect = SEALS.calculate_quantum_jokers(card, other_context, other_jokers)
                else
                    effect = card:calculate_joker(other_context)
                end
                if effect then
                    effect.juice_card = card
                    effect.message_card = vvv
                    effects[#effects+1] = effect
                    if reps[j] == 1 then
                        other_context.individual = nil
                        other_context.repetition = true
                        other_context.card_effects = {{}, {jokers = effect}}
                        SMODS.calculate_repetitions(vvv, other_context, reps)
                        other_context.repetition = nil
                        other_context.card_effects = nil
                        other_context.individual = true
                    end
                    j = j + 1
                else
                    j = j + #reps
                end
            end
        end
    end
    other_context.main_eval = true
    other_context.individual = nil
    other_context.other_card = nil
    other_context.cardarea = G.jokers
    for _, vv in ipairs(SMODS.get_card_areas('jokers')) do
        for _, vvv in ipairs(vv.cards) do
            other_context['other_'..(vvv.ability.consumeable and 'consumeable' or vvv.ability.set:lower() or 'joker')] = vvv
            other_context.other_main = vvv
            local effect = card:calculate_joker(other_context)
            if effect then
                effect.juice_card = card
                effect.message_card = vvv
                effects[#effects+1] = effect
            end
        end
    end
    return SMODS.merge_effects(effects)
end

function SEALS.merge_cards(card1, cards, instant, nodeckeffects)
    card1.ability.soe_mergedcards = card1.ability.soe_mergedcards or {}
    for _, card in ipairs(cards) do
        local mergedcard = {
            key = not (card.config.center.set == 'Enhanced' or card.config.center.set == 'Default') and card.config.center_key or nil,
            enhancement = card.config.center.set == 'Enhanced' and card.config.center_key or nil,
            set = (card.config.center.set == 'Enhanced' or card.config.center.set == 'Default') and 'Playing Card' or card.config.center.set,
            rank = card.base.value,
            suit = card.base.suit,
            seal = card.seal,
            edition = card.edition and card.edition.key or nil,
            stickers = {},
            ability = copy_table(card.ability)
        }
        card1.ability.soe_mergedcards[#card1.ability.soe_mergedcards+1] = mergedcard
        for _, v in ipairs(SMODS.Sticker.obj_buffer) do
            if card.ability[v] and v ~= 'akyrs_concealed' then
                mergedcard.stickers[#mergedcard.stickers+1] = v
            end
        end
        if card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] then
            for _, v in ipairs(card.ability.soe_mergedcards) do
                card1.ability.soe_mergedcards[#card1.ability.soe_mergedcards+1] = copy_table(v)
            end
        end
        if instant then
            card:remove()
        else
            card:start_dissolve()
        end
        if mergedcard.key and not nodeckeffects then
            SEALS.copy_card_but_not(card1, mergedcard.key, mergedcard):add_to_deck()
        end
    end
    card1:set_cost()
end

function SEALS.get_line_range_from_file(path, linestart, lineend)
    local i, text = 0, {}
    for line in NFS.lines(path) do
        i = i + 1
        if i >= linestart then text[#text+1] = line end
        if i >= lineend then break end
    end
    return text
end

function SEALS.get_line_from_function(func)
    local info = debug.getinfo(func, 'Sl')
    local loader, modid, path = info.source:match("=%[(.+) (.+) \"(.+)\"%]")
    local fullpath
    if not modid then fullpath = SMODS.MODS_DIR..'/lovely/game-dump/'..info.source:gsub('^@', '') else
    fullpath = SMODS.MODS_DIR..'/lovely/game-dump/'..loader..'/'..modid..'/'..path
    if not NFS.getInfo(fullpath) then fullpath = SMODS.Mods[modid].path..path end end
    if not NFS.getInfo(fullpath) then return end
    return SEALS.get_line_range_from_file(fullpath, info.currentline, info.currentline)[1]
end

--[[
function SEALS.fix_id(func)
    local line = SEALS.get_line_from_function(func)
    if not line then return end
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
    loc_vars = function()
        return {vars = {true_localize({type = 'name_text', set = 'Voucher', key = G.GAME.blueprintvouchertocopy}) or 'Nothing'}}
    end,
    calculate = function(_, card, context)
        if G.GAME.blueprintvouchertocopy then
            local other_voucher
            for _, v in ipairs(G.vouchers.cards) do
                if v.config.center_key == G.GAME.blueprintvouchertocopy then
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
    pos = {x = 1, y = 0},
    unlocked = true,
    discovered = true,
    loc_vars = function()
        return {vars = {true_localize({type = 'name_text', set = 'Voucher', key = G.GAME.brainstormvouchertocopy}) or 'Nothing'}}
    end,
    calculate = function(_, card, context)
        local other_voucher
        for _, v in ipairs(G.vouchers.cards) do
            if v.config.center_key == G.GAME.brainstormvouchertocopy then
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

function SEALS.deep_copy(obj, seen)
	if type(obj) ~= 'table' then
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

if SEALS.find_mod('YGGDRASIL') then
    local oldstartrun = Game.start_run
    function Game:start_run(args)
        oldstartrun(self, args)
        local jokerupgradessec = 'soe_skill_tree_jokerupgrades'
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
    SMODS.Joker:take_ownership('j_joker',
        {
            loc_vars = function(self, _, card)
                card.ability.extra = card.ability.extra or {}
                local key
                if if_skill_obtained('soe_jimbo_upgrade2') then
                    key = self.key..'_u'
                end
                return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.xmult}, key = key}
            end,
            update = function(_, card)
                card.ability.mult = 0
                card.ability.extra = {}
                local multamount
                local xmultamount
                local chipsamount
                if if_skill_obtained('soe_jimbo_upgrade5') then
                    chipsamount = 1
                    xmultamount = 1.5
                    multamount = 0
                elseif if_skill_obtained('soe_jimbo_upgrade4') then
                    multamount = 10
                    chipsamount = 15
                    xmultamount = 1
                elseif if_skill_obtained('soe_jimbo_upgrade3') then
                    multamount = 7
                    chipsamount = 10
                    xmultamount = 1
                elseif if_skill_obtained('soe_jimbo_upgrade2') then
                    multamount = 5
                    chipsamount = 5
                    xmultamount = 1
                elseif if_skill_obtained('soe_jimbo_upgrade1') then
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
            end,
        },
        true
    )
    SMODS.Joker:take_ownership('j_egg',
        {
            update = function(_, card)
                local moneyincrease
                if if_skill_obtained('soe_egg_upgrade4') then
                    moneyincrease = 15
                elseif if_skill_obtained('soe_egg_upgrade2') then
                    moneyincrease = 8
                elseif if_skill_obtained('soe_egg_upgrade1') then
                    moneyincrease = 5
                else
                    moneyincrease = 3
                end
                card.ability.extra = moneyincrease
            end,
            calc_dollar_bonus = function(_, card)
                if if_skill_obtained('soe_egg_upgrade3') then
                    if (SMODS.pseudorandom_probability(card, 'egg', 1, (if_skill_obtained('ygg_egg_upgrade5') and 2 or 4)) or (if_skill_obtained('soe_egg_upgrade5') and G.GAME.blind.boss)) then
                        return card.sell_cost
                    end
                end
            end
        },
        true
    )
end

--assert(SMODS.load_file('allinone.lua'))()
assert(SMODS.load_file('bigfuncs.lua'))()

SMODS.Joker{
    name = 'AscendedJoker',
    key = 'ascendedjoker',
    atlas = 'Joker',
    prefix_config = {atlas = false},
    pos = {x = 0, y = 0},
    soul_pos = {x = 1000, y = 1000},
    rarity = 4,
    cost = 30,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(_, card)
        for _, v in ipairs(SEALS.get_quantum_jokers(card)) do
            SEALS.copy_card_but_not(card, v)
        end
    end,
    in_pool = function()
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

for _, c in ipairs({G.P_CENTERS, SMODS.Planet.obj_table}) do
    for k, v in pairs(c) do
        if v.set == 'Planet' and v.config.hand_type then
            SMODS.Joker{
                key = k .. 'joker',
                atlas = v.atlas or 'Tarot',
                prefix_config = {atlas = false},
                pos = v.pos,
                rarity = 3,
                soe_is_planet_joker = true,
                soe_planet_mod = v.original_mod,
                soe_planet_key = k,
                loc_txt = {
                    name =  ((not v.original_mod) and localize({type = 'name_text', key = k, set = 'Planet'})..' Joker') or '',
                    text = {
                        "If played {C:attention}poker hand{} is",
                        "{C:attention}#1#{}",
                        "Upgrade played hand",
                    },
                },
                cost = v.cost*2,
                unlocked = true,
                discovered = true,
                blueprint_compat = true,
                eternal_compat = true,
                perishable_compat = true,
                no_collection = true,
                config = {extra = {hand_type = v.config.hand_type}},
                loc_vars = function(_, _, card)
                    return {vars = {localize(card.ability.extra.hand_type, 'poker_hands')}}
                end,
                calculate = function(_, card, context)
                    if context.before and context.scoring_name == card.ability.extra.hand_type then
                        return {
                            level_up = true,
                            message = localize('k_level_up_ex')
                        }
                    end
                end,
                in_pool = function()
                    if SMODS.is_poker_hand_visible(v.config.hand_type) then
                        return true
                    end
                    return false
                end,
                set_badges = function(_, _, badges)
                    if v.mod ~= SEALS then
                        badges[#badges+1] = SEALS.create_mod_badge(v.mod)
                    end
                end
            }
        end
    end
end

SMODS.Joker{
    key = 'c_talismanjoker',
    atlas = 'Tarot',
    prefix_config = {atlas = false},
    pos = {x = 3, y = 4},
    rarity = 3,
    soe_is_consumable_joker = true,
    cost = 10,
    boostershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(_, card, context)
        if context.before then
            local cards = {}
            for _, v in ipairs(context.scoring_hand) do
                if SEALS.is_eligible_for_seal(v) then
                    cards[#cards+1] = v
                end
            end
            if not cards[1] then
                return {
                    message = localize('k_nope_ex'),
                    card = card,
                }
            end
            local randomcard = pe(cards, ps('talisman'))
            if randomcard then
                return {
                    func = function()
                        randomcard.seal = 'Gold'
                        randomcard.ability.delay_seal = true
                        SEALS.event(function()
                            randomcard.seal = nil
                            randomcard:set_seal('Gold', nil, true)
                            SMODS.calculate_effect({message = 'Talisman!', instant = true}, card)
                            return true
                        end)
                        delay(0.9375)
                    end
                }
            end
        end
    end,
}

SMODS.Joker{
    key = 'c_souljoker',
    atlas = 'Tarot',
    prefix_config = {atlas = false},
    pos = {x = 2, y = 2},
    rarity = 3,
    soe_is_consumable_joker = true,
    cost = 10,
    boostershader = true,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(_, card, context)
        if context.selling_self then
            return {func = function()
                play_sound('timpani')
                local oldusedjokers = sc(G.GAME.used_jokers)
                local other_card = SMODS.add_card({set = 'Joker', legendary = true, area = G.soe_joker_deck or G.deck})
                G.GAME.used_jokers[other_card.config.center_key] = oldusedjokers[other_card.config.center_key]
                G.playing_card = (G.playing_card or 0) + 1
                other_card.playing_card = G.playing_card
                G.playing_cards[#G.playing_cards+1] = other_card
                check_for_unlock({type = 'spawn_legendary'})
                card:juice_up(0.3, 0.5)
            end}
        end
    end,
}

SMODS.DrawStep {
    key = 'souljoker',
    order = 50,
    func = function(self)
        if self.config.center_key == 'j_soe_c_souljoker' and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) + 0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) + 0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2
            G.shared_soul.role.draw_major = self
            G.shared_soul:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            G.shared_soul:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.Joker{
    name = 'BlankJoker',
    key = 'v_blankjoker',
    atlas = 'Vouchers',
    pos = {x = 7, y = 0},
    rarity = 3,
    soe_is_voucher_joker = true,
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
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.roundsleft}}
    end,
    calculate = function(_, card, context)
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

local oldenegativegetweight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership('e_negative', {
    get_weight = function(self)
        local weight = oldenegativegetweight(self)
        for _, v in ipairs(SMODS.find_card('j_soe_v_antimatterjoker')) do
            weight = weight * v.ability.extra.weightmult
        end
        return weight
    end
}, true)

SMODS.Joker{
    name = 'AntimatterJoker',
    key = 'v_antimatterjoker',
    atlas = 'Vouchers',
    pos = {x = 7, y = 1},
    rarity = 4,
    soe_is_voucher_joker = true,
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
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.weightmult}}
    end,
    calculate = function(_, card, context)
        if (context.other_main and SEALS.has_edition(context.other_main, 'e_negative')) or (context.individual and not context.end_of_round and SEALS.has_edition(context.other_card, 'e_negative')) then
            return {xmult = card.ability.extra.xmult}
        end
    end,
    in_pool = function()
        return false
    end
}

SMODS.DrawStep{
    key = 'boostershader',
    order = 10,
    func = function(self)
        if self.config.center.boostershader or self.ability.set == 'soe_Phantom' and self.config.center_key ~= 'c_soe_cannotfinditemwithkeyc_deja_vu' then
            self.children.center:draw_shader('booster',nil, self.ARGS.send_to_shader)
        end
    end
}

--[[
SMODS.DrawStep{
    key = 'editionshaders',
    order = 21,
    func = function(self)
        if self and self.edition and self.ability and self.ability.soe_quantum_editions then
            for k, v in pairs(self.ability.soe_quantum_editions) do
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
        if self.config.center.vouchershader or self.ability.soe_detached_seal == 'Gold' then
            self.children.center:draw_shader('voucher',nil, self.ARGS.send_to_shader)
        end
    end
}

SMODS.DrawStep{
    key = 'negativeshader',
    order = 20,
    func = function(self)
        if self.config.center.negativeshader then
            self.children.center:draw_shader('negative',nil, self.ARGS.send_to_shader)
        end
    end
}

local unorganizedrarity
if has_cryptid then
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
    config = {extra = {xmult = unorganizedxmult}},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.xmult}}
    end,
    calculate = function(_, card, context)
        if (context.other_joker and (context.other_joker:get_seal() or (context.other_joker.ability.soe_legalenhancements and next(context.other_joker.ability.soe_legalenhancements)) or context.other_joker.ability.legallysleeve)) or (context.other_consumeable and context.other_consumeable:get_seal()) then
            return {x_mult = card.ability.extra.xmult}
        end
        if context.individual then
            for _, v in ipairs(SMODS.Sticker.obj_buffer) do
                if context.other_card.ability[v] then
                    return {xmult = card.ability.extra.xmult}
                end
            end
        end
    end,
}

SMODS.Joker{
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
    immutable = true,
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.lives}}
    end,
    calculate = function(_, card, context)
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
                saved = 'k_life_used',
                colour = G.C.RED
            }
        end
    end,
    in_pool = function()
        return false
    end,
    add_to_deck = function(_, card)
        if SMODS.find_card('j_soe_extralife')[1] then
            local total = 0
            for _, v in ipairs(SMODS.find_card('j_soe_extralife')) do
                if v ~= card then
                    total = total + (v.ability.extra.lives or 0)
                    v:start_dissolve()
                end
            end
            card.ability.extra.lives = (card.ability.extra.lives or 0) + total
        end
        card:set_edition('e_negative', true, true)
    end,
}

local exoticrarity
if has_cryptid then
    exoticrarity = 'cry_exotic'
else
    exoticrarity = 'soe_infinity'
end

SMODS.Joker{
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
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'soe_seal_evolve', set = 'Other'}
        info_queue[#info_queue+1] = G.P_CENTERS.j_soe_sealjoker2
    end,
    calculate = function(_, card, context)
        if context.joker_main then
            local passed = true
            for _, v in ipairs(G.playing_cards) do
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
    end,
    in_pool = function()
        return not G.GAME.used_jokers.j_soe_sealjoker2
    end
}

SMODS.Joker{
    key = 'sealjoker2',
    atlas = 'Exotics',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = {extra = {fusion_cost = 50}},
    rarity = (SEALS.find_mod('entr') and 'entr_entropic') or exoticrarity,
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = {key = 'soe_seal_fuse', set = 'Other', vars = {colours = {G.P_SEALS.soe_upgradedsoe_rainbowsealseal.badge_colour}}}
        info_queue[#info_queue+1] = G.P_CENTERS.j_soe_infinityomega
    end,
    in_pool = function()
        return false
    end
}

local oldauracanuse = G.P_CENTERS.c_aura.can_use
SMODS.Spectral:take_ownership('c_aura',
    {
        can_use = function(self, card)
            if SMODS.find_card('j_soe_sealjoker2')[1] then
                return G.hand and #G.hand.highlighted == 1
            else
                if oldauracanuse then
                    return oldauracanuse(self, card)
                else
                    return G.hand and #G.hand.highlighted == 1 and not G.hand.highlighted[1].edition
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
                for _, id in ipairs(SEALS.convert_ranks_to_ids(SEALS.get_ranks(context.other_card))) do
                    if id <= 10 and id >= 0 and id % 2 == 0 then
                        return {mult = card.ability.extra}
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
                for _, id in ipairs(SEALS.convert_ranks_to_ids(SEALS.get_ranks(context.other_card))) do
                    if ((id <= 10 and id >= 0 and id % 2 == 1) or (id == 14)) then
                        return {chips = card.ability.extra}
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
    JokerDisplay.Definitions.j_even_steven.calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                for _, id in ipairs(SEALS.convert_ranks_to_ids(SEALS.get_ranks(scoring_card))) do
                    if id <= 10 and id >= 0 and id % 2 == 0 then
                        mult = mult + card.ability.extra * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        break
                    end
                end
            end
        end
        card.joker_display_values.mult = mult
    end

    JokerDisplay.Definitions.j_odd_todd.calc_function = function(card)
        local chips = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                for _, id in ipairs(SEALS.convert_ranks_to_ids(SEALS.get_ranks(scoring_card))) do
                    if ((id <= 10 and id >= 0 and id % 2 == 1) or (id == 14)) then
                        chips = chips + card.ability.extra * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        break
                    end
                end
            end
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.localized_text = '('..localize('Ace', 'ranks')..',9,7,5,3)'
    end
end

function SEALS.parse_loc_txt(center)
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
                ize.vars[#ize.vars+1] = localize(card.ability.soe_quantum_ranks[i], 'ranks')
            end
        end
        if card.ability.soe_quantum_suits then
            for i = 1, #card.ability.soe_quantum_suits do
                total = total + 1
                G.localization.descriptions.Other.playing_card2.text_part2[1] = G.localization.descriptions.Other.playing_card2.text_part2[1] .. ("{}/{V:%s}#%s#"):format(total + 1, total + 2)
                ize.vars[#ize.vars+1] = localize(card.ability.soe_quantum_suits[i], 'suits_plural')
                ize.vars.colours[#ize.vars.colours+1] = G.C.SUITS[card.ability.soe_quantum_suits[i]]
            end
        end
        G.localization.descriptions.Other.playing_card2.text = {" "..G.localization.descriptions.Other.playing_card2.text_part1[1].." of "..G.localization.descriptions.Other.playing_card2.text_part2[1].." "}
        SEALS.parse_loc_txt(G.localization.descriptions.Other.playing_card2)
        localize(ize)
    end
end

if has_cryptid and Talisman then
    SMODS.Joker{
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
        loc_vars = function(_, _, card)
            return {vars = {card.ability.extra.emult_mod, card.ability.extra.emult or (1 + (card.ability.extra.emult_mod*card.ability.extra.idea_count)), card.ability.extra.sealemult}}
        end,
        calculate = function(_, card, context)
            if context.joker_main then
                card.ability.extra.emult = 1 + (card.ability.extra.emult_mod*card.ability.extra.idea_count)
                return {emult = card.ability.extra.emult}
            end
            if context.other_main and context.other_main ~= card then
                local key, set = context.other_main.config.center_key, context.other_main.config.center.set
                local name = localize({type = 'name_text', key = key, set = set})
                local description = ''
                if type(G.localization.descriptions[set][key].text[1]) == 'string' then
                    description = table.concat(G.localization.descriptions[set][key].text, " ")
                elseif type(G.localization.descriptions[set][key].text[1]) == 'table' then
                    for _, v in ipairs(G.localization.descriptions[set][key].text) do
                        description = description..table.concat(v, ' ')
                    end
                end
                local searchline = name..description
                searchline = string.gsub(searchline, '{[^}]+}', '')
                searchline = string.gsub(searchline, '#[^#]+#', '')
                searchline = string.gsub(searchline, '{}', '')
                searchline = string.lower(searchline)
                if searchline:match('seal') then
                    return {emult = card.ability.extra.sealemult}
                end
            end
        end
    }
end

SMODS.Rarity{
    key = 'infinity',
    badge_colour = SMODS.Gradient{
        key = 'seal_gradient',
        colours = {
            HEX('E8463D'),
            HEX('009CFD'),
            HEX('A267E4'),
            HEX('F7AF38'),
        }
    },
}

SMODS.Joker{
    key = 'infinityred',
    atlas = 'InfinitySeals',
    pos = {x = 0, y = 0},
    soul_pos = {x = 4, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
		if context.post_trigger and context.other_card.set_seal and context.other_card.seal ~= 'soe_upgradedsoe_rainbowsealseal' and context.other_card.config.center_key ~= self.key and context.other_card ~= card.soe_realcard or context.individual and context.cardarea == G.play then
            local other_card = context.other_card
            return {
                message = 'Red!!!',
                colour = G.C.RED,
                message_card = card,
                func = function()
                    other_card:set_seal('Red')
                end
            }
		end
    end

}

SMODS.Joker{
    key = 'infinityblue',
    atlas = 'InfinitySeals',
    pos = {x = 3, y = 0},
    soul_pos = {x = 7, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    config = {extra = {odds = 8}},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function (_, _, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {numerator, denominator}}
    end,
    calculate = function (_, card, context)
        --[[
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            card.ability.extra.planets[#card.ability.extra.planets+1] = context.consumeable.config.center_key
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
                            local enhancements, seals, editions = card.ability.soe_quantum_enhancements, card.ability.soe_quantum_seals, {'negative'}
                            if card.ability.soe_quantum_editions and card.ability.soe_quantum_editions[1] then
                                for _, v in ipairs(card.ability.soe_quantum_editions) do
                                    editions[#editions+1] = v
                                end
                            end
                            local newcard = SMODS.add_card({key = 'j_joker', seal = seals and seals[1], edition = 'e_negative'})
                            if enhancements and enhancements[1] and G.P_CENTERS[enhancements[1]] and (G.P_CENTERS[enhancements[1]].replace_base_card or enhancements[1] == 'm_stone') then
                                newcard:set_ability('j_soe_'..(enhancements[1] == 'm_stone' and 'stone' or G.P_CENTERS[enhancements[1]].original_key or enhancements[1])..'cardjoker')
                            end
                            newcard:set_base(other_card.config.card)
                            newcard.ability.soe_quantum_suits = other_card.ability.soe_quantum_suits
                            newcard.ability.soe_quantum_ranks = other_card.ability.soe_quantum_ranks
                            newcard.ability.soe_quantum_editions = editions
                            if enhancements and enhancements[1] then
                                for i, v in ipairs(enhancements) do
                                    if i > 1 or not (enhancements[1] and G.P_CENTERS[enhancements[1]] and (G.P_CENTERS[enhancements[1]].replace_base_card or enhancements[1] == 'm_stone')) then
                                        SEALS.set_joker_enhancement(newcard, v)
                                    end
                                end
                            end
                            if seals and seals[1] then
                                for i, v in ipairs(seals) do
                                    if i > 1 then
                                        newcard:set_seal(v, true, true)
                                    end
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

SMODS.Joker{
    key = 'infinitygold',
    atlas = 'InfinitySeals',
    pos = {x = 2, y = 0},
    soul_pos = {x = 6, y = 0,
    draw = function(card, scale_mod, rotate_mod)
        card.children.floating_sprite:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        card.children.floating_sprite:draw_shader('voucher', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('voucher', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    end},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {extra = {dollars = 3}},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.dollars}}
    end,
    calculate = function(self, card, context)
        if context.post_trigger and is(context.other_card, Card) and context.other_card.config.center_key ~= self.key and context.other_card ~= card.soe_realcard or (context.individual and (context.cardarea == G.play or context.cardarea == G.hand)) then
            local count = SEALS.get_seal_count(context.other_card)
            if count > 0 then
                return {
                    message = 'Gold!!! ('..localize('$')..count*card.ability.extra.dollars..')',
                    colour = G.C.GOLD,
                    dollars = count*card.ability.extra.dollars,
                    message_card = card,
                    remove_default_message = true
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'infinitypurple',
    atlas = 'InfinitySeals',
    pos = {x = 1, y = 0},
    soul_pos = {x = 5, y = 0},
    rarity = 'soe_infinity',
    cost = 55,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    calculate = function(self, card, context)
        if ((context.individual and context.cardarea == G.play) or (context.post_trigger and context.other_card.config and context.other_card.config.center_key ~= self.key and context.other_card ~= card.soe_realcard)) and SEALS.get_seals(context.other_card)[1] then
            local other_card = context.other_card
            return {func = function()
                local results = SEALS.forcetriggerseals(other_card)
                if results then
                    if results[1] then
                        for _, v in ipairs(results) do
                            v.message_card = card
                            v.remove_default_message = true
                            v.message = 'Sealtrigger!'
                            v.colour = G.C.PURPLE
                            if has_cryptid then v.sound = 'cry_demitrigger' end
                        end
                        results = SMODS.merge_effects(results)
                    else
                        results = {message_card = card, message = 'Sealtrigger!', colour = G.C.PURPLE, sound = has_cryptid and 'cry_demitrigger' or nil}
                    end
                    SMODS.calculate_effect(results, card)
                end
            end}
        end
    end
}

SMODS.Joker{
    key = 'infinityomega',
    atlas = 'InfinitySeals',
    pos = {x = 8, y = 0},
    soul_pos = {x = 9, y = 0},
    rarity = 'soe_infinity',
    cost = 5555,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    add_to_deck = function(_, card, from_debuff)
        if not from_debuff and SEALS.find_mod('jen') then
            play_sound('jen_omegacard', 1, 0.4)
            card:juice_up(1.5, 1.5)
            Q(function() Q(function() play_sound('jen_chime', 1, 0.65) return true end); jl.a('Omega!', G.SETTINGS.GAMESPEED, 1, G.C.jen_RGB); jl.rd(1) return true end)
        end
        SEALS.event(function()
            for _, v in ipairs(G.I.CARD) do
                if v.ability then
                    SEALS.recalc_quantum_editions(v)
                end
            end
            return true
        end)
    end,
    in_pool = function()
        return false
    end
}

if has_cryptid then
    local oldsmodssoundscrymusicexoticselectmusictrack = SMODS.Sounds.cry_music_exotic.select_music_track
    SMODS.Sounds.cry_music_exotic.select_music_track = function()
        return (Cryptid_config and Cryptid_config.Cryptid and Cryptid_config.Cryptid.exotic_music and (not not next(Cryptid.advanced_find_joker(nil, 'soe_infinity', nil, nil, true)))) or oldsmodssoundscrymusicexoticselectmusictrack()
    end
end

SMODS.Seal{
    key = 'sealseal',
    badge_colour = HEX('E8463D'),
    atlas = 'Seals',
    pos = {x = 0, y = 0}
}

SMODS.Seal{
    key = 'rainbowseal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'RainbowSeal',
    pos = {x = 0, y = 0},
}

SMODS.Seal{
    key = 'reverseseal',
    badge_colour = G.C.UI.TEXT_DARK,
    atlas = 'Seals',
    pos = { x = 0, y = 0 },
    config = {extra = {downxmult = 3}},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.seal.extra.downxmult}}
    end
}

SMODS.Seal{
    key = 'negativeseal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = {x = 6, y = 4},
    draw = function(self, card)
        local sprite = G.shared_seals[self.key]
        sprite.role.draw_major = card
        sprite:draw_shader('dissolve', nil, nil, nil, card.children.center)
        sprite:draw_shader('negative', nil, card.ARGS.send_to_shader, nil, card.children.center)
        sprite:draw_shader('negative_shine', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
    calculate = function(_, card, context)
        if context.stay_flipped and context.other_card == card and card.soe_from_negative_seal and context.from_area == G.play and context.to_area == G.discard then
            card.soe_from_negative_seal = nil
            return {modify = {to_area = G.jokers}}
        end
    end
}

SMODS.Seal{
    key = 'carmineseal',
    badge_colour = HEX('FF0040'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
}

function SEALS.has_seal(card, seal)
    if not card or not seal then return false end
    if card.ability and card.ability['soe_has_'..seal] then
        return true
    end
    for _, v in ipairs(SEALS.get_seals(card)) do
        if v == seal then return true end
    end
    return false
end

function SEALS.has_edition(card, edition)
    if not card or not edition then return false end
    if card.edition and card.edition.key == edition then
        return true
    end
    if card.ability and card.ability['soe_has_'..edition] then
        return true
    end
    for _, v in ipairs(SEALS.get_quantum_editions(card)) do
        if v == edition then return true end
    end
    return false
end

function SEALS.has_sticker(card, sticker)
    if not card or not sticker then return false end
    if card.ability and card.ability[sticker] then
        return true
    end
    for _, v in ipairs(SEALS.get_quantum_stickers(card)) do
        if v == sticker then return true end
    end
    return false
end

function SEALS.add_seal(card, seal, silent, immediate)
    if not card.seal then card:set_seal(seal, silent, immediate) return end
    local quantum_seals = card.ability.soe_quantum_seals or {}
    card.ability.soe_quantum_seals = quantum_seals
    quantum_seals[#quantum_seals+1] = seal
    if not silent then
        G.CONTROLLER.locks.seal = true
        local sound = {sound = 'gold_seal', per = 1.2, vol = 0.4}
        if immediate then
            card:juice_up(0.3, 0.3)
            play_sound(sound.sound, sound.per, sound.vol)
            G.CONTROLLER.locks.seal = false
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    card:juice_up(0.3, 0.3)
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
end

function SEALS.remove_seal(card)
    local seal = card.ability.soe_quantum_seals and card.ability.soe_quantum_seals[1] or nil
    if card.seal then
        card.soe_dont_quantum = true
        card:set_seal(seal, true, true)
        card.soe_dont_quantum = nil
        if seal then
            table.remove(card.ability.soe_quantum_seals, 1)
        end
    elseif seal then
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

function SEALS.is_in_area(card, area)
    local areas = SMODS.get_card_areas(area)
    if not areas[1] then return end
    for _, v in ipairs(areas) do
        if card.area == v then return true end
    end
end

--[[
SMODS.Seal{
    key = 'aquaseal',
    badge_colour = HEX('00FFFF'),
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
}
]]

SMODS.Seal{
    key = 'yellowseal',
    badge_colour = HEX('F7AF38'),
    atlas = 'Enhancers',
    pos = {x = 2, y = 0},
    calculate = function(_, card, context)
        if context.stay_flipped and context.other_card == card and context.from_area == G.play and context.to_area == G.discard then
            return {modify = {to_area = G.hand}}
        end
    end
}

SMODS.Seal{
    key = 'foilseal',
    badge_colour = G.C.DARK_EDITION,
    atlas = 'Enhancers',
    pos = {x = 5, y = 4},
    draw = function(self, card)
        G.shared_seals[self.key].role.draw_major = card
        G.shared_seals[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[self.key]:draw_shader('foil', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

--[[
function SEALS.predict_ps(key, key2)
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
        result, fakekey = SEALS.predict_ps(seed, fakekey)
        results[#results+1] = result
        depth = depth + 1
    until untilfunc(result, depth)
    return results, depth
end

local oldsmodspseudorandomprobability = SMODS.pseudorandom_probability
function SMODS.pseudorandom_probability(trigger_obj, ...)
    --[[
	local numerator, denominator = SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator)
    local card = trigger_obj or {}
    _, card.retriggersuntilhit = SEALS.get_pseudoseed_forecast(seed, function (result, depth)
        if pseudorandom(result) < numerator / denominator then
            return true
        end
        return false
    end)
    local g = oldsmodspseudorandomprobability(trigger_obj, ...)
    if is(trigger_obj, Card) then
        SEALS.holo_prob = SEALS.holo_prob or {}
        SEALS.holo_prob[#SEALS.holo_prob+1] = {trigger_obj = trigger_obj, result = g, context = SMODS.context_stack[#SMODS.context_stack] and SMODS.context_stack[#SMODS.context_stack].context or nil}
    end
	return g
end
]]

--[[
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
    badge_colour = HEX('D3795C'),
    atlas = 'Seals',
    config = {extra = {xmult = 1.5}},
    pos = {x = 1, y = 0},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.seal.extra.xmult}}
    end,
    calculate = function (_, card, context)
        if G.GAME.SEALS_Scoring_Active and context.soe_add_to_retrigger_ret and context.other_card == card then
            return {soe_add_to_ret = {xmult = card.ability.seal.extra.xmult}}
        end
        if context.main_scoring and context.cardarea == G.play then
            card.soe_repetition_trigger = (card.soe_repetition_trigger or -1) + 1
            if card.soe_repetition_trigger > 0 then
                card.soe_repetition_trigger = nil
                SMODS.calculate_effect({xmult = card.ability.seal.extra.xmult}, card)
                return nil, true
            end
        end
    end,
    forcetrigger = function(_, card)
        return {xmult = card.ability.seal.extra.xmult}
    end
}

SMODS.Seal{
    key = 'upgradedredseal',
    badge_colour = HEX('FF5E53'),
    atlas = 'Seals',
    pos = {x = 3, y = 0},
    soe_jokercalculate = function(_, card, context)
        if context.retrigger_joker_check and context.other_card == card and context.other_context.retrigger_joker_check and not context.other_context.retrigger_joker then
            return {repetitions = 1, soe_seal_bypass_retrigger_restrictions = true}
        end
    end,
    forcetrigger = function(_, card)
        if not G.soe_upgradedredseal_rescoring and card.playing_card then
            return {message = 'Again!!', colour = G.C.RED, func = function()
                G.soe_upgradedredseal_rescoring = true
                local context = {cardarea = card.area or G.play or 'unscored', full_hand = G.play.cards, scoring_hand = G.soe_scoring_hand or {}, scoring_name = G.soe_scoring_name or 'High Card'}
                if G.soe_poker_hands then
                    context.poker_hands = G.soe_poker_hands
                else
                    context.poker_hands = {}
                    for _, v in ipairs(G.handlist) do
                        context.poker_hands[v] = {}
                    end
                end
                SMODS.score_card(card, context)
                G.soe_upgradedredseal_rescoring = nil
            end}
        end
    end,
    in_pool = function()
        return false
    end
}

SMODS.Seal{
    key = 'upgradedblueseal',
    badge_colour = HEX('33BBFF'),
    atlas = 'Seals',
    pos = {x = 4, y = 0},
    calculate = function(_, card, context)
        if ((context.playing_card_end_of_round and context.cardarea == G.hand) or (context.end_of_round and context.main_eval)) or context.forcetrigger then
            return {func = function()
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        if G.GAME.last_hand_played then
                            local _planet
                            for _, v in ipairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == G.GAME.last_hand_played then
                                    _planet = v.key
                                    break
                                end
                            end
                            if _planet then
                                local ccard = SMODS.add_card({key = _planet})
                                ccard:set_edition('e_negative', true)
                                SEALS.add_seal(ccard, 'Red', nil, true)
                                SEALS.add_seal(ccard, 'Gold', true, true)
                                SMODS.calculate_effect({message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet, instant = true}, card)
                            end
                            G.GAME.consumeable_buffer = 0
                        end
                        return true
                    end
                }))
                delay(0.9375)
            end}
        end
    end,
    in_pool = function()
        return false
    end
}

SMODS.Seal{
    key = 'upgradedgoldseal',
    badge_colour = HEX('FFD44B'),
    atlas = 'Seals',
    config = {extra = {xdollars = 1.5}},
    pos = {x = 5, y = 0},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.seal.extra.xdollars}}
    end,
    calculate = function(_, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.forcetrigger then
            local dollars = (G.GAME.dollars+(G.GAME.dollar_buffer or 0))/2
            return {
                dollars = dollars,
                remove_default_message = true,
                message = localize('$')..'X'..card.ability.seal.extra.xdollars,
                colour = G.C.MONEY,
                func = function()
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0)+dollars
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
    in_pool = function()
        return false
    end
}

SMODS.Seal{
    key = 'upgradedpurpleseal',
    badge_colour = HEX('FFD44B'),
    atlas = 'Seals',
    pos = {x = 6, y = 0},
    calculate = function(_, card, context)
        if ((context.discard and context.other_card == card) or context.selling_self) or context.forcetrigger then
            return {func = function()
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        local ccard = SMODS.add_card({set = 'Tarot', key_append = '8ba'})
                        ccard:set_edition('e_negative', true)
                        SEALS.add_seal(ccard, 'Red', nil, true)
                        SEALS.add_seal(ccard, 'Gold', true, true)
                        SMODS.calculate_effect({message = localize('k_plus_tarot'), colour = G.C.PURPLE, instant = true}, card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                delay(0.9375)
            end}
        end
    end,
    in_pool = function()
        return false
    end
}

SMODS.Seal{
    key = 'upgradedsoe_rainbowsealseal',
    badge_colour = HEX('9B0B00'),
    atlas = 'Seals',
    pos = {x = 7, y = 0},
    in_pool = function()
        return false
    end
}

local oldsmodsscorecard = SMODS.score_card
function SMODS.score_card(card, context)
    local oldscoredcard = G.soe_from_smods_score_card
    G.soe_from_smods_score_card = card
    if not G.soe_calculating_playing_cards_as_jokers and context.cardarea == G.hand and SEALS.check_deck('inverse') and card:can_calculate(context.ignore_debuff, context.remove_playing_cards or context.joker_type_destroyed) then
        G.soe_calculating_playing_cards_as_jokers = true
        context.cardarea = G.play
        SMODS.score_card(card, context)
        context.cardarea = G.hand
        G.soe_calculating_playing_cards_as_jokers = nil
        return
    end
    oldsmodsscorecard(card, context)
    if not G.soe_upgradedredseal_rescoring and SEALS.has_seal(card, 'soe_upgradedredseal') and G.soe_currently_scoring_card_effects and (next(G.soe_currently_scoring_card_effects[1]) or #G.soe_currently_scoring_card_effects > 1) then
        G.soe_upgradedredseal_rescoring = true
        SMODS.calculate_effect({message = 'Again!!', colour = G.C.RED}, card)
        SMODS.score_card(card, context)
        G.soe_upgradedredseal_rescoring = nil
    end
    if G.soe_calculating_merged_cards ~= card and card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] then
        local oldmergedcard = G.soe_calculating_merged_cards
        G.soe_calculating_merged_cards = card
        for _, v in ipairs(card.ability.soe_mergedcards) do
            SMODS.score_card(SEALS.copy_card_but_not(card, v), context)
        end
        G.soe_calculating_merged_cards = oldmergedcard
    end
    G.soe_currently_scoring_card_effects = nil
    G.soe_from_smods_score_card = oldscoredcard
end

local oldsmodscalculateretriggers = SMODS.calculate_retriggers
SMODS.calculate_retriggers = function(card, ...)
    G.soe_repetitioned_card = card
    local g = oldsmodscalculateretriggers(card, ...)
    if is(card, Card) and SEALS.has_seal(card, 'soe_upgradedredseal') then
        SMODS.insert_repetitions(g, {message = 'Again!!', colour = G.C.RED, repetitions = 1}, card, 'joker_retrigger')
        for i=1, #g-1 do
            g[#g+1] = g[i]
        end
    end
    G.soe_repetitioned_card = nil
    return g
end

local oldsmodscalceff = SMODS.calculate_effect
SMODS.calculate_effect = function(effect, scored_card, ...)
    if G.soe_truer_card and G.soe_truer_card[scored_card] then
        return oldsmodscalceff(effect, G.soe_truer_card[scored_card], ...)
    elseif scored_card.soe_realcard then
        return oldsmodscalceff(effect, scored_card.soe_realcard, ...)
    elseif effect.soe_true_card then
        return oldsmodscalceff(effect, effect.soe_true_card, ...)
    end
    return oldsmodscalceff(effect, scored_card, ...)
end

local oldcalculateedition = Card.calculate_edition
function Card:calculate_edition(context)
    if not self.edition then return oldcalculateedition(self, context) end
    if SEALS.has_seal(self, 'soe_foilseal') then
        if not SEALS.is_in_area(self, 'playing_cards') then
            if context.post_trigger and context.other_card == self then
                local thunk1, thunk2, thunk3, thunk4, thunk5 = context.pre_joker, context.post_joker, context.edition, self.config.trigger, self.ability.trigger
                context.pre_joker = true
                context.post_joker = true
                context.edition = true
                self.config.trigger = true
                self.ability.trigger = true
                local g = oldcalculateedition(self, context)
                context.pre_joker = thunk1
                context.post_joker = thunk2
                context.edition = thunk3
                self.config.trigger = thunk4
                self.ability.trigger = thunk5
                if g then
                    g.soe_true_card = self
                    return g
                end
            elseif (context.pre_joker or context.post_joker or context.edition) then
                return
            end
        elseif context.cardarea == G.hand then
            context.cardarea = G.play
            local g = oldcalculateedition(self, context)
            context.cardarea = G.hand
            return g
        end
    end
    return oldcalculateedition(self, context)
end

local oldhighlight = Card.highlight
function Card:highlight(is_higlighted)
    if is_higlighted and self.config.center_key == 'j_soe_sealjoker2' and self.area == G.jokers then
        self.children.soe_seal2buttons = UIBox({
            definition = G.UIDEF.soe_purchase_and_fuse_buttons(self),
            config = {align = 'cl', major = self, parent = self, offset = {x = 0.5, y = 0}}
        })
    elseif self.children.soe_seal2buttons then
        self.children.soe_seal2buttons:remove()
        self.children.soe_seal2buttons = nil
    end
    oldhighlight(self, is_higlighted)
    if SEALS.has_seal(self, 'soe_negativeseal') and not is_higlighted then
        if self.area == G.hand then
            if self.config.soe_negative_enabled then
                self.config.soe_negative_enabled = false
                SMODS.change_play_limit(-1)
                SMODS.change_discard_limit(-1)
            end
        elseif self.ability.consumeable and G.hand.config.soe_old_highlighted_limit then
            G.hand.config.highlighted_limit = G.hand.config.soe_old_highlighted_limit
            G.hand.config.soe_old_highlighted_limit = nil
            local limit, count = G.hand.config.highlighted_limit, #G.hand.highlighted
            if limit < count then
                for i=limit+1, count do
                    G.hand:remove_from_highlighted(G.hand.highlighted[i])
                end
            end
        end
    end
end

local oldaddhighlighted = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, ...)
    G.soe_check_eternal_cache = {}
    if self ~= G.hand and card.ability.consumeable and G.hand.config.soe_old_highlighted_limit then
        G.hand.config.highlighted_limit = G.hand.config.soe_old_highlighted_limit
        G.hand.config.soe_old_highlighted_limit = nil
        local limit, count = G.hand.config.highlighted_limit, #G.hand.highlighted
        if limit < count then
            for i=limit+1, count do
                G.hand:remove_from_highlighted(G.hand.highlighted[i])
            end
        end
    elseif SEALS.has_seal(card, 'soe_negativeseal') then
        if self == G.hand then
            if not card.config.soe_negative_enabled then
                card.config.soe_negative_enabled = true
                SMODS.change_play_limit(1)
                SMODS.change_discard_limit(1)
            end
        elseif card.ability.consumeable then
            G.hand.config.soe_old_highlighted_limit = G.hand.config.highlighted_limit
            G.hand.config.highlighted_limit = 1e309
        end
    end
    oldaddhighlighted(self, card, ...)
    if self == G.jokers and G.STATE == G.STATES.SELECTING_HAND and SEALS.check_deck('inverse') then
        self:parse_highlighted()
    end
end

SMODS.Back{
    key = 'seal',
    atlas = 'Enhancers',
    pos = {x = 5, y = 2},
}

SMODS.Back{
    key = 'merged',
    atlas = 'Enhancers',
    pos = {x = 1, y = 2},
}

SMODS.Back{
    key = 'inverse',
    atlas = 'Enhancers',
    pos = {x = 2, y = 2},
    config = {hand_size = -3, joker_slot = 3}
}

SMODS.Back{
    key = 'synonym',
    atlas = 'Enhancers',
    pos = {x = 4, y = 2},
}

SMODS.Back{
    key = 'true',
    atlas = 'Enhancers',
    pos = {x = 6, y = 2},
    config = {hand_size = -3, joker_slot = 3},
    apply = function()
        SEALS.event(function()
            SMODS.add_card({key = 'j_soe_sealjoker2'})
            return true
        end)
    end,
    calculate = function(_, _, context)
        if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            return {
                dollars = 3,
                message_card = context.other_card
            }
        end
    end
}

if CardSleeves then
    CardSleeves.Sleeve {
        key = 'seal',
        atlas = 'Sleeves',
        pos = {x = 0, y = 0},
        loc_vars = function(self)
            local key
            if self.get_current_deck_key() == 'b_soe_seal' then
                key = self.key .. '_extra'
            end
            return {key = key}
        end,
        apply = function(self)
            if self.get_current_deck_key() == 'b_soe_seal' then
                SEALS.event(function()
                    SMODS.add_card({key = 'j_soe_sealjoker2'})
                    return true
                end)
            end
        end
    }
    CardSleeves.Sleeve {
        key = 'merged',
        atlas = 'Sleeves',
        pos = {x = 1, y = 0},
        loc_vars = function(self)
            local key
            if self.get_current_deck_key() == 'b_soe_merged' then
                key = self.key .. '_extra'
            end
            return {key = key}
        end,
    }
    CardSleeves.Sleeve {
        key = 'inverse',
        atlas = 'Sleeves',
        pos = {x = 2, y = 0},
        apply = function(self)
            if SEALS.check_deck('inverse', true) then
                self.config = {}
            else
                self.config = {hand_size = -3, joker_slot = 3}
            end
            CardSleeves.Sleeve.apply(self)
        end
    }
    CardSleeves.Sleeve {
        key = 'redseal',
        atlas = 'DeckSeals',
        pos = {x = 0, y = 0},
        apply = function(self)
            CardSleeves.Sleeve.apply(self)
            local deckkey = self.get_current_deck_key()
            if deckkey and G.P_CENTERS[deckkey] and G.P_CENTERS[deckkey].apply then
                G.P_CENTERS[deckkey]:apply(G.P_CENTERS[deckkey])
            end
        end,
        calculate = function(self, _, context)
            local deckkey = self.get_current_deck_key()
            if deckkey and G.P_CENTERS[deckkey] and G.P_CENTERS[deckkey].calculate then
                return G.P_CENTERS[deckkey]:calculate(G.GAME.selected_back, context)
            end
        end
    }
    CardSleeves.Sleeve {
        key = 'goldseal',
        atlas = 'DeckSeals',
        pos = {x = 3, y = 0},
        calculate = function(_, _, context)
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
        return G.PROGRESS.soe_card_stickers.tally/G.PROGRESS.soe_card_stickers.of >= 1 
    end
}

local oldsetprofileprog = set_profile_progress
function set_profile_progress()
    local g = oldsetprofileprog()
    G.PROGRESS.soe_card_stickers = {tally = 0, of = 0}
    for _, v in pairs(G.P_CARDS) do
        G.PROGRESS.soe_card_stickers.of = G.PROGRESS.soe_card_stickers.of + #G.P_CENTER_POOLS.Stake
        G.PROGRESS.soe_card_stickers.tally = G.PROGRESS.soe_card_stickers.tally + get_card_win_sticker(v, true)
    end
    return g
end
]]

function get_card_win_sticker(_card, index)
    G.PROFILES[G.SETTINGS.profile].soe_card_stickers = G.PROFILES[G.SETTINGS.profile].soe_card_stickers or {}
	local card_usage = G.PROFILES[G.SETTINGS.profile].soe_card_stickers[(_card.base.value or '')..(_card.base.suit or '')..(_card.seal or '').._card.config.center_key..(_card.edition and _card.edition.key or '')] or {}
	if card_usage.wins then
		local applied = {}
		local _count = 0
		local _stake = nil
		for k in pairs(card_usage.wins_by_key) do
			SMODS.build_stake_chain(G.P_STAKES[k], applied)
		end
		for _, v in ipairs(G.P_CENTER_POOLS.Stake) do
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
local oldcheckforunlock = check_for_unlock
function check_for_unlock(args)
    if args.type == 'win_stake' then 
        G.PROGRESS.soe_card_stickers = G.PROGRESS.soe_card_stickers or {tally = 0, of = 0}
        if G.PROGRESS.soe_card_stickers.tally/G.PROGRESS.soe_card_stickers.of >= 1 then
            unlock_achievement('completionist_plus_plus_plus')
        end
    end
    return oldcheckforunlock(args)
end
]]

if JokerDisplay then
    JokerDisplay.Definitions.c_temperance = { -- Temperance
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

SEALS.config_tab = function()
    local configoptions = {}
    if JokerDisplay then
        configoptions[#configoptions+1] = create_toggle({
            label = "Enable JokerDisplay on Non-Jokers (Quite unstable!)",
            ref_table = SEALS.config,
            ref_value = 'nonjokerdisplay',
            callback = emptyfunc
        })
    end
    configoptions[#configoptions+1] = create_toggle({
        label = 'Disable synonym music',
        ref_table = SEALS.config,
        ref_value = 'synonymmusicdisable',
        callback = emptyfunc
    })
    configoptions[#configoptions+1] = create_toggle({
        label = 'Omega Seals on playing cards count as every joker',
        ref_table = SEALS.config,
        ref_value = 'omegasealplayingcardjokerenable',
        callback = emptyfunc
    })
    configoptions[#configoptions+1] = create_toggle({
        label = 'Show indicators on non-object objects',
        ref_table = SEALS.config,
        ref_value = 'indicators',
        callback = emptyfunc
    })
    configoptions[#configoptions+1] = create_toggle({
        label = 'Permanent Seal 2 effect',
        ref_table = SEALS.config,
        ref_value = 'permanentseal2effect',
        callback = emptyfunc
    })
    return {
        n = G.UIT.ROOT,
        config = {
            align = 'cl',
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
    oldgameupdate(self, dt)
    if G.title_top and G.title_top.cards and G.title_top.cards[1] then
        SEALS.seal_dt = SEALS.seal_dt + dt
        if SEALS.seal_dt > 0.2 then
            SEALS.seal_dt = SEALS.seal_dt - 0.2
            for _, v in ipairs(G.title_top.cards) do
                local seals = {}
                for k in pairs(G.P_SEALS) do
                    seals[#seals+1] = k
                end
                v.seal = seals[math.random(#seals)]
            end
        end
    end
    if G.P_SEALS.soe_rainbowseal and G.shared_seals.soe_rainbowseal then
        SEALS.rainbow_seal_dt = SEALS.rainbow_seal_dt + dt
        if SEALS.rainbow_seal_dt > 0.02 then
            SEALS.rainbow_seal_dt = SEALS.rainbow_seal_dt - 0.02
			local rainbow = G.P_SEALS.soe_rainbowseal
			if rainbow.pos.x == 19 and rainbow.pos.y == 17 then
				rainbow.pos.x = 0
				rainbow.pos.y = 0
			elseif rainbow.pos.x < 19 then
				rainbow.pos.x = rainbow.pos.x + 1
			elseif rainbow.pos.y < 17 then
				rainbow.pos.x = 0
				rainbow.pos.y = rainbow.pos.y + 1
			end
            G.shared_seals.soe_rainbowseal:set_sprite_pos(rainbow.pos)
        end
    end
    if G.deck and G.GAME.soe_detached_seals and not G.GAME.SEALS_Scoring_Active and not G.soe_event_scoring and G.GAME.soe_detached_seals[1] then
        SEALS.detached_red_seal_dt = SEALS.detached_red_seal_dt + dt
        if SEALS.detached_red_seal_dt > 2 then
            --sendInfoMessage('Updating Detached Red Seals', 'SEALS')
            --play_sound('generic1')
            SEALS.detached_red_seal_dt = SEALS.detached_red_seal_dt - 2
            for _, v in ipairs(G.GAME.soe_detached_seals) do
                if v and v.ability and v.ability.soe_detached_seal == 'Red' then
                    v.ability.extra.card = SEALS.get_closest_card(v, true).unique_val
                end
            end
        end
    end
    if G.deck and G.GAME.soe_quantum_numbers then
        local values = {{ref_table = G.GAME.current_round, ref_value = 'hands_left', func = function(x) ease_hands_played(x, true) end}, {ref_table = G.GAME.current_round, ref_value = 'discards_left', func = function(x) ease_discard(x, true) end}, {ref_table = G.GAME, ref_value = 'dollars', func = function(x) ease_dollars(x, true) end}--[[, {ref_table = _G, ref_value = 'hand_chips', func = function(x) SMODS.Scoring_Parameters.chips:modify(x) end}, {ref_table = _G, ref_value = 'mult', func = function(x) SMODS.Scoring_Parameters.mult:modify(x) end}]]}
        if not G.GAME.soe_quantum_number then
            G.GAME.soe_quantum_number = 0
            for _, v in ipairs(values) do
                G.GAME.soe_quantum_number = to_number(G.GAME.soe_quantum_number + (v.ref_table[v.ref_value] or 0))
            end
            for _, v in ipairs(values) do
                if v.ref_table[v.ref_value] and to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number) ~= 0 then
                    v.func(to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number))
                end
            end
            --[[
            local nodes = G.HUD.definition.nodes[1].nodes[1].nodes[5].nodes[2].nodes
            for i=1, 3 do
                nodes[i]:remove()
                table.remove(nodes, i)
            end
            table.insert(nodes, 1,
                {
                    n = G.UIT.C,
                    config = { id = 'hud_soe_quantum_number', align = "cm", padding = 0.05, minw = 1.45, colour = G.C.DYN_UI.BOSS_MAIN, emboss = 0.05, r = 0.1 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", minh = 0.33, maxw = 1.35 },
                            nodes = {
                                { n = G.UIT.T, config = { text = localize('k_hud_hands')..', '..localize('k_hud_discards')..', '..localize('k_money'), scale = 0.85 * 0.4, colour = G.C.UI.TEXT_LIGHT, shadow = true } },
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", r = 0.1, minw = 1.2, colour = G.C.DYN_UI.BOSS_DARK },
                            nodes = {
                                { n = G.UIT.O, config = { object = DynaText({ string = { { ref_table = G.GAME.current_round, ref_value = 'hands_left' } }, font = G.LANGUAGES['en-us'].font, colours = {G.C.PURPLE}, shadow = true, rotate = true, scale = 2 * 0.4 }), id = 'soe_quantum_number_UI_count' } },
                            }
                        }
                    }
                }
            )
            ]]
        end
        local passed, oldnumber = false, to_number(G.GAME.soe_quantum_number)
        for _, v in ipairs(values) do
            if v.ref_table[v.ref_value] and to_number(v.ref_table[v.ref_value]) ~= oldnumber then
                passed = true
                G.GAME.soe_quantum_number = to_number(G.GAME.soe_quantum_number + (v.ref_table[v.ref_value] - oldnumber))
            end
        end
        if passed then
            for _, v in ipairs(values) do
                if v.ref_table[v.ref_value] and to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number) ~= 0 then
                    v.func(to_number(-(v.ref_table[v.ref_value])+G.GAME.soe_quantum_number))
                end
            end
        end
        G.GAME.round_resets.discards = G.GAME.current_round.discards_left
        G.GAME.round_resets.hands = G.GAME.current_round.hands_left
    end
end

--[[
local oldcreateuibohud = create_UIBox_HUD
function create_UIBox_HUD()
    local g = oldcreateuibohud()
    if G.GAME.soe_quantum_numbers then
    end
    return g
end

local olduiboxgetuiebyid = UIBox.get_UIE_by_ID
function UIBox:get_UIE_by_ID(id, node)
    if G.GAME.soe_quantum_numbers then
        if id == 'hand_UI_count' or id == 'discard_UI_count' or id == 'dollar_text_UI' then id = 'soe_quantum_number_UI_count' end
        if id == 'hud_hands' then id = 'hud_soe_quantum_number' end
    end
    return olduiboxgetuiebyid(self, id, node)
end
]]

local oldupdate = Card.update
function Card:update(dt)
    G.soe_current_updated_card = self
    if self.soe_timer and self.soe_timer > 0 then
        self.soe_timer = self.soe_timer - dt
    end
    if self.playing_card and SEALS and JokerDisplay and SEALS.config.nonjokerdisplay then
        self.base.soe_chip_value = self:get_chip_bonus()
    end
    if not SEALS.config.nonjokerdisplay and self.joker_display_values and self.ability and self.ability.set ~= 'Joker' then
        self.joker_display_values.disabled = true
    end
    if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and not self.sticker_run then
        self.sticker_run = get_card_win_sticker(self) or 'NONE'
    end
    local info = self.ability.soe_epsilon or self.soe_epsilon or self.config.soe_epsilon or self.base.soe_epsilon or nil
    self.ability.soe_epsilon = info
    self.soe_epsilon = info
    self.config.soe_epsilon = info
    self.base.soe_epsilon = info
    oldupdate(self, dt)
    if (self.eligible_strength_jokers or self.eligible_editionless_jokers) and SMODS.find_card('j_soe_sealjoker2')[1] then
        local jokers = self.eligible_strength_jokers or self.eligible_editionless_jokers
        EMPTY(jokers)
        for i, v in ipairs(G.jokers.cards) do
            jokers[i] = v
        end
    end
    if G.deck and (self.edition and self.edition.soe_frozen or self.ability.soe_has_e_soe_frozen) and not (self.area and self.area.config.collection) and not self.config.center.soe_frozen_immune then
        if self.ability.soe_frozen_key ~= self.config.center_key then
            local edition = G.P_CENTERS.e_soe_frozen
            edition.on_remove(self)
            edition.on_apply(self)
        end
        local snapshot = self.ability.soe_frozen_snapshot.ability
        if snapshot then
            for k, v in pairs(snapshot) do
                self.ability[k] = copy_table(v)
            end
        end
    end
    G.soe_current_updated_card = nil
end

local oldgfuncsusecard = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave, amt)
    local card = e.config.ref_table
    card.soe_using_card = true
    if card.ability.set == 'Booster' and card.area == G.shop_booster then
        card.soe_booster_bought_from_shop = true
    end
    if card.ability.set == 'Voucher' and card.area == G.shop_vouchers then
        card.soe_voucher_bought_from_shop = true
    end
    if card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] and (card.ability.consumeable or card.ability.set == 'Voucher') then
        G.FUNCS.soe_use_joker(e)
        SEALS.event(function() card.soe_using_card = nil return true end)
        return
    end
    oldgfuncsusecard(e, mute, nosave, amt)
    SEALS.event(function() card.soe_using_card = nil return true end)
end

local oldcardremovefromdeck = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    G.soe_check_eternal_cache = {}
    oldcardremovefromdeck(self, from_debuff)
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        for _, v in ipairs(self.ability.soe_mergedcards) do
            SEALS.copy_card_but_not(self, v.key, v):remove_from_deck(from_debuff)
        end
    end
end

local oldcardaddtodeck = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    G.soe_check_eternal_cache = {}
    oldcardaddtodeck(self, from_debuff)
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        for _, v in ipairs(self.ability.soe_mergedcards) do
            SEALS.copy_card_but_not(self, v.key, v):add_to_deck(from_debuff)
        end
    end
end

local oldcardareaemplace = CardArea.emplace
function CardArea:emplace(card, ...)
    if card.REMOVED then return end
    if not card.soe_lastcardarea and not G.SETTINGS.paused and not self.config.collection and not G.soe_creatingmergedcard and SEALS.check_deck('merged', true) then
        G.soe_creatingmergedcard = true
        local center = card.config.center
        local set = center.set
        local rarity
        if center.rarity then
            local other_rarity = center.rarity
            rarity = ({'Common', 'Uncommon', 'Rare', 'Legendary'})[other_rarity] or other_rarity
        end
        local other_card = SMODS.create_card({set = set == 'Default' and 'Base' or set, rarity = rarity, no_edition = true, skip_materialize = true})
        SEALS.merge_cards(card, {other_card}, true, true)
        G.soe_creatingmergedcard = nil
    end
    card.soe_lastcardarea = self
    local g = oldcardareaemplace(self, card, ...)
    if (self == G.shop_jokers or self == G.shop_vouchers or self == G.shop_booster or (self == G.pack_cards and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.soe_booster_bought_from_shop)) then
        if SEALS.check_deck('synonym') and card.ability.consumeable then
            if G.GAME.soe_other_consumable then
                G.GAME.soe_other_consumable = nil
                local _type
                if G.GAME.soe_joker_hands_available then
                    _type = 'soe_Synonyms'
                else
                    _type = SEALS.weighted_random({
                        soe_Vice = #G.P_CENTER_POOLS.soe_Vice,
                        soe_Phantom = #G.P_CENTER_POOLS.soe_Phantom
                    }, 'synonym_deck')
                end
                local _pool, _pool_key = get_current_pool(_type, nil, nil, 'synonym_deck')
                local center = pseudorandom_element(_pool, pseudoseed(_pool_key))
                local it = 1
                while center == 'UNAVAILABLE' do
                    it = it + 1
                    center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
                end
                center = G.P_CENTERS[center]
                card:set_ability(center)
            else
                G.GAME.soe_other_consumable = true
            end
        end
        if SEALS.check_deck('merged', false) or (self == G.pack_cards and SEALS.check_deck('merged')) then
            local other_card
            G.soe_creatingmergedcard = true
            if self == G.pack_cards then
                card.ability.soe_mergedcards = nil
                local _card_to_spawn = G.P_CENTERS[SMODS.OPENED_BOOSTER.ability.soe_mergedcards[1].key]:create_card(SMODS.OPENED_BOOSTER, card.rank)
                if is(_card_to_spawn, Card) then
                    other_card = _card_to_spawn
                else
                    other_card = SMODS.create_card(_card_to_spawn)
                end
            else
                local center = card.config.center
                local set = center.set
                local rarity
                if center.rarity then
                    local other_rarity = center.rarity
                    rarity = ({'Common', 'Uncommon', 'Rare', 'Legendary'})[other_rarity] or other_rarity
                end
                other_card = SMODS.create_card({set = set == 'Default' and 'Base' or set, rarity = rarity, no_edition = true, key_append = 'sho'})
            end
            G.soe_creatingmergedcard = nil
            SEALS.merge_cards(card, {other_card}, true, true)
        end
        if SEALS.check_deck('seal') then
            card:set_seal(SMODS.poll_seal({key = 'sealdeck', guaranteed = true}), true, true)
            if card.ability.soe_mergedcards and card.ability.soe_mergedcards[1] then
                for _, v in ipairs(card.ability.soe_mergedcards) do
                    v.seal = v.seal or SMODS.poll_seal({key = 'sealdeck', guaranteed = true})
                end
            end
        end
    end
    local key = card.config.center_key
    if self == G.jokers and G.P_CENTERS['j_soe_'..key..'joker'] then
        card:set_ability('j_soe_'..key..'joker')
        card.ability.consumeable = nil
    end
    if self == G.consumeables and key:find('^j_soe_') and key:find('joker$') and G.P_CENTERS[key:gsub('^j_soe_', ''):gsub('joker$', '')] then
        card:set_ability(key:gsub('^j_soe_', ''):gsub('joker$', ''))
    end
    if G.soe_joker_deck then
        G.soe_joker_deck.config.card_limit = #G.jokers.cards+#G.soe_joker_deck.cards
    end
    return g
end

local oldcardsetcardarea = Card.set_card_area
function Card:set_card_area(area)
    self.soe_lastcardarea = area
    oldcardsetcardarea(self, area)
end

local oldgfuncsbuyfromshop = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e)
    local c1 = e.config.ref_table
    c1.soe_buying_from_shop = true
    local g = oldgfuncsbuyfromshop(e)
    SEALS.event(function() c1.soe_buying_from_shop = nil return true end)
    return g
end

local oldgfuncstoggleshop = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    G.soe_toggling_shop = true
    local g = oldgfuncstoggleshop(e)
    SEALS.event(function() G.soe_toggling_shop = nil return true end)
    return g
end

local oldcardarearemovecard = CardArea.remove_card
function CardArea:remove_card(card, discarded_only)
    if is(card, Card) then
        if SEALS.has_sticker(card, 'soe_epsilon') and not G.SETTINGS.paused and not G.in_delete_run and not card.destroyed_by_gallowsbird and not card.soe_buying_from_shop and not G.soe_drawing_card and not card.soe_moving_card and not card.soe_using_card and not G.soe_toggling_shop and not (card.area and card.area.config.collection) then
            local _cards = discarded_only and {} or self.cards
            if discarded_only then
                for _, v in ipairs(self.cards) do
                    if v.ability and v.ability.discarded then
                        _cards[#_cards+1] = v
                    end
                end
            end
            if self.config.type == 'discard' or self.config.type == 'deck' then
                card = card or _cards[#_cards]
            else
                card = card or _cards[1]
            end
            return card
        end
        if card.config.soe_negative_enabled then
            card.config.soe_negative_enabled = false
            SMODS.change_play_limit(-1)
            SMODS.change_discard_limit(-1)
        end
    end
    if G.soe_joker_deck then
        G.soe_joker_deck.config.card_limit = #G.jokers.cards+#G.soe_joker_deck.cards
    end
    return oldcardarearemovecard(self, card, discarded_only)
end

local oldcardremove = Card.remove
function Card:remove()
    if SEALS.has_sticker(self, 'soe_epsilon') and not G.SETTINGS.paused and not G.in_delete_run and not self.destroyed_by_gallowsbird and not G.soe_toggling_shop and not (G.TMJCOLLECTION and tc(G.TMJCOLLECTION, self.area)) then
        self.getting_sliced = nil
        self.destroyed = nil
        self.shattered = nil
        self.skip_destroy_animation = nil
        self.dissolve = 0
        self.dissolve_colours = nil
        self.T.r = self.original_T.r
        if G.CONTROLLER.dragging.target ~= self then
            self.states.drag.is = false
        end
        self.children.center.pinch.x = false
        if self.highlighted and self.area then
            self.area:remove_from_highlighted(self)
        end
        if type(self.ability.soe_epsilon) == 'table' and self.ability.soe_epsilon.message then
            local oldpercent = percent
            percent = 1
            SMODS.calculate_effect({message = self.ability.soe_epsilon.message, sound = self.ability.soe_epsilon.sound or nil, colour = self.ability.soe_epsilon.colour or nil, func = self.ability.soe_epsilon.func or nil, extra = self.ability.soe_epsilon.extra or nil}, self)
            percent = oldpercent
        end
        if self.area and self.area == G.play then
            if self.ability.consumeable then
                SEALS.move_card(self, G.consumeables)
            elseif self.ability.set == 'Booster' then
                self.states.hover.can = true
                if self.soe_booster_bought_from_shop then
                    SEALS.move_card(self, G.shop_booster)
                    create_shop_card_ui(self, 'Booster', G.shop_booster)
                else
                    SEALS.move_card(self, G.consumeables)
                end
            elseif self.ability.set == 'Voucher' then
                self.states.hover.can = true
                if self.soe_voucher_bought_from_shop then
                    SEALS.move_card(self, G.shop_vouchers)
                    create_shop_card_ui(self, 'Voucher', G.shop_vouchers)
                else
                    SEALS.move_card(self, G.consumeables)
                end
            end
        end
        return
    end
    oldcardremove(self)
    if self.REMOVED then
        G.soe_indexable_cards[self.unique_val] = nil
        if not G.OVERLAY_MENU and self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
            for _, v in pairs(self.ability.soe_mergedcards) do
                local key = v.key or v.enhancement or 'c_base'
                if not SMODS.find_card(key, true)[1] then
                    G.GAME.used_jokers[key] = nil
                end
            end
        end
    end
end

SMODS.Sticker {
    key = 'epsilon',
    badge_colour = HEX('C70D09'),
    atlas = 'Stickers',
    pos = {x = 0, y = 0},
    rate = 0,
    should_apply = false
}

local oldsmodsiseternal = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
    if SEALS.has_sticker(card, 'soe_epsilon') then
        return true
    end
    return oldsmodsiseternal(card, trigger)
end

local oldsmodsdestroycards = SMODS.destroy_cards
function SMODS.destroy_cards(cards, ...)
    if not cards[1] then
        if is(cards, Card) and not SEALS.has_sticker(cards, 'soe_epsilon') then
            cards = {cards.soe_realcard or cards}
        else
            return
        end
    end
    local newcards = {}
    for _, v in ipairs(cards) do
        if not SEALS.has_sticker(v, 'soe_epsilon') then
            newcards[#newcards+1] = v.soe_realcard or v
        end
    end
    if not newcards[1] then return end
    return oldsmodsdestroycards(newcards, ...)
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

SMODS.Joker:take_ownership('j_flash',
    {
        calculate = function(_, card, context)
            if context.reroll_shop and not context.blueprint and not SEALS.has_edition(card, 'e_soe_frozen') then
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = 'mult',
                    scalar_value = 'extra',
                    no_message = true
                })
                return {
                    message = localize({type = 'variable', key = 'a_mult', vars = {card.ability.extra}}),
                    colour = G.C.MULT,
                }
            end
        end
    },
    true
)

SMODS.Joker:take_ownership('j_burglar',
    {
        calculate = function(_, card, context)
            if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                ease_discard(-G.GAME.current_round.discards_left, nil, true)
                                ease_hands_played(card.ability.extra)
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra } } })
                                return true
                            end
                        }))
                    end
                }
            end
        end
    },
    true
)

SMODS.Joker:take_ownership('j_mr_bones',
    {
        calculate = function(_, card, context)
            if context.game_over and to_big(G.GAME.chips)/G.GAME.blind.chips >= to_big(0.25) and not context.retrigger_joker then
                local effects = {{
                    no_retrigger = true,
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED,
                }}
                if SEALS.has_seal(card, 'Red') then
                    effects[#effects+1] = {
                        message = localize('k_again_ex'),
                        colour = G.C.FILTER
                    }
                    effects[#effects+1] = {
                        message = 'Extra Life!',
                        func = function()
                            SEALS.event(function()
                                local extralife = SMODS.add_card({key = 'j_soe_extralife'})
                                extralife.ability.extra.lives = SEALS.get_seal_count(card, 'Red')
                                return true
                            end)
                        end
                    }
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
    order = 30,
    func = function(self, layer)
        if (self.ability.set ~= 'Joker' and (self.ability.set ~= 'Default' and self.ability.set ~= 'Enhanced')) and self.seal then
            local seal = G.P_SEALS[self.seal] or {}
            if self.ability.delay_seal then return end
            if type(seal.draw) == 'function' then
                seal:draw(self, layer)
            elseif self.seal then
                G.shared_seals[self.seal].role.draw_major = self
                G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

local oldsmodsinjectitems = SMODS.injectItems
function SMODS.injectItems()
    local g = oldsmodsinjectitems()
    G.shared_sleeves = {Plasma = SMODS.create_sprite(0, 0, 71, 95, 'soe_VanillaSleeves', {x = 3, y = 2})}
    G.shared_psyche = SMODS.create_sprite(0, 0, 71, 95, 'soe_Enhancers', {x = 0, y = 1})
    G.shared_jokers = {}
    G.shared_tobefractioned_cards = {}
    G.shared_tobefractioned_blinds = {}
    G.shared_tobefractioned_tags = {}
    G.shared_enhancementsforjokers = {
        m_bonus = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 0, y = 1}),
        m_mult = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 1, y = 1}),
        m_wild = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 2, y = 1}),
        m_lucky = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 3, y = 1}),
        m_glass = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 4, y = 1}),
        m_steel = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 5, y = 1}),
        m_gold = SMODS.create_sprite(0, 0, 71, 95, 'soe_EnhancementsForJokers', {x = 5, y = 0})
    }
    G.shared_indicators = {
        joker = SMODS.create_sprite(0, 0, 71, 95, 'soe_Indicators', {x = 0, y = 0}),
        consumable = SMODS.create_sprite(0, 0, 71, 95, 'soe_Indicators', {x = 1, y = 0}),
        playing_card = SMODS.create_sprite(0, 0, 71, 95, 'soe_Indicators', {x = 2, y = 0})
    }
    for k, v in pairs(G.P_CENTERS) do
        if v.soe_is_planet_joker and v.soe_planet_mod then
            G.localization.descriptions.Joker[v.key].name = localize({type = 'name_text', key = v.soe_planet_key, set = 'Planet'}).." Joker"
            SEALS.parse_loc_txt(G.localization.descriptions.Joker[v.key])
        end
        if v.soe_is_enhancement_joker and v.soe_enhancement_mod then
            G.localization.descriptions.Joker[v.key].name = localize({type = 'name_text', key = v.soe_enhancement_key, set = 'Enhanced'}).." Joker"
            G.localization.descriptions.Joker[v.key].text = G.localization.descriptions.Enhanced[v.soe_enhancement_key].text
            SEALS.parse_loc_txt(G.localization.descriptions.Joker[v.key])
        end
        if v.soe_is_voucher_enhancement and v.soe_voucher_mod then
            G.localization.descriptions.Enhanced[v.key].name = localize({type = 'name_text', key = v.soe_voucher_key, set = 'Voucher'})
            G.localization.descriptions.Enhanced[v.key].text = G.localization.descriptions.Voucher[v.soe_voucher_key].text
            SEALS.parse_loc_txt(G.localization.descriptions.Enhanced[v.key])
        end
        if v.consumeable then
            if v.atlas == 'soe_What' then
                v.set_badges = function(_, _, badges)
                    badges[#badges+1] = create_badge('Art: poundpound0209', SMODS.Gradients.soe_synonym_gradient, HEX('FFFFFF'))
                end
            end
        end
        local rarity = v.rarity
        if rarity == 'soe_basic' or rarity == 'soe_unusual' or rarity == 'soe_unique' or rarity == 'soe_fabled' then
            SMODS.insert_pool(G.P_CENTER_POOLS.soe_SynonymJokers, v)
        end
    end
    for _, v in ipairs(SMODS.Sticker.obj_buffer) do
        local sticker = SMODS.Stickers[v]
        local oldapply = sticker.apply
        sticker.apply = function(self, card, val)
            if val and card.ability[self.key] and SMODS.find_card('j_soe_sealjoker2')[1] then
                card.ability.soe_quantum_stickers = card.ability.soe_quantum_stickers or {}
                card.ability.soe_quantum_stickers[#card.ability.soe_quantum_stickers+1] = self.key
            end
            return oldapply(self, card, val)
        end
    end
    for _, v in ipairs(SMODS.Rarity.obj_buffer) do
        if not tc(SEALS.order_of_rarities, v) then
            SEALS.order_of_rarities[#SEALS.order_of_rarities+1] = v
        end
    end
    SEALS.order_of_rarities_indexed = {}
    for i=1, #SEALS.order_of_rarities do
        SEALS.order_of_rarities_indexed[SEALS.order_of_rarities[i]] = i
    end
    math.randomseed(os.time())
    local seals = {}
    for k in pairs(G.P_SEALS) do
        seals[#seals+1] = k
    end
    local title_seal = seals[math.random(#seals)]
    local localized_seal = true_localize({type = 'name_text', set = 'Other', key = string.lower(title_seal)..'_seal'})
    if localized_seal then
        love.window.setTitle('Balatro: '..localized_seal)
    end
    return g
end

SMODS.DrawStep {
    key = 'secondseals',
    order = 31,
    conditions = { vortex = false, facing = 'front' },
    func = function(self, layer)
        if self.seal and self.ability.soe_quantum_seals and self.ability.soe_quantum_seals[1] then
            local seal = G.P_SEALS[self.ability.soe_quantum_seals[1]] or {}
            if type(seal.draw) == 'function' then
                seal:draw(self, layer)
            elseif self.ability.soe_quantum_seals[1] then
                G.shared_seals[self.ability.soe_quantum_seals[1]].role.draw_major = self
                G.shared_seals[self.ability.soe_quantum_seals[1]]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, nil, 1)
                if self.ability.soe_quantum_seals[1] == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, nil, nil, nil, 1) end
            end
        end
    end
}

SMODS.DrawStep {
    key = 'jokerseals',
    order = 32,
    conditions = {vortex = false, facing = 'front'},
    func = function(self)
        if self.ability.soe_jokerseals and self.ability.soe_jokerseals[1] then
            for i=1, 2 do
                if i == 1 or self.ability.soe_jokerseals[i] then
                    local joker = self.ability.soe_jokerseals[i]
                    if not G.shared_jokers[joker] then
                        G.shared_jokers[joker] = {}
                        if G.P_CENTERS[joker].pos then
                            G.shared_jokers[joker].center = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS[joker].atlas or 'Joker', G.P_CENTERS[joker].pos)
                        end
                        if G.P_CENTERS[joker].soul_pos then
                            G.shared_jokers[joker].floating_sprite = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS[joker].atlas or 'Joker', G.P_CENTERS[joker].soul_pos)
                        end
                        if G.P_CENTERS[joker].soul_pos and G.P_CENTERS[joker].soul_pos.extra then
                            G.shared_jokers[joker].floating_sprite2 = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS[joker].atlas or 'Joker', G.P_CENTERS[joker].soul_pos.extra)
                        end
                    end
                    for _, v in ipairs({'center', 'floating_sprite2', 'floating_sprite'}) do
                        if G.shared_jokers[joker][v] then
                            G.shared_jokers[joker][v].role.draw_major = self
                            G.shared_jokers[joker][v]:draw_shader('dissolve', nil, nil, nil, self.children.center, -0.65, nil, -0.8, i == 1 and -1.4 or 2)
                        end
                    end
                end
            end
        end
    end
}

local function mergeddrawfunc(self, object_type)
    if object_type == Card and self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        local fractions = #self.ability.soe_mergedcards+1
        for i, v in ipairs(self.ability.soe_mergedcards) do
            local key = (v.set == 'Playing Card' and (v.enhancement or '')..v.rank..v.suit) or v.key or 'j_joker'
            if not G.shared_tobefractioned_cards[key] then
                G.shared_tobefractioned_cards[key] = {}
                if G.P_CENTERS[key] then
                    local center = G.P_CENTERS[key]
                    if center.pos then
                        G.shared_tobefractioned_cards[key].center = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, center.atlas or v.set or 'Joker', center.pos)
                    end
                    if center.soul_pos then
                        G.shared_tobefractioned_cards[key].floating_sprite = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, center.atlas or v.set or 'Joker', center.soul_pos)
                        if center.soul_pos.extra then
                            G.shared_tobefractioned_cards[key].floating_sprite2 = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, center.atlas or v.set or 'Joker', center.soul_pos.extra)
                        end
                    end
                end
                if v.set == 'Playing Card' then
                    local center = G.P_CENTERS[v.enhancement or 'c_base']
                    G.shared_tobefractioned_cards[key].center = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, center.atlas or 'centers', center.pos)
                    if not (center.replace_base_card or v.enhancement == 'm_stone') then
                        G.shared_tobefractioned_cards[key].front = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, get_front_spriteinfo(G.P_CARDS[SMODS.Suits[v.suit].card_key..'_'..SMODS.Ranks[v.rank].card_key]))
                    end
                end
            end
            for _, vv in ipairs({'center', 'front', 'seal', 'stickers', 'floating_sprite2', 'floating_sprite'}) do
                local sprite
                if vv == 'seal' then
                    sprite = G.shared_seals[v.seal]
                elseif vv == 'stickers' then
                else
                    sprite = G.shared_tobefractioned_cards[key][vv]
                end
                if sprite then
                    if vv == 'floating_sprite' then
                        local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - fl(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - fl(G.TIMERS.REAL)))^3
                        local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - fl(G.TIMERS.REAL)))^2
                        sprite.role.draw_major = self
                        sprite.pixel_x_range_start = (71/fractions)*i
                        sprite.pixel_x_range_end = (71/fractions)*(i+1)
                        sprite:draw_shader('soe_invisible',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                        sprite:draw_shader('soe_invisible', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
                        if v.edition and G.P_CENTERS[v.edition] and G.P_CENTERS[v.edition].apply_to_float then
                            sprite:draw_shader(G.P_CENTERS[v.edition].shader, nil, nil, nil, self.children.center, scale_mod, rotate_mod)
                        end
                    else
                        SMODS.push_to_stencil_stack(function()
                            sprite.role.draw_major = self
                            sprite.pixel_x_range_start = (71/fractions)*i
                            sprite.pixel_x_range_end = (71/fractions)*(i+1)
                            sprite:draw_shader('soe_invisible', nil, self.ARGS.send_to_shader, nil, self.children.center)
                        end)
                        sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
                        if (vv == 'center' or vv == 'front') then
                            if v.set == 'Voucher' and v.key ~= 'v_antimatter' or v.key and G.P_CENTERS[v.key].vouchershader then
                                sprite:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
                            elseif v.set == 'Booster' or v.set == 'Spectral' or v.key and G.P_CENTERS[v.key].boostershader or v.set == 'soe_Phantom' and self.config.center_key ~= 'c_soe_cannotfinditemwithkeyc_deja_vu' then
                                sprite:draw_shader('booster', nil, self.ARGS.send_to_shader, nil, self.children.center)
                            end
                            if v.edition then
                                sprite:draw_shader(G.P_CENTERS[v.edition].shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
                                if v.edition == 'e_negative' then
                                    sprite:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
                                end
                            end
                            if self.debuff then
                                sprite:draw_shader('debuff', nil, self.ARGS.send_to_shader, nil, self.children.center)
                            end
                            if self.greyed then
                                sprite:draw_shader('played', nil, self.ARGS.send_to_shader, nil, self.children.center)
                            end
                        end
                        SMODS.pop_from_stencil_stack()
                    end
                end
            end
        end
    elseif (object_type == AnimatedSprite or object_type == Blind) and G.GAME.round_resets.soe_mergedblinds then
        local soe_mergedblinds = G.GAME.round_resets.soe_mergedblinds[self.soe_blind_type or G.GAME.blind_on_deck]
        if soe_mergedblinds[1] then
            local fractions = #soe_mergedblinds+1
            for i, v in ipairs(soe_mergedblinds) do
                if not G.shared_tobefractioned_blinds[v] then
                    local center = G.P_BLINDS[v]
                    G.shared_tobefractioned_blinds[v] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, center.atlas or 'blind_chips', center.pos)
                end
                local sprite = G.shared_tobefractioned_blinds[v]
                sprite.role.draw_major = self
                sprite.pixel_x_range_start = (34/fractions)*i
                sprite.pixel_x_range_end = (34/fractions)*(i+1)
                sprite:draw_shader('soe_invisible', nil, nil, nil, self.children.animatedSprite or self)
            end
        end
    elseif object_type == Sprite then
        local tag = self.config.tag
        if tag.ability.soe_mergedtags and tag.ability.soe_mergedtags[1] then
            local fractions = #tag.ability.soe_mergedtags+1
            for i, v in ipairs(tag.ability.soe_mergedtags) do
                if not G.shared_tobefractioned_tags[v] then
                    local center = G.P_TAGS[v]
                    G.shared_tobefractioned_tags[v] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, center.atlas or 'tags', center.pos)
                end
                local sprite = G.shared_tobefractioned_tags[v]
                sprite.role.draw_major = self
                sprite.pixel_x_range_start = (34/fractions)*i
                sprite.pixel_x_range_end = (34/fractions)*(i+1)
                sprite:draw_shader('soe_invisible', nil, nil, nil, self)
            end
        end
    end
end

SMODS.DrawStep {
    key = 'mergedobjects',
    order = 1e309,
    conditions = {vortex = false, facing = 'front'},
    func = function(self)
        mergeddrawfunc(self, Card)
    end
}

local oldcenterdrawstepfunc = SMODS.DrawSteps.center.func
SMODS.DrawSteps.center.func = function(self, ...)
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        SMODS.push_to_stencil_stack(function()
            local center = self.children.center
            center.pixel_x_range_end = 71/(#self.ability.soe_mergedcards+1)
            center:draw_shader('soe_invisible', nil, self.ARGS.send_to_shader)
        end)
    end
    oldcenterdrawstepfunc(self, ...)
end

local oldfrontdrawstepfunc = SMODS.DrawSteps.front.func
SMODS.DrawSteps.front.func = function(self, ...)
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        local front = self.children.front
        if front then
            SMODS.push_to_stencil_stack(function()
                front.pixel_x_range_end = 71/(#self.ability.soe_mergedcards+1)
                front:draw_shader('soe_invisible', nil, self.ARGS.send_to_shader)
            end)
        end
    end
    oldfrontdrawstepfunc(self, ...)
end

local oldothersdrawstepfunc = SMODS.DrawSteps.others.func
SMODS.DrawSteps.others.func = function(self, ...)
    if self.ability.soe_mergedcards and self.ability.soe_mergedcards[1] then
        SMODS.pop_from_stencil_stack()
        if self.children.front then SMODS.pop_from_stencil_stack() end
    end
    oldothersdrawstepfunc(self, ...)
end

local oldblinddraw = Blind.draw
function Blind:draw()
    if not self.states.visible then return end
    oldblinddraw(self)
    mergeddrawfunc(self, Blind)
end

local oldspritedraw = Sprite.draw
function Sprite:draw(...)
    if not self.states.visible then return end
    oldspritedraw(self, ...)
    if self.config and self.config.tag then
        mergeddrawfunc(self, Sprite)
    end
end

local oldanimatedspritedraw = AnimatedSprite.draw
function AnimatedSprite:draw()
    if not self.states.visible then return end
    oldanimatedspritedraw(self)
    if self.soe_blind_type then
        mergeddrawfunc(self, AnimatedSprite)
    end
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
    key = 'enhancementsforjokers',
    order = -8,
    func = function(self)
        if self.ability.soe_legalenhancements and next(self.ability.soe_legalenhancements) then
            local passed = {}
            for k in pairs(self.ability.soe_legalenhancements) do
                if k ~= 'm_stone' and not G.P_CENTERS[k].original_mod and not passed[k] then
                    G.shared_enhancementsforjokers[k].role.draw_major = self
                    G.shared_enhancementsforjokers[k]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                    passed[k] = true
                end
            end
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.DrawStep{
    key = 'sleevesforjokersandplayingcards',
    order = 200,
    func = function(self)
        if self.ability.legallysleeve then
            G.shared_sleeves[self.ability.legallysleeve].role.draw_major = self
            G.shared_sleeves[self.ability.legallysleeve]:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = {vortex = false, facing = 'front'},
}

SMODS.DrawStep{
    key = 'stickersforplayingcards',
    order = 13,
    func = function(self)
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
    func = function(self)
        if (self.seal == 'soe_reverseseal' or ((G and G.GAME and G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_soe_theseal') and self.seal)) and self.facing == 'back' then
            G.shared_seals[self.seal].role.draw_major = self
            G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
        end
    end
}

SMODS.DrawStep{
    key = 'indicators',
    order = -9,
    func = function(self)
        if SEALS.config.indicators then
            if self.config.center.soe_is_planet_joker or self.config.center.soe_is_consumable_joker or self.config.center.soe_is_voucher_joker then
                local sprite = G.shared_indicators.joker
                sprite.role.draw_major = self
                sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            elseif self.config.center.soe_is_joker_enhancement then
                local sprite = G.shared_indicators.playing_card
                sprite.role.draw_major = self
                sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            end
        end
    end
}

SEALS.frozen_inclusions = {
    invis_rounds = true,
    to_do_poker_hand = true,
    caino_xmult = true,
    yorick_discards = true,
    burnt_hand = true,
    loyalty_remaining = true,
    mult = true,
    h_mult = true, 
    h_x_mult = true,
    h_dollars = true,
    p_dollars = true,
    t_mult = true,
    t_chips = true,
    x_mult = true,
    h_chips = true,
    x_chips = true,
    h_x_chips = true,
}

SMODS.Edition {
    key = 'frozen',
    shader = 'frozen',
    extra_cost = 2,
    sound = {sound = 'soe_frozen'},
    apply_to_float = true,
    discovered = true,
    unlocked = true,
    on_apply = function(card)
        if G.STAGE ~= G.STAGES.RUN then return end
        card.ability.soe_frozen_snapshot = {calculate = {}}
        card.ability.soe_frozen_key = card.config.center_key
        card:generate_UIBox_ability_table(true)
        if card.ability.set == 'Joker' then
            local i = 1
            local hand = G.handlist[i]
            repeat
                local context = {cardarea = G.jokers, full_hand = G.play.cards, scoring_hand = G.soe_scoring_hand or {}, scoring_name = hand, poker_hands = {}, joker_main = true}
                for _, v in ipairs(G.handlist) do
                    context.poker_hands[v] = {context.scoring_hand}
                end
                card:calculate_joker(context)
                i=i+1
                hand = G.handlist[i]
            until not hand
        end
        local new_snapshot = {}
        for k in pairs(SEALS.frozen_inclusions) do
            local v = card.ability[k]
            if v ~= nil then
                new_snapshot[k] = copy_table(v)
            end
        end
        for k in pairs(card.config.center.config) do
            if new_snapshot[k] == nil then
                local v = card.ability[k]
                if v ~= nil then
                    new_snapshot[k] = copy_table(v)
                end
            end
        end
        if card.ability.name == 'Temperance' then new_snapshot.money = card.ability.money end
        card.ability.soe_frozen_snapshot.ability = new_snapshot
    end,
    on_remove = function(card)
        card.ability.soe_frozen_snapshot = nil
        card.ability.soe_frozen_key = nil
    end,
    in_pool = function()
        return false
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
    stay_flipped = function(_, area)
        return area == G.hand
    end,
    set_blind = function()
        for _, v in ipairs(SMODS.get_card_areas('jokers')) do
            for _, vv in ipairs(v) do
                if vv.facing == 'front' then
                    vv.soe_flipped_by_theseal = true
                    vv:flip()
                end
            end
        end
    end,
    defeat = function()
        for _, v in ipairs(SMODS.get_card_areas('jokers')) do
            for _, vv in ipairs(v) do
                if vv.soe_flipped_by_theseal then
                    vv.soe_flipped_by_theseal = nil
                    vv:flip()
                end
            end
        end
    end,
    disable = function()
        for _, v in ipairs(SMODS.get_card_areas('jokers')) do
            for _, vv in ipairs(v) do
                if vv.soe_flipped_by_theseal then
                    vv.soe_flipped_by_theseal = nil
                    vv:flip()
                end
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
                return
            end
            print("Highlighted joker is enhanced with:")
            for k, v in pairs(joker.ability.soe_legalenhancements) do
                if v and v[1] then
                    print(localize({type = 'name_text', key = k, set = 'Enhanced'})..' '..#v..' time'..((#v == 1) and '' or 's'))
                end
            end
        end
    end
}