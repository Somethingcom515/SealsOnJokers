SMODS.ConsumableType{
    key = "soe_Phantom",
    primary_colour = HEX('882D33'),
    secondary_colour = HEX('882D33'),
    collection_rows = {4, 5},
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

SMODS.Consumable{
    key = 'cytoplasm',
    set = 'soe_Phantom',
    atlas = 'Synonyms',
    pos = {x = 8, y = 4},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_ectoplasm',
    cost = 4,
    config = {extra = {minus = 1}},
    loc_vars = function(_, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return {vars = {card.ability.extra.minus}}
    end,
    use = function(_, card)
        local editionless_cards = SMODS.Edition:get_edition_cards(G.hand, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_cards, 'cytoplasm')
                eligible_card:set_edition('e_negative')
                G.jokers:change_size(-card.ability.extra.minus)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function()
        return SMODS.Edition:get_edition_cards(G.hand, true)[1]
    end,
}

SMODS.Consumable{
    key = 'sacrifice',
    set = 'soe_Phantom',
    atlas = 'Synonyms',
    pos = {x = 9, y = 4},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_immolate',
    cost = 4,
    config = {extra = {destroy = 5, dollars = 20}},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.destroy, card.ability.extra.dollars}}
    end,
    use = function(_, card)
        local destroyed_cards = {}
        local temp_hand = {}
        for _, _card in ipairs(G.jokers.cards) do if not _card.ability.eternal then temp_hand[#temp_hand+1] = _card end end
        pseudoshuffle(temp_hand, pseudoseed('sacrifice'))
        for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards+1] = temp_hand[i] end
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
            delay = 0.1,
            func = function()
                SMODS.destroy_cards(destroyed_cards)
                return true
            end
        }))
        delay(0.5)
        ease_dollars(card.ability.extra.dollars*#destroyed_cards)
        delay(0.3)
    end,
    can_use = function()
        return G.jokers and G.jokers.cards[1]
    end,
}

SMODS.Consumable{
    key = 'decimal',
    set = 'soe_Phantom',
    atlas = 'Synonyms',
    pos = {x = 2, y = 5},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_hex',
    cost = 4,
    can_use = function()
        return SMODS.Edition:get_edition_cards(G.hand, true)[1]
    end,
    loc_vars = function(_, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
    end,
    use = function(_, card)
        local editionless_cards = SMODS.Edition:get_edition_cards(G.hand, true)
        if editionless_cards[1] then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local destroyed_cards = {}
                    local eligible_card = pseudorandom_element(editionless_cards, pseudoseed('decimal'))
                    eligible_card:set_edition('e_polychrome')
                    for _, v in ipairs(G.hand.cards) do
                        if v ~= eligible_card and not SMODS.is_eternal(v, card) then
                            destroyed_cards[#destroyed_cards+1] = v
                        end
                    end
                    SMODS.destroy_cards(destroyed_cards)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
}

SMODS.Consumable{
    key = 'ghost',
    set = 'soe_Phantom',
    atlas = 'Synonyms',
    pos = {x = 5, y = 5},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_cryptid',
    cost = 4,
    config = {extra = {max_highlighted = 1, cards = 2}},
    loc_vars = function(_, _, card)
        return {vars = {card.ability.extra.cards, card.ability.extra.max_highlighted}}
    end,
    can_use = function(_, card)
        return G.jokers.highlighted[1] and #G.jokers.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(_, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _=1, card.ability.extra.cards do
                    SEALS.copy_card(G.jokers.highlighted[1])
                end
                return true
            end
        }))
    end,
}

SMODS.Consumable{
    key = 'psyche',
    set = 'soe_Phantom',
    atlas = 'Synonyms',
    pos = {x = 2, y = 2},
    unlocked = true,
    discovered = true,
    soe_alternative = 'c_soul',
    cost = 4,
    soul_set = 'soe_Phantom',
    hidden = true,
    can_use = function()
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(_, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({set = 'soe_Infinity'})
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
}

SMODS.Consumable{
    key = 'dejajed',
    set = 'soe_Phantom',
    atlas = 'Confusion',
    pos = {x = 0, y = 0},
    hidden = true,
    soul_set = 'soe_Phantom',
    soul_rate = 0.05,
    soe_alternative = 'c_deja_vu',
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'soe_detach'}
        if not self.can_use(nil, card) then return end
        local conv_card
        for _, v in ipairs(G.I.CARD) do
            if v.highlighted and v ~= card then
                conv_card = v
                break
            end
        end
        info_queue[#info_queue+1] = {set = 'soe_DetachedSeal', key = conv_card.seal}
    end,
    use = function(_, card)
        local conv_card
        for _, v in ipairs(G.I.CARD) do
            if v.highlighted and v ~= card then
                conv_card = v
                break
            end
        end
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
                local oldseal = conv_card.seal
                SEALS.remove_seal(conv_card)
                conv_card:juice_up(0.3, 0.3)
                play_sound('soe_laes_dlog', 1.2, 0.4)
                local detachedseal = Card(conv_card.T.x, conv_card.T.y, G.CARD_W/2.63, G.CARD_H/3.52, nil, G.P_CENTERS.c_base)
                if SEALS.detached_seals[oldseal] and SEALS.detached_seals[oldseal].config then
                    for k, v in pairs(SEALS.detached_seals[oldseal].config) do
                        detachedseal.ability[k] = copy_table(v)
                    end
                end
                detachedseal.ability.set = 'Seal'
                detachedseal.ability.soe_detached_seal = oldseal
                if detachedseal.children.center then detachedseal.children.center:remove() end
                detachedseal.children.center = SMODS.create_sprite(detachedseal.T.x, detachedseal.T.y, detachedseal.T.w, detachedseal.T.h, 'soe_SealsIndividual', {x = ({Red=0,Blue=1,Gold=2,Purple=3})[oldseal], y = 0})
                detachedseal.children.center.states.hover = detachedseal.states.hover
                detachedseal.children.center.states.click = detachedseal.states.click
                detachedseal.children.center.states.drag = detachedseal.states.drag
                detachedseal.children.center.states.collide.can = false
                detachedseal.children.center:set_role({major = detachedseal, role_type = 'Glued', draw_major = detachedseal})
                detachedseal:juice_up(0.3, 0.3)
                G.GAME.soe_detached_seal_keys = G.GAME.soe_detached_seal_keys or {}
                G.GAME.soe_detached_seal_keys[#G.GAME.soe_detached_seal_keys+1] = oldseal
                G.GAME.soe_detached_seals = G.GAME.soe_detached_seals or {}
                G.GAME.soe_detached_seals[#G.GAME.soe_detached_seals+1] = detachedseal
                return true
            end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                conv_card.area:unhighlight_all()
                return true
            end
        }))
    end,
    can_use = function (_, card)
        local highlighted_cards = {}
        for _, v in ipairs(G.I.CARD) do
            if v.highlighted and v ~= card then
                highlighted_cards[#highlighted_cards+1] = v
                if #highlighted_cards > 1 then return false end
            end
        end
        return highlighted_cards[1] and highlighted_cards[1].seal and ({Red=true,Blue=true,Gold=true,Purple=true})[highlighted_cards[1].seal]
    end
}

SMODS.Consumable{
    key = 'cannotfinditemwithkeyc_deja_vu',
    set = 'soe_Phantom',
    atlas = 'Confusion',
    config = {extra = {max_highlighted = 2}},
    pos = {x = 1, y = 0},
    hidden = true,
    soul_set = 'soe_Phantom',
    soul_rate = 0.02,
    soe_alternative = 'c_deja_vu',
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(_, _, card)
        return {vars = {math.max(2, card.ability.extra.max_highlighted)}}
    end,
    use = function(_, card)
        local merged_cards = {}
        local areas = {G.jokers, G.consumeables, G.hand}
        for _, area in ipairs(areas) do
            table.sort(area.highlighted, function(a, b) return a.T.x < b.T.x end)
            for _, v in ipairs(area.highlighted) do
                if v ~= card then
                    merged_cards[#merged_cards+1] = v
                end
            end
        end
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
                SEALS.merge_cards(merged_cards)
                return true
            end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local passed = {}
                for _, v in ipairs(merged_cards) do
                    if v.area and not passed[v.area] then
                        passed[v.area] = true
                        v.area:unhighlight_all()
                    end
                end
                return true
            end
        }))
    end,
    can_use = function(_, card)
        local highlighted_cards = {}
        local areas = {G.jokers, G.consumeables, G.hand}
        for _, area in ipairs(areas) do
            table.sort(area.highlighted, function(a, b) return a.T.x < b.T.x end)
            for _, v in ipairs(area.highlighted) do
                if v ~= card then
                    highlighted_cards[#highlighted_cards+1] = v
                end
            end
        end
        return highlighted_cards[2] and #highlighted_cards <= math.max(2, card.ability.extra.max_highlighted)
    end
}

local ok, https = pcall(require, 'SMODS.https')

if ok then
    local function generate_uuid()
        local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
        return (string.gsub(template, '[xy]', function(c)
            if c == "x" then
                local v = math.random(0, 15)
                return string.format('%x', v)
            else
                local v = math.random(8, 11)
                return string.format('%x', v)
            end
        end))
    end

    local function get_cookie(callback)
        https.asyncRequest('https://eoals771wo5dw0f.m.pipedream.net', function(code, body)
            if code == 200 then
                SEALS.config.javascript_bypass_cookie = JSON.decode(body).cookie
                SMODS.save_mod_config(SEALS)
                if callback then callback() end
            else
                print('Cookie failed: '..code..' '..body)
            end
        end)
    end

    G.FUNCS.soe_exit_request = function()
        if G.soe_CHOOSE_REQUEST then G.soe_CHOOSE_REQUEST:remove() end
        SMODS.add_card({key = 'c_soe_placeholder'}).ability.soe_legitimate = not G.soe_pirated
        G.soe_pirated = nil
    end

    function G.FUNCS.soe_request()
        if G.soe_CHOOSE_REQUEST then G.soe_CHOOSE_REQUEST:remove() end
        local id = generate_uuid()
        local options = {
            method = 'POST',
            headers = {
                ['User-Agent'] = 'Mozilla/5.0 (X11; Linux x86_64; rv:155.0) Gecko/20100101 Firefox/155.0'
            },
            data = JSON.encode({
                request_id = id,
                request = G.soe_ENTERED_REQUEST,
                pirated = G.soe_pirated,
                rarity = G.soe_ENTERED_REQUEST_RARITY,
                public = G.soe_ENTERED_REQUEST_PUBLIC,
                username = G.soe_ENTERED_REQUEST_USERNAME
            })
        }
        local function callback()
            options.headers['Cookie'] = SEALS.config.javascript_bypass_cookie
            https.asyncRequest('https://sealsoneverything.great-site.net/submit', options, function(code, body)
                if code == 200 then
                    if body:find('<html>') then
                        if not G.soe_gotten_cookie then
                            G.soe_gotten_cookie = true
                            get_cookie(callback)
                        else
                            print('Cookie doesn\'t work')
                        end
                        return
                    end
                    G.soe_gotten_cookie = nil
                    SEALS.joker_request_check_interval = 60
                    local json = JSON.decode(body)
                    SEALS.config.joker_requests[id] = json.result
                    SMODS.save_mod_config(SEALS)
                elseif code == 403 then
                    SEALS.joker_request_check_interval = 3600
                    print('You are blocked')
                else
                    print('Submission failed: '..code..' '..body)
                    SMODS.add_card({key = 'c_soe_placeholder'}).ability.soe_legitimate = not G.soe_pirated
                end
                G.soe_pirated = nil
                save_run()
            end)
        end
        if SEALS.config.javascript_bypass_cookie then
            callback()
        else
            get_cookie(callback)
        end
    end

    local oldcreateuiboxnotifyalert = create_UIBox_notify_alert
    function create_UIBox_notify_alert(a, _type)
        if _type == 'soe_request_completion' then
            G.soe_request_result = true
            _type = 'Joker'
        elseif _type == 'soe_request_rejected' then
            G.soe_request_result = false
            _type = 'Joker'
        elseif _type == 'soe_request_fixed' then
            G.soe_request_fixed = true
            _type = 'Joker'
        end
        local g = oldcreateuiboxnotifyalert(a, _type)
        G.soe_request_result = nil
        G.soe_request_fixed = nil
        return g
    end

    function G.FUNCS.soe_update_request_rarity(args)
        G.soe_ENTERED_REQUEST_RARITY = args.to_val
    end

    function SEALS.create_UIBox_enter_request()
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                G.REFRESH_ALERTS = true
                return true
            end,
        }))
        local t = create_UIBox_generic_options({
            back_func = 'soe_exit_request',
            colour = HEX("04200c"),
            outline_colour = G.C.DARK_EDITION,
            contents = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        create_text_input({
                            id = 'soe_enter_request_input',
                            colour = G.C.DARK_EDITION,
                            hooked_colour = darken(copy_table(G.C.DARK_EDITION), 0.3),
                            w = 4.5,
                            h = 1,
                            max_length = 1000,
                            extended_corpus = true,
                            prompt_text = "Enter request",
                            ref_table = G,
                            ref_value = "soe_ENTERED_REQUEST",
                            keyboard_offset = 1,
                        }),
                    },
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        create_option_cycle({
                            label = 'Rarity',
                            colour = G.C.DARK_EDITION,
                            options = {'Common', 'Uncommon', 'Rare', 'Legendary', 'Random', 'You can choose'},
                            current_option = 1,
                            w = 6,
                            scale = 0.8,
                            text_scale = 0.5,
                            opt_callback = 'soe_update_request_rarity'
                        })
                    },
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        create_toggle({
                            label = 'Allow other players to see this Joker',
                            active_colour = G.C.DARK_EDITION,
                            ref_table = G,
                            ref_value = 'soe_ENTERED_REQUEST_PUBLIC',
                            callback = function() end
                        })
                    },
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        create_text_input({
                            id = 'soe_enter_username_input',
                            colour = G.C.DARK_EDITION,
                            hooked_colour = darken(copy_table(G.C.DARK_EDITION), 0.3),
                            w = 4.5,
                            h = 1,
                            max_length = 20,
                            extended_corpus = true,
                            prompt_text = "Enter username (Optional)",
                            ref_table = G,
                            ref_value = "soe_ENTERED_REQUEST_USERNAME",
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
                            button = "soe_request",
                            label = {"Send Request"},
                            minw = 4.5,
                            focus_args = { snap_to = true },
                        }),
                    },
                },
            },
        })
        return t
    end

    function G.FUNCS.soe_enter_request()
        G.soe_ENTERED_REQUEST = ''
        G.soe_ENTERED_REQUEST_RARITY = 'Common'
        G.soe_ENTERED_REQUEST_PUBLIC = false
        G.soe_ENTERED_REQUEST_USERNAME = ''
        G.soe_CHOOSE_REQUEST = UIBox({
            definition = SEALS.create_UIBox_enter_request(),
            config = {
                align = "cm",
                offset = { x = 0, y = 10 },
                major = G.ROOM_ATTACH,
                bond = "Weak",
                instance_type = "POPUP",
            },
        })
        G.soe_CHOOSE_REQUEST.alignment.offset.y = 0
        G.ROOM.jiggle = G.ROOM.jiggle + 1
        G.soe_CHOOSE_REQUEST:align_to_major()
    end

    SMODS.Consumable{
        key = 'placeholder',
        set = 'soe_Phantom',
        atlas = 'Confusion',
        pos = {x = 3, y = 0},
        hidden = true,
        soul_set = 'soe_Phantom',
        soul_rate = 0.01,
        unlocked = true,
        discovered = true,
        select_card = 'consumeables',
        use = function(_, card)
            G.soe_pirated = not card.ability.soe_legitimate
            G.FUNCS.soe_enter_request()
        end,
        can_use = function()
            return G.soe_rules_read
        end
    }
end

SMODS.DrawStep {
    key = 'psychesoul',
    order = 50,
    func = function(self)
        if self.config.center_key == 'c_soe_psyche' and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.05 + 0.05*math.sin(1.8*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            G.shared_psyche.role.draw_major = self
            G.shared_psyche:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
            G.shared_psyche:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}