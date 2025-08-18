function SEALS.get_vanilla_joker_return(key, context, fake_card)
    local self = fake_card
    if not self.ability.mult then
        self.ability.mult = 0
    end
    if not self.ability.x_mult then
        self.ability.x_mult = 1
    end
    if not self.ability.t_mult then
        self.ability.t_mult = 0
    end
    if not self.ability.t_chips then
        self.ability.t_chips = 0
    end
    if not self.ability.t_chips then
        self.ability.t_chips = 0
    end
    if self.ability.name == 'Yorick' and not self.ability.yorick_discards then 
        self.ability.yorick_discards = self.ability.extra.discards
    end
    if self.ability.name == 'Steel Joker' and not self.ability.steel_tally then
        self.ability.steel_tally = 0
    end
    if self.ability.name == "Stone Joker" and not self.ability.stone_tally then
        self.ability.stone_tally = 0
    end
    if self.ability.name == 'Caino' and not self.ability.caino_xmult then
        self.ability.caino_xmult = 1
    end
    if self.ability.extra and type(self.ability.extra) == "table" and self.ability.extra.s_mult then
        self.ability.effect = "Suit Mult"
    end
    if self.ability.set == "Joker" then
        if self.ability.name == "Blueprint" then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == self then other_joker = G.jokers.cards[i + 1] end
            end
            if other_joker and other_joker ~= self and not context.no_blueprint then
                if (context.blueprint or 0) > #G.jokers.cards then return end
                local old_context_blueprint = context.blueprint
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                local old_context_blueprint_card = context.blueprint_card
                context.blueprint_card = context.blueprint_card or self
                local eff_card = context.blueprint_card
                local other_joker_ret = other_joker:calculate_joker(context)
                context.blueprint = old_context_blueprint
                context.blueprint_card = old_context_blueprint_card
                if other_joker_ret then
                    other_joker_ret.card = eff_card
                    other_joker_ret.colour = G.C.BLUE
                    return other_joker_ret
                end
            end
        end
        if self.ability.name == "Brainstorm" then
            local other_joker = G.jokers.cards[1]
            if other_joker and other_joker ~= self and not context.no_blueprint then
                if (context.blueprint or 0) > #G.jokers.cards then return end
                local old_context_blueprint = context.blueprint
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                local old_context_blueprint_card = context.blueprint_card
                context.blueprint_card = context.blueprint_card or self
                local eff_card = context.blueprint_card
                local other_joker_ret = other_joker:calculate_joker(context)
                context.blueprint = old_context_blueprint
                context.blueprint_card = old_context_blueprint_card
                if other_joker_ret then
                    other_joker_ret.card = eff_card
                    other_joker_ret.colour = G.C.RED
                    return other_joker_ret
                end
            end
        end
        if context.open_booster then
            if self.ability.name == 'Hallucination' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                if pseudorandom('halu' .. G.GAME.round_resets.ante) < G.GAME.probabilities.normal / self.ability.extra then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'hal')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_plus_tarot'), colour = G.C.PURPLE })
                    return nil, true
                end
            end
        elseif context.buying_card then

        elseif context.selling_self then
            if self.ability.name == 'Luchador' then
                if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then
                    card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                        { message = localize('ph_boss_disabled') })
                    G.GAME.blind:disable()
                    return nil, true
                end
            end
            if self.ability.name == 'Diet Cola' then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_double'))
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end)
                }))
                return nil, true
            end
            if self.ability.name == 'Invisible Joker' and (self.ability.invis_rounds >= self.ability.extra) and not context.blueprint then
                local eval = function(card) return (card.ability.loyalty_remaining == 0) and not G.RESET_JIGGLES end
                juice_card_until(self, eval, true)
                local jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= self then
                        jokers[#jokers + 1] = G.jokers.cards[i]
                    end
                end
                if #jokers > 0 then
                    if #G.jokers.cards <= G.jokers.config.card_limit then
                        card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                            { message = localize('k_duplicated_ex') })
                        local chosen_joker = pseudorandom_element(jokers, pseudoseed('invisible'))
                        local card = copy_card(chosen_joker, nil, nil, nil,
                            chosen_joker.edition and chosen_joker.edition.negative)
                        if card.ability.invis_rounds then card.ability.invis_rounds = 0 end
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        return nil, true
                    else
                        card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                            { message = localize('k_no_room_ex') })
                    end
                else
                    card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                        { message = localize('k_no_other_jokers') })
                end
            end
        elseif context.selling_card then
            if self.ability.name == 'Campfire' and not context.blueprint then
                self.ability.x_mult = self.ability.x_mult + self.ability.extra
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            { message = localize('k_upgrade_ex') }); return true
                    end
                }))
            end
            if self.ability.name == 'Campfire' and not context.blueprint then return nil, true end
        elseif context.reroll_shop then
            if self.ability.name == 'Flash Card' and not context.blueprint then
                self.ability.mult = self.ability.mult + self.ability.extra
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            { message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } }, colour =
                            G.C.MULT })
                        return true
                    end)
                }))
            end
            if self.ability.name == 'Flash Card' and not context.blueprint then return nil, true end
        elseif context.ending_shop then
            if self.ability.name == 'Perkeo' then
                if G.consumeables.cards[1] then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = copy_card(pseudorandom_element(G.consumeables.cards, pseudoseed('perkeo')), nil)
                            card:set_edition({ negative = true }, true)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end
                    }))
                    card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                        { message = localize('k_duplicated_ex') })
                    return nil, true
                end
                return
            end
            return
        elseif context.skip_blind then
            if self.ability.name == 'Throwback' and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil, {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } },
                            colour = G.C.RED,
                            card = self
                        })
                        return true
                    end
                }))
                return nil, true
            end
            return
        elseif context.skipping_booster then
            if self.ability.name == 'Red Card' and not context.blueprint then
                self.ability.mult = self.ability.mult + self.ability.extra
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil, {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra } },
                            colour = G.C.RED,
                            delay = 0.45,
                            card = self
                        })
                        return true
                    end
                }))
                return nil, true
            end
            return
        elseif context.playing_card_added and not self.getting_sliced then
            if self.ability.name == 'Hologram' and (not context.blueprint)
                and context.cards and context.cards[1] then
                self.ability.x_mult = self.ability.x_mult + #context.cards * self.ability.extra
                card_eval_status_text(self, 'extra', nil, nil, nil,
                    { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } } })
                return nil, true
            end
        elseif context.first_hand_drawn then
            if self.ability.name == 'Certificate' then
                local _card = create_playing_card({
                    front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr')),
                    center = G.P_CENTERS.c_base
                }, G.discard, true, nil, { G.C.SECONDARY_SET.Enhanced }, true)
                _card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'certsl' }))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context_blueprint_card then context_blueprint_card:juice_up() else self:juice_up() end
                        return true
                    end
                }))
                playing_card_joker_effects({ _card })

                return nil, true
            end
            if self.ability.name == 'DNA' and not context.blueprint then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(self, eval, true)
            end
            if self.ability.name == 'Trading Card' and not context.blueprint then
                local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
                juice_card_until(self, eval, true)
            end
        elseif context.setting_blind and not self.getting_sliced then
            if self.ability.name == 'Chicot' and not context.blueprint
                and context.blind.boss and not self.getting_sliced then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                delay(0.4)
                                return true
                            end
                        }))
                        card_eval_status_text(self, 'extra', nil, nil, nil, { message = localize('ph_boss_disabled') })
                        return true
                    end
                }))
                return nil, true
            end
            if self.ability.name == 'Madness' and not context.blueprint and not context.blind.boss then
                self.ability.x_mult = self.ability.x_mult + self.ability.extra
                local destructable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= self and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers + 1] =
                        G.jokers.cards[i] end
                end
                local joker_to_destroy = #destructable_jokers > 0 and
                pseudorandom_element(destructable_jokers, pseudoseed('madness')) or nil

                if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            (context.blueprint_card or self):juice_up(0.8, 0.8)
                            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                            return true
                        end
                    }))
                end
                if not (context.blueprint_card or self).getting_sliced then
                    card_eval_status_text((context.blueprint_card or self), 'extra', nil, nil, nil,
                        { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } } })
                end
                return nil, true
            end
            if self.ability.name == 'Burglar' and not (context.blueprint_card or self).getting_sliced then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_discard(-G.GAME.current_round.discards_left, nil, true)
                        ease_hands_played(self.ability.extra)
                        card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                            { message = localize { type = 'variable', key = 'a_hands', vars = { self.ability.extra } } })
                        return true
                    end
                }))
                return nil, true
            end
            if self.ability.name == 'Riff-raff' and not (context.blueprint_card or self).getting_sliced and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local jokers_to_create = math.min(2, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, jokers_to_create do
                            local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'rif')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
                card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                    { message = localize('k_plus_joker'), colour = G.C.BLUE })
                return nil, true
            end
            if self.ability.name == 'Cartomancer' and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'car')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                            { message = localize('k_plus_tarot'), colour = G.C.PURPLE })
                        return true
                    end)
                }))
                return nil, true
            end
            if self.ability.name == 'Ceremonial Dagger' and not context.blueprint then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == self then
                        my_pos = i; break
                    end
                end
                if my_pos and G.jokers.cards[my_pos + 1] and not self.getting_sliced and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                    local sliced_card = G.jokers.cards[my_pos + 1]
                    sliced_card.getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.joker_buffer = 0
                            self.ability.mult = self.ability.mult + sliced_card.sell_cost * 2
                            self:juice_up(0.8, 0.8)
                            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            return true
                        end
                    }))
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult + 2 * sliced_card.sell_cost } }, colour =
                        G.C.RED, no_juice = true })
                    return nil, true
                end
            end
            if self.ability.name == 'Marble Joker' and not (context.blueprint_card or self).getting_sliced then
                local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local card = Card(G.discard.T.x + G.discard.T.w / 2, G.discard.T.y, G.CARD_W, G.CARD_H, front,
                    G.P_CENTERS.m_stone, { playing_card = G.playing_card })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                        G.play:emplace(card)
                        table.insert(G.playing_cards, card)
                        return true
                    end
                }))
                card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                    { message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced })

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, 'up', nil)

                playing_card_joker_effects({ card })
                return nil, true
            end
            return
        elseif context.destroying_card and not context.blueprint then
            if self.ability.name == 'Sixth Sense' and #context.full_hand == 1 and context.full_hand[1]:get_id() == 6 and G.GAME.current_round.hands_played == 0 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'sixth')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                        { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
                end
                return true
            end
            return nil
        elseif context.cards_destroyed then
            if self.ability.name == 'Caino' and not context.blueprint then
                local faces = 0
                for k, v in ipairs(context.glass_shattered) do
                    if v:is_face() then
                        faces = faces + 1
                    end
                end
                if faces > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    self.ability.caino_xmult = self.ability.caino_xmult + faces * self.ability.extra
                                    return true
                                end
                            }))
                            card_eval_status_text(self, 'extra', nil, nil, nil,
                                { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.caino_xmult + faces * self.ability.extra } } })
                            return true
                        end
                    }))
                end

                return
            end
            if self.ability.name == 'Glass Joker' and not context.blueprint then
                local glasses = 0
                for k, v in ipairs(context.glass_shattered) do
                    if v.shattered then
                        glasses = glasses + 1
                    end
                end
                if glasses > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    self.ability.x_mult = self.ability.x_mult + self.ability.extra * glasses
                                    return true
                                end
                            }))
                            card_eval_status_text(self, 'extra', nil, nil, nil,
                                { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult + self.ability.extra * glasses } } })
                            return true
                        end
                    }))
                end

                return
            end
        elseif context.remove_playing_cards then
            if self.ability.name == 'Caino' and not context.blueprint then
                local face_cards = 0
                for k, val in ipairs(context.removed) do
                    if val:is_face() then face_cards = face_cards + 1 end
                end
                if face_cards > 0 then
                    self.ability.caino_xmult = self.ability.caino_xmult + face_cards * self.ability.extra
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(self, 'extra', nil, nil, nil,
                                { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.caino_xmult } } }); return true
                        end
                    }))
                    return nil, true
                end
                return
            end

            if self.ability.name == 'Glass Joker' and not context.blueprint then
                local glass_cards = 0
                for k, val in ipairs(context.removed) do
                    if val.shattered then glass_cards = glass_cards + 1 end
                end
                if glass_cards > 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    self.ability.x_mult = self.ability.x_mult + self.ability.extra * glass_cards
                                    return true
                                end
                            }))
                            card_eval_status_text(self, 'extra', nil, nil, nil,
                                { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult + self.ability.extra * glass_cards } } })
                            return true
                        end
                    }))
                    return nil, true
                end
                return
            end
        elseif context.using_consumeable then
            if self.ability.name == 'Glass Joker' and not context.blueprint and context.consumeable.ability.name == 'The Hanged Man' then
                local shattered_glass = 0
                for k, val in ipairs(G.hand.highlighted) do
                    if SMODS.has_enhancement(val, 'm_glass') then shattered_glass = shattered_glass + 1 end
                end
                if shattered_glass > 0 then
                    self.ability.x_mult = self.ability.x_mult + self.ability.extra * shattered_glass
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(self, 'extra', nil, nil, nil,
                                { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } } }); return true
                        end
                    }))
                    return nil, true
                end
                return
            end
            if self.ability.name == 'Fortune Teller' and not context.blueprint and (context.consumeable.ability.set == "Tarot") then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            { message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.consumeable_usage_total.tarot } } }); return true
                    end
                }))
                return nil, true
            end
            if self.ability.name == 'Constellation' and not context.blueprint and context.consumeable.ability.set == 'Planet' then
                self.ability.x_mult = self.ability.x_mult + self.ability.extra
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            { message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } } }); return true
                    end
                }))
                return
                    nil, true
            end
            return
        elseif context.debuffed_hand then
            if self.ability.name == 'Matador' then
                if G.GAME.blind.triggered then
                    ease_dollars(self.ability.extra)
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + self.ability.extra
                    G.E_MANAGER:add_event(Event({ func = (function()
                        G.GAME.dollar_buffer = 0; return true
                    end) }))
                    return {
                        message = localize('$') .. self.ability.extra,
                        colour = G.C.MONEY
                    }
                end
            end
        elseif context.pre_discard then
            if self.ability.name == 'Burnt Joker' and G.GAME.current_round.discards_used <= 0 and not context.hook then
                local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                    { message = localize('k_upgrade_ex') })
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                    { handname = localize(text, 'poker_hands'), chips = G.GAME.hands[text].chips, mult = G.GAME.hands
                    [text].mult, level = to_big(G.GAME.hands[text].level)})
                level_up_hand(context.blueprint_card or self, text, nil, 1)
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                    { mult = 0, chips = 0, handname = '', level = '' })
                return nil, true
            end
        elseif context.discard then
            if self.ability.name == 'Ramen' and not context.blueprint then
                if self.ability.x_mult - self.ability.extra <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            self.T.r = -0.2
                            self:juice_up(0.3, 0.4)
                            self.states.drag.is = true
                            self.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(self)
                                    self:remove()
                                    self = nil
                                    return true;
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                        card = self,
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                else
                    self.ability.x_mult = self.ability.x_mult - self.ability.extra
                    return {
                        delay = 0.2,
                        card = self,
                        message = localize { type = 'variable', key = 'a_xmult_minus', vars = { self.ability.extra } },
                        colour = G.C.RED
                    }
                end
            end
            if self.ability.name == 'Yorick' and not context.blueprint then
                if self.ability.yorick_discards <= 1 then
                    self.ability.yorick_discards = self.ability.extra.discards
                    self.ability.x_mult = self.ability.x_mult + self.ability.extra.xmult
                    return {
                        card = self,
                        delay = 0.2,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } },
                        colour = G.C.RED
                    }
                else
                    self.ability.yorick_discards = self.ability.yorick_discards - 1
                    return nil, true
                end
                return
            end
            if self.ability.name == 'Trading Card' and not context.blueprint and
                G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
                ease_dollars(self.ability.extra)
                return {
                    message = localize('$') .. self.ability.extra,
                    colour = G.C.MONEY,
                    delay = 0.45,
                    remove = true,
                    card = self
                }
            end

            if self.ability.name == 'Castle' and
                not context.other_card.debuff and
                context.other_card:is_suit(G.GAME.current_round.castle_card.suit) and not context.blueprint then
                self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod

                return {
                    message = localize('k_upgrade_ex'),
                    card = self,
                    colour = G.C.CHIPS
                }
            end
            if self.ability.name == 'Mail-In Rebate' and
                not context.other_card.debuff and
                context.other_card:get_id() == G.GAME.current_round.mail_card.id then
                ease_dollars(self.ability.extra)
                return {
                    message = localize('$') .. self.ability.extra,
                    colour = G.C.MONEY,
                    card = self
                }
            end
            if self.ability.name == 'Hit the Road' and
                not context.other_card.debuff and
                context.other_card:get_id() == 11 and not context.blueprint then
                self.ability.x_mult = self.ability.x_mult + self.ability.extra
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } },
                    colour = G.C.RED,
                    delay = 0.45,
                    card = self
                }
            end
            if self.ability.name == 'Green Joker' and not context.blueprint and context.other_card == context.full_hand[#context.full_hand] then
                local prev_mult = self.ability.mult
                self.ability.mult = math.max(0, self.ability.mult - self.ability.extra.discard_sub)
                if self.ability.mult ~= prev_mult then
                    return {
                        message = localize { type = 'variable', key = 'a_mult_minus', vars = { self.ability.extra.discard_sub } },
                        colour = G.C.RED,
                        card = self
                    }
                end
            end

            if self.ability.name == 'Faceless Joker' and context.other_card == context.full_hand[#context.full_hand] then
                local face_cards = 0
                for k, v in ipairs(context.full_hand) do
                    if v:is_face() then face_cards = face_cards + 1 end
                end
                if face_cards >= self.ability.extra.faces then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_dollars(self.ability.extra.dollars)
                            card_eval_status_text(context_blueprint_card or self, 'extra', nil, nil, nil,
                                { message = localize('$') .. self.ability.extra.dollars, colour = G.C.MONEY, delay = 0.45 })
                            return true
                        end
                    }))
                    return
                        nil, true
                end
            end
            return
        elseif context.end_of_round then
            if context.individual then

            elseif context.repetition then
                if context.cardarea == G.hand then
                    if self.ability.name == 'Mime' and
                        (next(context.card_effects[1]) or #context.card_effects > 1) then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = self.ability.extra,
                            card = self
                        }
                    end
                end
            elseif not context.blueprint then
                if self.ability.name == 'Campfire' and G.GAME.blind.boss and self.ability.x_mult > 1 then
                    self.ability.x_mult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    }
                end
                if self.ability.name == 'Rocket' and G.GAME.blind.boss then
                    self.ability.extra.dollars = self.ability.extra.dollars + self.ability.extra.increase
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MONEY
                    }
                end
                if self.ability.name == 'Turtle Bean' and not context.blueprint then
                    if self.ability.extra.h_size - self.ability.extra.h_mod <= 0 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                self.T.r = -0.2
                                self:juice_up(0.3, 0.4)
                                self.states.drag.is = true
                                self.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                        G.jokers:remove_card(self)
                                        self:remove()
                                        self = nil
                                        return true;
                                    end
                                }))
                                return true
                            end
                        }))
                        return {
                            card = self,
                            message = localize('k_eaten_ex'),
                            colour = G.C.FILTER
                        }
                    else
                        self.ability.extra.h_size = self.ability.extra.h_size - self.ability.extra.h_mod
                        G.hand:change_size(-self.ability.extra.h_mod)
                        return {
                            message = localize { type = 'variable', key = 'a_handsize_minus', vars = { self.ability.extra.h_mod } },
                            colour = G.C.FILTER
                        }
                    end
                end
                if self.ability.name == 'Invisible Joker' and not context.blueprint then
                    self.ability.invis_rounds = self.ability.invis_rounds + 1
                    if self.ability.invis_rounds == self.ability.extra then
                        local eval = function(card) return not card.REMOVED end
                        juice_card_until(self, eval, true)
                    end
                    return {
                        message = (self.ability.invis_rounds < self.ability.extra) and
                        (self.ability.invis_rounds .. '/' .. self.ability.extra) or localize('k_active_ex'),
                        colour = G.C.FILTER
                    }
                end
                if self.ability.name == 'Popcorn' and not context.blueprint then
                    if self.ability.mult - self.ability.extra <= 0 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                self.T.r = -0.2
                                self:juice_up(0.3, 0.4)
                                self.states.drag.is = true
                                self.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                        G.jokers:remove_card(self)
                                        self:remove()
                                        self = nil
                                        return true;
                                    end
                                }))
                                return true
                            end
                        }))
                        return {
                            message = localize('k_eaten_ex'),
                            colour = G.C.RED
                        }
                    else
                        self.ability.mult = self.ability.mult - self.ability.extra
                        return {
                            message = localize { type = 'variable', key = 'a_mult_minus', vars = { self.ability.extra } },
                            colour = G.C.MULT
                        }
                    end
                end
                if self.ability.name == 'To Do List' and not context.blueprint then
                    local _poker_hands = {}
                    for k, v in pairs(G.GAME.hands) do
                        if v.visible and k ~= self.ability.to_do_poker_hand then _poker_hands[#_poker_hands + 1] = k end
                    end
                    self.ability.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('to_do'))
                    return {
                        message = localize('k_reset')
                    }
                end
                if self.ability.name == 'Egg' then
                    self.ability.extra_value = self.ability.extra_value + self.ability.extra
                    self:set_cost()
                    return {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
                end
                if self.ability.name == 'Gift Card' then
                    for k, v in ipairs(G.jokers.cards) do
                        if v.set_cost then
                            v.ability.extra_value = (v.ability.extra_value or 0) + self.ability.extra
                            v:set_cost()
                        end
                    end
                    for k, v in ipairs(G.consumeables.cards) do
                        if v.set_cost then
                            v.ability.extra_value = (v.ability.extra_value or 0) + self.ability.extra
                            v:set_cost()
                        end
                    end
                    return {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
                end
                if self.ability.name == 'Hit the Road' and self.ability.x_mult > 1 then
                    self.ability.x_mult = 1
                    return {
                        message = localize('k_reset'),
                        colour = G.C.RED
                    }
                end

                if self.ability.name == 'Gros Michel' or self.ability.name == 'Cavendish' then
                    if pseudorandom(self.ability.name == 'Cavendish' and 'cavendish' or 'gros_michel') < G.GAME.probabilities.normal / self.ability.extra.odds then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                self.T.r = -0.2
                                self:juice_up(0.3, 0.4)
                                self.states.drag.is = true
                                self.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                        G.jokers:remove_card(self)
                                        self:remove()
                                        self = nil
                                        return true;
                                    end
                                }))
                                return true
                            end
                        }))
                        if self.ability.name == 'Gros Michel' then G.GAME.pool_flags.gros_michel_extinct = true end
                        return {
                            message = localize('k_extinct_ex')
                        }
                    else
                        return {
                            message = localize('k_safe_ex')
                        }
                    end
                end
                if self.ability.name == 'Mr. Bones' and context.game_over and
                    to_big(G.GAME.chips) / to_big(G.GAME.blind.chips) >= to_big(0.25) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand_text_area.blind_chips:juice_up()
                            G.hand_text_area.game_chips:juice_up()
                            play_sound('tarot1')
                            self:start_dissolve()
                            return true
                        end
                    }))
                    return {
                        message = localize('k_saved_ex'),
                        saved = true,
                        colour = G.C.RED
                    }
                end
            end
        elseif context.individual then
            if context.cardarea == G.play then
                if self.ability.name == 'Hiker' then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + self.ability.extra
                    return {
                        extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                        colour = G.C.CHIPS,
                        card = self
                    }
                end
                if self.ability.name == 'Lucky Cat' and context.other_card.lucky_trigger and not context.blueprint then
                    self.ability.x_mult = self.ability.x_mult + self.ability.extra
                    return {
                        extra = { focus = self, message = localize('k_upgrade_ex'), colour = G.C.MULT },
                        card = self
                    }
                end
                if self.ability.name == 'Wee Joker' and
                    context.other_card:get_id() == 2 and not context.blueprint then
                    self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod

                    return {
                        extra = { focus = self, message = localize('k_upgrade_ex') },
                        card = self,
                        colour = G.C.CHIPS
                    }
                end
                if self.ability.name == 'Photograph' then
                    local first_face = nil
                    for i = 1, #context.scoring_hand do
                        if context.scoring_hand[i]:is_face() then
                            first_face = context.scoring_hand[i]; break
                        end
                    end
                    if context.other_card == first_face then
                        return {
                            x_mult = self.ability.extra,
                            colour = G.C.RED,
                            card = self
                        }
                    end
                end
                if self.ability.name == '8 Ball' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    if (context.other_card:get_id() == 8) and (pseudorandom('8ball') < G.GAME.probabilities.normal / self.ability.extra) then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        return {
                            extra = {
                                focus = self,
                                message = localize('k_plus_tarot'),
                                func = function()
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'before',
                                        delay = 0.0,
                                        func = (function()
                                            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil,
                                                '8ba')
                                            card:add_to_deck()
                                            G.consumeables:emplace(card)
                                            G.GAME.consumeable_buffer = 0
                                            return true
                                        end)
                                    }))
                                end
                            },
                            colour = G.C.SECONDARY_SET.Tarot,
                            card = self
                        }
                    end
                end
                if self.ability.name == 'The Idol' and
                    context.other_card:get_id() == G.GAME.current_round.idol_card.id and
                    context.other_card:is_suit(G.GAME.current_round.idol_card.suit) then
                    return {
                        x_mult = self.ability.extra,
                        colour = G.C.RED,
                        card = self
                    }
                end
                if self.ability.name == 'Scary Face' and (
                        context.other_card:is_face()) then
                    return {
                        chips = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Smiley Face' and (
                        context.other_card:is_face()) then
                    return {
                        mult = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Golden Ticket' and
                    SMODS.has_enhancement(context.other_card, 'm_gold') then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + self.ability.extra
                    G.E_MANAGER:add_event(Event({ func = (function()
                        G.GAME.dollar_buffer = 0; return true
                    end) }))
                    return {
                        dollars = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Scholar' and
                    context.other_card:get_id() == 14 then
                    return {
                        chips = self.ability.extra.chips,
                        mult = self.ability.extra.mult,
                        card = self
                    }
                end
                if self.ability.name == 'Walkie Talkie' and
                    (context.other_card:get_id() == 10 or context.other_card:get_id() == 4) then
                    return {
                        chips = self.ability.extra.chips,
                        mult = self.ability.extra.mult,
                        card = self
                    }
                end
                if self.ability.name == 'Business Card' and
                    context.other_card:is_face() and
                    pseudorandom('business') < G.GAME.probabilities.normal / self.ability.extra then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 2
                    G.E_MANAGER:add_event(Event({ func = (function()
                        G.GAME.dollar_buffer = 0; return true
                    end) }))
                    return {
                        dollars = 2,
                        card = self
                    }
                end
                if self.ability.name == 'Fibonacci' and (
                        context.other_card:get_id() == 2 or
                        context.other_card:get_id() == 3 or
                        context.other_card:get_id() == 5 or
                        context.other_card:get_id() == 8 or
                        context.other_card:get_id() == 14) then
                    return {
                        mult = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Even Steven' and
                    context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0 and
                    context.other_card:get_id() % 2 == 0
                then
                    return {
                        mult = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Odd Todd' and
                    ((context.other_card:get_id() <= 10 and
                            context.other_card:get_id() >= 0 and
                            context.other_card:get_id() % 2 == 1) or
                        (context.other_card:get_id() == 14))
                then
                    return {
                        chips = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.effect == 'Suit Mult' and
                    context.other_card:is_suit(self.ability.extra.suit) then
                    return {
                        mult = self.ability.extra.s_mult,
                        card = self
                    }
                end
                if self.ability.name == 'Rough Gem' and
                    context.other_card:is_suit("Diamonds") then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + self.ability.extra
                    G.E_MANAGER:add_event(Event({ func = (function()
                        G.GAME.dollar_buffer = 0; return true
                    end) }))
                    return {
                        dollars = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Onyx Agate' and
                    context.other_card:is_suit("Clubs") then
                    return {
                        mult = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Arrowhead' and
                    context.other_card:is_suit("Spades") then
                    return {
                        chips = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Bloodstone' and
                    context.other_card:is_suit("Hearts") and
                    pseudorandom('bloodstone') < G.GAME.probabilities.normal / self.ability.extra.odds then
                    return {
                        x_mult = self.ability.extra.Xmult,
                        card = self
                    }
                end
                if self.ability.name == 'Ancient Joker' and
                    context.other_card:is_suit(G.GAME.current_round.ancient_card.suit) then
                    return {
                        x_mult = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Triboulet' and
                    (context.other_card:get_id() == 12 or context.other_card:get_id() == 13) then
                    return {
                        x_mult = self.ability.extra,
                        colour = G.C.RED,
                        card = self
                    }
                end
            end
            if context.cardarea == G.hand then
                if self.ability.name == 'Shoot the Moon' and
                    context.other_card:get_id() == 12 then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                            card = self,
                        }
                    else
                        return {
                            h_mult = 13,
                            card = self
                        }
                    end
                end
                if self.ability.name == 'Baron' and
                    context.other_card:get_id() == 13 then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                            card = self,
                        }
                    else
                        return {
                            x_mult = self.ability.extra,
                            card = self
                        }
                    end
                end
                if self.ability.name == 'Reserved Parking' and
                    context.other_card:is_face() and
                    pseudorandom('parking') < G.GAME.probabilities.normal / self.ability.extra.odds then
                    if context.other_card.debuff then
                        return {
                            message = localize('k_debuffed'),
                            colour = G.C.RED,
                            card = self,
                        }
                    else
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + self.ability.extra.dollars
                        G.E_MANAGER:add_event(Event({ func = (function()
                            G.GAME.dollar_buffer = 0; return true
                        end) }))
                        return {
                            dollars = self.ability.extra.dollars,
                            card = self
                        }
                    end
                end
                if self.ability.name == 'Raised Fist' then
                    local temp_Mult, temp_ID = 15, 15
                    local raised_card = nil
                    for i = 1, #G.hand.cards do
                        if temp_ID >= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then
                            temp_Mult = G.hand.cards[i].base.nominal
                            temp_ID = G.hand.cards[i].base.id
                            raised_card = G.hand.cards[i]
                        end
                    end
                    if raised_card == context.other_card then
                        if context.other_card.debuff then
                            return {
                                message = localize('k_debuffed'),
                                colour = G.C.RED,
                                card = self,
                            }
                        else
                            return {
                                h_mult = 2 * temp_Mult,
                                card = self,
                            }
                        end
                    end
                end
            end
        elseif context.repetition then
            if context.cardarea == G.play then
                if self.ability.name == 'Sock and Buskin' and (
                        context.other_card:is_face()) then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Hanging Chad' and (
                        context.other_card == context.scoring_hand[1]) then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Dusk' and G.GAME.current_round.hands_left == 0 then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
                if self.ability.name == 'Seltzer' then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = self
                    }
                end
                if self.ability.name == 'Hack' and (
                        context.other_card:get_id() == 2 or
                        context.other_card:get_id() == 3 or
                        context.other_card:get_id() == 4 or
                        context.other_card:get_id() == 5) then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
            end
            if context.cardarea == G.hand then
                if self.ability.name == 'Mime' and
                    (next(context.card_effects[1]) or #context.card_effects > 1) then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
            end
        elseif context.other_joker then
            if self.ability.name == 'Baseball Card' and (context.other_joker.config.center.rarity == 2 or context.other_joker.config.center.rarity == "Uncommon") and self ~= context.other_joker then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra } },
                    Xmult_mod = self.ability.extra
                }
            end
        else
            do
                if context.before then
                    if self.ability.name == 'Spare Trousers' and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) and not context.blueprint then
                        self.ability.mult = self.ability.mult + self.ability.extra
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.RED,
                            card = self
                        }
                    end
                    if self.ability.name == 'Space Joker' and pseudorandom('space') < G.GAME.probabilities.normal / self.ability.extra then
                        return {
                            card = self,
                            level_up = true,
                            message = localize('k_level_up_ex')
                        }
                    end
                    if self.ability.name == 'Square Joker' and #context.full_hand == 4 and not context.blueprint then
                        self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS,
                            card = self
                        }
                    end
                    if self.ability.name == 'Runner' and next(context.poker_hands['Straight']) and not context.blueprint then
                        self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS,
                            card = self
                        }
                    end
                    if self.ability.name == 'Midas Mask' and not context.blueprint then
                        local faces = {}
                        for k, v in ipairs(context.scoring_hand) do
                            if v:is_face() then
                                faces[#faces + 1] = v
                                v:set_ability(G.P_CENTERS.m_gold, nil, true)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        v:juice_up()
                                        return true
                                    end
                                }))
                            end
                        end
                        if #faces > 0 then
                            return {
                                message = localize('k_gold'),
                                colour = G.C.MONEY,
                                card = self
                            }
                        end
                    end
                    if self.ability.name == 'Vampire' and not context.blueprint then
                        local enhanced = {}
                        for k, v in ipairs(context.scoring_hand) do
                            if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
                                enhanced[#enhanced + 1] = v
                                v.vampired = true
                                v:set_ability(G.P_CENTERS.c_base, nil, true)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        v:juice_up()
                                        v.vampired = nil
                                        return true
                                    end
                                }))
                            end
                        end

                        if #enhanced > 0 then
                            self.ability.x_mult = self.ability.x_mult + self.ability.extra * #enhanced
                            return {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } },
                                colour = G.C.MULT,
                                card = self
                            }
                        end
                    end
                    if self.ability.name == 'To Do List' and context.scoring_name == self.ability.to_do_poker_hand then
                        ease_dollars(self.ability.extra.dollars)
                        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + self.ability.extra.dollars
                        G.E_MANAGER:add_event(Event({ func = (function()
                            G.GAME.dollar_buffer = 0; return true
                        end) }))
                        return {
                            message = localize('$') .. self.ability.extra.dollars,
                            colour = G.C.MONEY
                        }
                    end
                    if self.ability.name == 'DNA' and G.GAME.current_round.hands_played == 0 then
                        if #context.full_hand == 1 then
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                            _card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, _card)
                            G.hand:emplace(_card)
                            _card.states.visible = nil

                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    _card:start_materialize()
                                    return true
                                end
                            }))
                            return {
                                message = localize('k_copied_ex'),
                                colour = G.C.CHIPS,
                                card = self,
                                playing_cards_created = { true }
                            }
                        end
                    end
                    if self.ability.name == 'Ride the Bus' and not context.blueprint then
                        local faces = false
                        for i = 1, #context.scoring_hand do
                            if context.scoring_hand[i]:is_face() then faces = true end
                        end
                        if faces then
                            local last_mult = self.ability.mult
                            self.ability.mult = 0
                            if last_mult > 0 then
                                return {
                                    card = self,
                                    message = localize('k_reset')
                                }
                            end
                        else
                            self.ability.mult = self.ability.mult + self.ability.extra
                        end
                    end
                    if self.ability.name == 'Obelisk' and not context.blueprint then
                        local reset = true
                        local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
                        for k, v in pairs(G.GAME.hands) do
                            if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                                reset = false
                            end
                        end
                        if reset then
                            if self.ability.x_mult > 1 then
                                self.ability.x_mult = 1
                                return {
                                    card = self,
                                    message = localize('k_reset')
                                }
                            end
                        else
                            self.ability.x_mult = self.ability.x_mult + self.ability.extra
                        end
                    end
                    if self.ability.name == 'Green Joker' and not context.blueprint then
                        self.ability.mult = self.ability.mult + self.ability.extra.hand_add
                        return {
                            card = self,
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.hand_add } }
                        }
                    end
                elseif context.after then
                    if self.ability.name == 'Ice Cream' and not context.blueprint then
                        if self.ability.extra.chips - self.ability.extra.chip_mod <= 0 then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    self.T.r = -0.2
                                    self:juice_up(0.3, 0.4)
                                    self.states.drag.is = true
                                    self.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.3,
                                        blockable = false,
                                        func = function()
                                            G.jokers:remove_card(self)
                                            self:remove()
                                            self = nil
                                            return true;
                                        end
                                    }))
                                    return true
                                end
                            }))
                            return {
                                message = localize('k_melted_ex'),
                                colour = G.C.CHIPS
                            }
                        else
                            self.ability.extra.chips = self.ability.extra.chips - self.ability.extra.chip_mod
                            return {
                                message = localize { type = 'variable', key = 'a_chips_minus', vars = { self.ability.extra.chip_mod } },
                                colour = G.C.CHIPS
                            }
                        end
                    end
                    if self.ability.name == 'Seltzer' and not context.blueprint then
                        if self.ability.extra - 1 <= 0 then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    self.T.r = -0.2
                                    self:juice_up(0.3, 0.4)
                                    self.states.drag.is = true
                                    self.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.3,
                                        blockable = false,
                                        func = function()
                                            G.jokers:remove_card(self)
                                            self:remove()
                                            self = nil
                                            return true;
                                        end
                                    }))
                                    return true
                                end
                            }))
                            return {
                                message = localize('k_drank_ex'),
                                colour = G.C.FILTER
                            }
                        else
                            self.ability.extra = self.ability.extra - 1
                            return {
                                message = self.ability.extra .. '',
                                colour = G.C.FILTER
                            }
                        end
                    end
                elseif context.joker_main then
                    if self.ability.name == 'Loyalty Card' then
                        self.ability.loyalty_remaining = (self.ability.extra.every - 1 - (G.GAME.hands_played - self.ability.hands_played_at_create)) %
                        (self.ability.extra.every + 1)
                        if context.blueprint then
                            if self.ability.loyalty_remaining == self.ability.extra.every then
                                return {
                                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.Xmult } },
                                    Xmult_mod = self.ability.extra.Xmult
                                }
                            end
                        else
                            if self.ability.loyalty_remaining == 0 then
                                local eval = function(card) return (card.ability.loyalty_remaining == 0) end
                                juice_card_until(self, eval, true)
                            elseif self.ability.loyalty_remaining == self.ability.extra.every then
                                return {
                                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.Xmult } },
                                    Xmult_mod = self.ability.extra.Xmult
                                }
                            end
                        end
                    end
                    if self.ability.name ~= 'Seeing Double' and self.ability.x_mult > 1 and (self.ability.type == '' or next(context.poker_hands[self.ability.type] or {})) then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } },
                            colour = G.C.RED,
                            Xmult_mod = self.ability.x_mult
                        }
                    end
                    if self.ability.t_mult > 0 and next(context.poker_hands[self.ability.type]) then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.t_mult } },
                            mult_mod = self.ability.t_mult
                        }
                    end
                    if self.ability.t_chips > 0 and next(context.poker_hands[self.ability.type]) then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.t_chips } },
                            chip_mod = self.ability.t_chips
                        }
                    end
                    if self.ability.name == 'Half Joker' and #context.full_hand <= self.ability.extra.size then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                            mult_mod = self.ability.extra.mult
                        }
                    end
                    if self.ability.name == 'Abstract Joker' then
                        local x = 0
                        for i = 1, #G.jokers.cards do
                            if G.jokers.cards[i].ability.set == 'Joker' then x = x + 1 end
                        end
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { x * self.ability.extra } },
                            mult_mod = x * self.ability.extra
                        }
                    end
                    if self.ability.name == 'Acrobat' and G.GAME.current_round.hands_left == 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra } },
                            Xmult_mod = self.ability.extra
                        }
                    end
                    if self.ability.name == 'Mystic Summit' and G.GAME.current_round.discards_left == self.ability.extra.d_remaining then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                            mult_mod = self.ability.extra.mult
                        }
                    end
                    if self.ability.name == 'Misprint' then
                        local temp_Mult = pseudorandom('misprint', self.ability.extra.min, self.ability.extra.max)
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { temp_Mult } },
                            mult_mod = temp_Mult
                        }
                    end
                    if self.ability.name == 'Banner' and G.GAME.current_round.discards_left > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { G.GAME.current_round.discards_left * self.ability.extra } },
                            chip_mod = G.GAME.current_round.discards_left * self.ability.extra
                        }
                    end
                    if self.ability.name == 'Stuntman' then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chip_mod } },
                            chip_mod = self.ability.extra.chip_mod,
                        }
                    end
                    if self.ability.name == 'Matador' then
                        if G.GAME.blind.triggered then
                            ease_dollars(self.ability.extra)
                            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + self.ability.extra
                            G.E_MANAGER:add_event(Event({ func = (function()
                                G.GAME.dollar_buffer = 0; return true
                            end) }))
                            return {
                                message = localize('$') .. self.ability.extra,
                                colour = G.C.MONEY
                            }
                        end
                    end
                    if self.ability.name == 'Supernova' then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.hands[context.scoring_name].played } },
                            mult_mod = G.GAME.hands[context.scoring_name].played
                        }
                    end
                    if self.ability.name == 'Ceremonial Dagger' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Vagabond' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        if to_big(G.GAME.dollars) <= to_big(self.ability.extra) then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                    local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'vag')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                            return {
                                message = localize('k_plus_tarot'),
                                card = self
                            }
                        end
                    end
                    if self.ability.name == 'Superposition' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        local aces = 0
                        for i = 1, #context.scoring_hand do
                            if context.scoring_hand[i]:get_id() == 14 then aces = aces + 1 end
                        end
                        if aces >= 1 and next(context.poker_hands["Straight"]) then
                            local card_type = 'Tarot'
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                    local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, 'sup')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                            return {
                                message = localize('k_plus_tarot'),
                                colour = G.C.SECONDARY_SET.Tarot,
                                card = self
                            }
                        end
                    end
                    if self.ability.name == 'Seance' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        if next(context.poker_hands[self.ability.extra.poker_hand]) then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                    local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'sea')
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                            return {
                                message = localize('k_plus_spectral'),
                                colour = G.C.SECONDARY_SET.Spectral,
                                card = self
                            }
                        end
                    end
                    if self.ability.name == 'Flower Pot' then
                        local suits = {
                            ['Hearts'] = 0,
                            ['Diamonds'] = 0,
                            ['Spades'] = 0,
                            ['Clubs'] = 0
                        }
                        for i = 1, #context.scoring_hand do
                            if not SMODS.has_any_suit(context.scoring_hand[i]) then
                                if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                                    suits["Hearts"] = suits["Hearts"] + 1
                                elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                                    suits["Diamonds"] = suits["Diamonds"] + 1
                                elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                                    suits["Spades"] = suits["Spades"] + 1
                                elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                                    suits["Clubs"] = suits["Clubs"] + 1
                                end
                            end
                        end
                        for i = 1, #context.scoring_hand do
                            if SMODS.has_any_suit(context.scoring_hand[i]) then
                                if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                                    suits["Hearts"] = suits["Hearts"] + 1
                                elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                                    suits["Diamonds"] = suits["Diamonds"] + 1
                                elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                                    suits["Spades"] = suits["Spades"] + 1
                                elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                                    suits["Clubs"] = suits["Clubs"] + 1
                                end
                            end
                        end
                        if suits["Hearts"] > 0 and
                            suits["Diamonds"] > 0 and
                            suits["Spades"] > 0 and
                            suits["Clubs"] > 0 then
                            return {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra } },
                                Xmult_mod = self.ability.extra
                            }
                        end
                    end
                    if self.ability.name == 'Seeing Double' then
                        if SMODS.seeing_double_check(context.scoring_hand, 'Clubs') then
                            return {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra } },
                                Xmult_mod = self.ability.extra
                            }
                        end
                    end
                    if self.ability.name == 'Wee Joker' then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                            chip_mod = self.ability.extra.chips,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Castle' and (self.ability.extra.chips > 0) then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                            chip_mod = self.ability.extra.chips,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Blue Joker' and #G.deck.cards > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra * #G.deck.cards } },
                            chip_mod = self.ability.extra * #G.deck.cards,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Erosion' and (G.GAME.starting_deck_size - #G.playing_cards) > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra * (G.GAME.starting_deck_size - #G.playing_cards) } },
                            mult_mod = self.ability.extra * (G.GAME.starting_deck_size - #G.playing_cards),
                            colour = G.C.MULT
                        }
                    end
                    if self.ability.name == 'Square Joker' then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                            chip_mod = self.ability.extra.chips,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Runner' then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                            chip_mod = self.ability.extra.chips,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Ice Cream' then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                            chip_mod = self.ability.extra.chips,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Stone Joker' and self.ability.stone_tally > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra * self.ability.stone_tally } },
                            chip_mod = self.ability.extra * self.ability.stone_tally,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == 'Steel Joker' and self.ability.steel_tally > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + self.ability.extra * self.ability.steel_tally } },
                            Xmult_mod = 1 + self.ability.extra * self.ability.steel_tally,
                            colour = G.C.MULT
                        }
                    end
                    if self.ability.name == 'Bull' and (to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0)) > to_big(0) then
                        return {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra * math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0))) } },
                            chip_mod = self.ability.extra * math.max(0, (to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0))),
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == "Driver's License" then
                        if (self.ability.driver_tally or 0) >= 16 then
                            return {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra } },
                                Xmult_mod = self.ability.extra
                            }
                        end
                    end
                    if self.ability.name == "Blackboard" then
                        local black_suits, all_cards = 0, 0
                        for k, v in ipairs(G.hand.cards) do
                            all_cards = all_cards + 1
                            if v:is_suit('Clubs', nil, true) or v:is_suit('Spades', nil, true) then
                                black_suits = black_suits + 1
                            end
                        end
                        if black_suits == all_cards then
                            return {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra } },
                                Xmult_mod = self.ability.extra
                            }
                        end
                    end
                    if self.ability.name == "Joker Stencil" then
                        if (G.jokers.config.card_limit - #G.jokers.cards) > 0 then
                            return {
                                message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.x_mult } },
                                Xmult_mod = self.ability.x_mult
                            }
                        end
                    end
                    if self.ability.name == 'Swashbuckler' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Joker' then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Spare Trousers' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Ride the Bus' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Flash Card' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Popcorn' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Green Joker' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Fortune Teller' and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.consumeable_usage_total.tarot } },
                            mult_mod = G.GAME.consumeable_usage_total.tarot
                        }
                    end
                    if self.ability.name == 'Gros Michel' then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                            mult_mod = self.ability.extra.mult,
                        }
                    end
                    if self.ability.name == 'Cavendish' then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.Xmult } },
                            Xmult_mod = self.ability.extra.Xmult,
                        }
                    end
                    if self.ability.name == 'Red Card' and self.ability.mult > 0 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.mult } },
                            mult_mod = self.ability.mult
                        }
                    end
                    if self.ability.name == 'Card Sharp' and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.Xmult } },
                            Xmult_mod = self.ability.extra.Xmult,
                        }
                    end
                    if self.ability.name == 'Bootstraps' and math.floor((to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0)) / to_big(self.ability.extra.dollars)) >= to_big(1) then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult * math.floor((to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0)) / to_big(self.ability.extra.dollars)) } },
                            mult_mod = self.ability.extra.mult *
                            math.floor((to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0)) / to_big(self.ability.extra.dollars))
                        }
                    end
                    if self.ability.name == 'Caino' and self.ability.caino_xmult > 1 then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.caino_xmult } },
                            Xmult_mod = self.ability.caino_xmult
                        }
                    end
                end
            end
        end
    end
end


function SEALS.run_vanilla_joker_add_to_deck(key, from_debuff, fake_card)
    local self = fake_card
    if not self.added_to_deck then
        self.added_to_deck = true
        if self.ability.h_size and self.ability.h_size ~= 0 then
            G.hand:change_size(self.ability.h_size)
        end
        if self.ability.d_size and self.ability.d_size > 0 then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.ability.d_size
            ease_discard(self.ability.d_size)
        end
        if self.ability.name == 'Credit Card' then
            G.GAME.bankrupt_at = G.GAME.bankrupt_at - self.ability.extra
        end
        if self.ability.name == 'Chicot' and G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            G.GAME.blind:disable()
            play_sound('timpani')
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
        end
        if self.ability.name == 'Chaos the Clown' then
            SMODS.change_free_rerolls(1)
            calculate_reroll_cost(true)
        end
        if self.ability.name == 'Turtle Bean' then
            G.hand:change_size(self.ability.extra.h_size)
        end
        if self.ability.name == 'Oops! All 6s' then
            for k, v in pairs(G.GAME.probabilities) do 
                G.GAME.probabilities[k] = v*2
            end
        end
        if self.ability.name == 'To the Moon' then
            G.GAME.interest_amount = G.GAME.interest_amount + self.ability.extra
        end
        if self.ability.name == 'Astronomer' then 
            G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true end }))
        end
        if self.ability.name == 'Troubadour' then
            G.hand:change_size(self.ability.extra.h_size)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.ability.extra.h_plays
        end
        if self.ability.name == 'Stuntman' then
            G.hand:change_size(-self.ability.extra.h_size)
        end
        if true then
            if from_debuff then
                self.ability.joker_added_to_deck_but_debuffed = nil
            else
                if self.edition and self.edition.card_limit then
                    if self.ability.consumeable then
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.edition.card_limit
                    else
                        G.jokers.config.card_limit = G.jokers.config.card_limit + self.edition.card_limit
                    end
                end
            end
        end
        if G.GAME.blind and G.GAME.blind.in_blind and not self.from_quantum then G.E_MANAGER:add_event(Event({ func = function() G.GAME.blind:set_blind(nil, true, nil); return true end })) end
    end
end

function SEALS.run_vanilla_joker_remove_from_deck(key, from_debuff, fake_card)
    local self = fake_card
    if self.added_to_deck then
        self.added_to_deck = false 
        if self.ability.h_size and self.ability.h_size ~= 0 then
            G.hand:change_size(-self.ability.h_size)
        end
        if self.ability.d_size and self.ability.d_size > 0 then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.d_size
            ease_discard(-self.ability.d_size)
        end
        if self.ability.name == 'Credit Card' then
            G.GAME.bankrupt_at = G.GAME.bankrupt_at + self.ability.extra
        end
        if self.ability.name == 'Chaos the Clown' then
            SMODS.change_free_rerolls(-1)
            calculate_reroll_cost(true)
        end
        if self.ability.name == 'Turtle Bean' then
            G.hand:change_size(-self.ability.extra.h_size)
        end
        if self.ability.name == 'Oops! All 6s' then
            for k, v in pairs(G.GAME.probabilities) do 
                G.GAME.probabilities[k] = v/2
            end
        end
        if self.ability.name == 'To the Moon' then
            G.GAME.interest_amount = G.GAME.interest_amount - self.ability.extra
        end
        if self.ability.name == 'Astronomer' then 
            G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true end }))
        end
        if self.ability.name == 'Troubadour' then
            G.hand:change_size(-self.ability.extra.h_size)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - self.ability.extra.h_plays
        end
        if self.ability.name == 'Stuntman' then
            G.hand:change_size(self.ability.extra.h_size)
        end
        if G.jokers then
            if from_debuff then
                self.ability.joker_added_to_deck_but_debuffed = true
            else
                if self.edition and self.edition.card_limit then
                    if self.ability.consumeable then
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.edition.card_limit
                    elseif self.ability.set == 'Joker' then
                        G.jokers.config.card_limit = G.jokers.config.card_limit - self.edition.card_limit
                    end
                end 
            end
        end
        if G.GAME.blind and G.GAME.blind.in_blind and not self.from_quantum then G.E_MANAGER:add_event(Event({ func = function() G.GAME.blind:set_blind(nil, true, nil); return true end })) end
    end
end

function SEALS.run_vanilla_joker_update(key, dt, fake_card)
    local self = fake_card
    if G.STAGE == G.STAGES.RUN then
        if self.ability.name == 'Throwback' then
            self.ability.x_mult = 1 + G.GAME.skips*self.ability.extra
        end
        if self.ability.name == "Driver's License" then 
            self.ability.driver_tally = 0
            for k, v in pairs(G.playing_cards) do
                if next(SMODS.get_enhancements(v)) then self.ability.driver_tally = self.ability.driver_tally+1 end
            end
        end
        if self.ability.name == "Steel Joker" then 
            self.ability.steel_tally = 0
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_steel') then self.ability.steel_tally = self.ability.steel_tally+1 end
            end
        end
        if self.ability.name == "Cloud 9" then 
            self.ability.nine_tally = 0
            for k, v in pairs(G.playing_cards) do
                if v:get_id() == 9 then self.ability.nine_tally = self.ability.nine_tally+1 end
            end
        end
        if self.ability.name == "Stone Joker" then 
            self.ability.stone_tally = 0
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_stone') then self.ability.stone_tally = self.ability.stone_tally+1 end
            end
        end
        if self.ability.name == "Joker Stencil" then 
            self.ability.x_mult = (G.jokers.config.card_limit - #G.jokers.cards)
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == 'Joker Stencil' then self.ability.x_mult = self.ability.x_mult + 1 end
            end
        end
        if self.ability.name == 'Blueprint' or self.ability.name == 'Brainstorm' then
            local other_joker = nil
            if self.ability.name == 'Brainstorm' then
                other_joker = G.jokers.cards[1]
            elseif self.ability.name == 'Blueprint' then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == self then other_joker = G.jokers.cards[i+1] end
                end
            end
            if other_joker and other_joker ~= self and other_joker.config.center.blueprint_compat then
                self.ability.blueprint_compat = 'compatible'
            else
                self.ability.blueprint_compat = 'incompatible'
            end
        end
        if self.ability.name == 'Swashbuckler' then
            local sell_cost = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= self and (G.jokers.cards[i].area and G.jokers.cards[i].area == G.jokers) then
                    sell_cost = sell_cost + G.jokers.cards[i].sell_cost
                end
            end
            self.ability.mult = sell_cost
        end
    end
end

function Card:soe_no_touching2(dissolve_colours, silent, dissolve_time_fac, no_juice)
    dissolve_colours = dissolve_colours or (type(self.destroyed) == 'table' and self.destroyed.colours) or nil
    dissolve_time_fac = dissolve_time_fac or (type(self.destroyed) == 'table' and self.destroyed.time) or nil
    local dissolve_time = 0.7*(dissolve_time_fac or 1)
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    if not no_juice then self:juice_up() end
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
    if not silent then 
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
                    play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                    play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.05*dissolve_time,
        func = (function() self:soe_no_touching() return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end

function Card:soe_no_touching()
    self.removed = true

    if self.area then self.area:remove_card(self) end
    if G.in_delete_run then goto skip_game_actions_during_remove end

    self:remove_from_deck()
    if self.joker_added_to_deck_but_debuffed then
        if self.edition and self.edition.card_limit then
            if self.ability.consumeable then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.edition.card_limit
            elseif self.ability.set == 'Joker' then
                G.jokers.config.card_limit = G.jokers.config.card_limit - self.edition.card_limit
            end
        end 
    end

    if not G.OVERLAY_MENU then
        if not next(SMODS.find_card(self.config.center.key, true)) then
            G.GAME.used_jokers[self.config.center.key] = nil
        end
    end

    ::skip_game_actions_during_remove::
    if G.playing_cards then
        for k, v in ipairs(G.playing_cards) do
            if v == self then
                table.remove(G.playing_cards, k)
                break
            end
        end
        for k, v in ipairs(G.playing_cards) do
            v.playing_card = k
        end
    end

    remove_all(self.children)

    for k, v in pairs(G.I.CARD) do
        if v == self then
            table.remove(G.I.CARD, k)
        end
    end
    Moveable.remove(self)
end

--- Thanks to thewintercomet on discord for the base of this code!
local ref_set_edition = Card.set_edition
function Card:set_edition(edition, immediate, silent, delay)
    if not (next(SMODS.find_card("j_soe_sealjoker2")) or SEALS.has_seal(self, 'soe_rainbowseal')) then
        return ref_set_edition(self, edition, immediate, silent, delay)
    end

    SMODS.enh_cache:write(self, nil)
	-- Check to see if negative is being removed and reduce card_limit accordingly
	if (self.added_to_deck or self.joker_added_to_deck_but_debuffed or (self.area == G.hand and not self.debuff)) and self.edition and self.edition.card_limit then
		if self.ability.consumeable and self.area == G.consumeables then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.edition.card_limit
		elseif self.ability.set == 'Joker' and self.area == G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit - self.edition.card_limit
		elseif self.area == G.hand then
			if G.hand.config.real_card_limit then
				G.hand.config.real_card_limit = G.hand.config.real_card_limit - self.edition.card_limit
			end
			G.hand.config.card_limit = G.hand.config.card_limit - self.edition.card_limit
		end
	end

	local old_edition = self.edition and self.edition.key
	if old_edition then
		self.ignore_base_shader[old_edition] = nil
		self.ignore_shadow[old_edition] = nil

		local on_old_edition_removed = G.P_CENTERS[old_edition] and G.P_CENTERS[old_edition].on_remove
		if type(on_old_edition_removed) == "function" then
			on_old_edition_removed(self)
		end
	end

	local edition_type = nil
	if type(edition) == 'string' then
        if string.sub(edition, 1, 2) ~= 'e_' then
            edition = 'e_' .. edition
        end
		assert(G.P_CENTERS[edition], ("Edition \"%s\" is invalid."):format(edition))
		edition_type = string.sub(edition, 3)
	elseif type(edition) == 'table' then
		if edition.type then
			edition_type = edition.type
		else
			for k, v in pairs(edition) do
				if v then
					assert(not edition_type, "Tried to apply more than one edition.")
					edition_type = k
				end
			end
		end
	end

	if not edition_type or edition_type == 'base' then
		if self.edition == nil then -- early exit
			return
		end
		self.edition = nil -- remove edition from card
		self:set_cost()
		if not silent then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = not immediate and 0.2 or 0,
				blockable = not immediate,
				func = function()
					self:juice_up(1, 0.5)
					play_sound('whoosh2', 1.2, 0.6)
					return true
				end
			}))
		end
		return
	end

    if not self.soe_from_copy then
        self.ability.soe_editions = self.ability.soe_editions or {}
        table.insert(self.ability.soe_editions, edition_type)
    end

    local all_types = copy_table(SEALS.get_quantum_editions(self))
    local edition_table = {}
    
    if next(SEALS.get_quantum_editions(self)) then
        for _, ed_key in pairs(all_types) do
            local get_edition = G.P_CENTERS["e_"..ed_key]
            for k, v in pairs(get_edition.config) do
                if type(v) == 'table' then
                    edition_table[k] = copy_table(v)
                else
                    edition_table[k] = v
                end
                if k == 'card_limit' and (self.added_to_deck or self.joker_added_to_deck_but_debuffed or (self.area == G.hand and not self.debuff)) and G.jokers and G.consumeables then
                    if self.ability.consumeable and self.area == G.consumeables then
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit - v
                    elseif self.ability.set == 'Joker' and self.area == G.jokers then
                        G.jokers.config.card_limit = G.jokers.config.card_limit - v
                    elseif self.area == G.hand then
                        if G.hand.config.real_card_limit then
                            G.hand.config.real_card_limit = G.hand.config.real_card_limit - v
                        end
                        G.hand.config.card_limit = G.hand.config.card_limit - v
                    end
                end
            end
            local on_edition_removed = get_edition.on_remove
            if type(on_edition_removed) == "function" then
                on_edition_removed(self)
            end
        end
    end
    local other_get_edition = G.P_CENTERS["e_"..edition_type]
    self.edition = {}
    self.edition[edition_type] = true
    self.edition.type = edition_type
    local other_key = 'e_' .. edition_type
    self.edition.key = other_key
    if other_get_edition.override_base_shader or other_get_edition.disable_base_shader then
        self.ignore_base_shader[other_key] = true
    end
    if other_get_edition.no_shadow or other_get_edition.disable_shadow then
        self.ignore_shadow[other_key] = true
    end
    for k, v in pairs(edition_table) do
        self.edition[k] = v
    end
    local all_types = {edition_type}
    for k, v in ipairs(SEALS.get_quantum_editions(self)) do
        table.insert(all_types, v)
    end

    for _, ed_key in pairs(all_types) do
        local get_edition = G.P_CENTERS["e_"..ed_key]
        for k, v in pairs(get_edition.config) do
            if k == 'card_limit' and (self.added_to_deck or self.joker_added_to_deck_but_debuffed or (self.area == G.hand and not self.debuff)) and G.jokers and G.consumeables then
                if self.ability.consumeable then
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + v
                elseif self.ability.set == 'Joker' then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + v
                elseif self.area == G.hand then
                    local is_in_pack = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.config.center.draw_hand))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            if G.hand.config.real_card_limit then
                                G.hand.config.real_card_limit = G.hand.config.real_card_limit + v
                            end
                            G.hand.config.card_limit = G.hand.config.card_limit + v
                            if not is_in_pack and G.GAME.blind.in_blind then
                                G.FUNCS.draw_from_deck_to_hand(v)
                            end
                            return true
                        end
                    }))
                end
            end
        end
        local on_edition_applied = get_edition.on_apply
        if type(on_edition_applied) == "function" then
            on_edition_applied(self)
        end
    end

	if self.area and self.area == G.jokers then
		if self.edition then
			if not G.P_CENTERS['e_' .. (self.edition.type)].discovered then
				discover_card(G.P_CENTERS['e_' .. (self.edition.type)])
			end
		else
			if not G.P_CENTERS['e_base'].discovered then
				discover_card(G.P_CENTERS['e_base'])
			end
		end
	end

	if self.edition and not silent then
		local ed = G.P_CENTERS['e_' .. (self.edition.type)]
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

	if delay then
		self.delay_edition = true
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()
				self.delay_edition = nil
				return true
			end
		}))
	end

	if G.jokers and self.area == G.jokers then
		check_for_unlock({ type = 'modify_jokers' })
	end

	self:set_cost()
end

function SEALS.calculate_quantum_editions(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end

    context.extra_edition = true
    local extra_editions = SEALS.get_quantum_editions(card)
    table.sort(extra_editions, function(a, b) return G.P_CENTERS["e_"..a].order < G.P_CENTERS["e_"..b].order end)
    local old_edition = card.edition and copy_table(card.edition) or nil
    for i, v in ipairs(extra_editions) do
        local ed_key = "e_"..v
        if G.P_CENTERS[ed_key] then
            local cardedition = {
                [v] = true,
                type = v,
                key = ed_key
            }
            for k, v in pairs(G.P_CENTERS[ed_key].config) do
                cardedition[k] = copy_table(v)
            end
            card.edition = cardedition
            card.ability.extra_edition = ed_key
            G.GAME.triggered_edition = {card.sort_id, ed_key}
            local eval = {edition = card:calculate_edition(context)}
            G.GAME.triggered_edition = nil
            table.insert(effects, eval)
        end
    end
    
    card.edition = old_edition
    context.extra_edition = nil
end

function SEALS.get_quantum_editions(card)
    if (card.ability.soe_editions and #card.ability.soe_editions >= 2) or SEALS.has_seal(card, 'soe_rainbowseal') then
        local quantumeditions = copy_table(card.ability.soe_editions or {})
        for i, v in ipairs(quantumeditions) do
            if v == (card.edition or {}).key then
                table.remove(quantumeditions, i)
                break
            end
        end
        if SEALS.has_seal(card, 'soe_rainbowseal') then
            for i, v in ipairs({"foil", "holo", "polychrome"}) do
                if v ~= (card.edition or {}).type then
                    table.insert(quantumeditions, v)
                end
            end
        end
        return quantumeditions
    end
    return {}
end

function SEALS.get_enhancements(card, extra_only)
    if not card then return {} end
    local enhancements = copy_table(card.ability.soe_quantum_enhancements or {})
    if not extra_only and card.config.center.key ~= "c_base" then table.insert(enhancements, 1, card.config.center.key) end
    return enhancements
end

function SEALS.calculate_quantum_enhancements(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end
    context.extra_enhancement = true
    local old_ability = copy_table(card.ability)
    local old_center = card.config.center
    local old_center_key = card.config.center_key
    local extra_enhancements_list = SEALS.get_enhancements(card, true)
    table.sort(extra_enhancements_list, function(a, b) return G.P_CENTERS[a].order < G.P_CENTERS[b].order end)
    for _, k in ipairs(extra_enhancements_list) do
        SEALS.safe_set_ability(card, G.P_CENTERS[k])
        card.ability.extra_enhancement = k
        G.GAME.triggered_enhancement = {card.sort_id, k}
        local eval = eval_card(card, context)
        G.GAME.triggered_enhancement = nil
        table.insert(effects, eval)
    end
    card.ability = old_ability
    card.config.center = old_center
    card.config.center_key = old_center_key
    context.extra_enhancement = nil
end

function SEALS.get_seals(card, extra_only)
    if not card or not card.ability then return {} end
    local seals = copy_table(card.ability.soe_quantum_seals or {})
    if not extra_only then table.insert(seals, 1, card.seal) end
    return seals
end

local oldsealdrawstepfunc = SMODS.DrawSteps["seal"].func
SMODS.DrawSteps["seal"].func = function(self, layer)
    local oldseal = self.seal
    if self.drawseal then self.seal = self.drawseal ~= 'none' and self.drawseal or nil end
    local g = oldsealdrawstepfunc(self, layer)
    self.seal = oldseal
    return g
    --[[
    if self.ability.quantum_seals then
        local cardseal = self.drawseal or self.seal
        local seal = G.P_SEALS[cardseal] or {}
        if type(seal.draw) == 'function' then
            seal:draw(self, layer)
        elseif cardseal then
            G.shared_seals[cardseal].role.draw_major = self
            G.shared_seals[cardseal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if cardseal == 'Gold' then G.shared_seals[cardseal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
        end
    else
        oldsealdrawstepfunc(self, layer)
    end
    ]]
end

function SEALS.calculate_quantum_seals(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end
    context.extra_seal = true
    local old_seal = card.seal
    card.drawseal = old_seal or 'none'
    local old_ability_seal = copy_table(card.ability.seal)
    local extra_seals_list = SEALS.get_seals(card, true)
    table.sort(extra_seals_list, function(a, b) return G.P_SEALS[a].order < G.P_SEALS[b].order end)
    for _, k in ipairs(extra_seals_list) do
        SEALS.safe_set_seal(card, k)
        card.ability.extra_seal = k
        local eval
        if card.playing_card and (k == 'Gold' or k == 'Blue') then
            eval = {seals = SEALS.calculate_hardcoded_seals(card, context)}
        else
            eval = {seals = card:calculate_seal(context)}
        end
        if G.P_SEALS[k].get_p_dollars then
            local p_dollars = G.P_SEALS[k]:get_p_dollars(card)
            if p_dollars ~= 0 then
                if not eval.playing_card then eval.playing_card = {} end
                eval.playing_card.p_dollars = p_dollars
            end
        end
        table.insert(effects, eval)
    end
    card.seal = old_seal
    card.drawseal = nil
    card.ability.seal = old_ability_seal
    context.extra_seal = nil
end

function SEALS.calculate_hardcoded_seals(card, context)
    if card.seal == 'Blue' and ((context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or context.forcetrigger) then
        return {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet, func = function()
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
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
                end)
            }))
        end}
    end
    if card.seal == 'Gold' and ((context.main_scoring and context.cardarea == G.play) or context.forcetrigger) then
        return {dollars = 3, card = card}
    end
end

function SEALS.get_quantum_jokers(card)
    return copy_table(card.ability.soe_jokers or {})
end

function SEALS.get_quantum_stickers(card)
    for k, v in pairs(card.ability.soe_quantum_stickers or {}) do
        if not card.ability[k] then
            card.ability.soe_quantum_stickers[k] = nil
        end
    end
    return copy_table(card.ability.soe_quantum_stickers or {})
end

function SEALS.calculate_quantum_stickers(card, effects, context)
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards) then return nil end
    context.extra_stickers = true
    for k, v in pairs(SEALS.get_quantum_stickers(card)) do
        if card.ability[k] then
            for i=1, v do
                card.ability.extra_sticker = k
                local eval = {sticker = card:calculate_sticker(context, k)}
                card.ability.extra_sticker = nil
                table.insert(effects, eval)
            end
        end
    end
    context.extra_stickers = nil
end

function SEALS.safe_set_ability(self, center, dontsave)
    if not self or not center then return nil end
    local oldcenter = self.config.center
    local config
    if not dontsave then
        G.GAME.soe_joker_savedvalues = G.GAME.soe_joker_savedvalues or {}
        G.GAME.soe_joker_savedvalues[self.sort_id] = G.GAME.soe_joker_savedvalues[self.sort_id] or {}
        G.GAME.soe_joker_savedvalues[self.sort_id][oldcenter.key] = copy_table(self.ability)
        config = G.GAME.soe_joker_savedvalues[self.sort_id][center.key] or center.config
    else
        config = center.config
    end
    self.config.center = center
    for k, v in pairs(G.P_CENTERS) do
        if center == v then self.config.center_key = k end
    end
    if self.ability and oldcenter and oldcenter.config.bonus then
        self.ability.bonus = self.ability.bonus - oldcenter.config.bonus
    end
    local new_ability = {
        name = center.name,
        effect = center.effect,
        set = center.set,
        mult = config.mult or 0,
        h_mult = config.h_mult or 0,
        h_x_mult = config.h_x_mult or 0,
        h_dollars = config.h_dollars or 0,
        p_dollars = config.p_dollars or 0,
        t_mult = config.t_mult or 0,
        t_chips = config.t_chips or 0,
        x_mult = config.Xmult or config.x_mult or 1,
        h_chips = config.h_chips or 0,
        x_chips = config.x_chips or 1,
        h_x_chips = config.h_x_chips or 1,
    }
    self.ability = self.ability or {}
    for k, v in ipairs({new_ability, config}) do
        for kk, vv in pairs(v) do
            self.ability[kk] = copy_table(vv)
        end
    end
    if center.consumeable then 
        self.ability.consumeable = center.config
    else
    	self.ability.consumeable = nil
    end
    if self.ability.name == "Invisible Joker" then 
        self.ability.invis_rounds = 0
    end
    if self.ability.name == 'To Do List' then
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(k) then _poker_hands[#_poker_hands+1] = k end
        end
        local old_hand = self.ability.to_do_poker_hand
        self.ability.to_do_poker_hand = nil

        while not self.ability.to_do_poker_hand do
            self.ability.to_do_poker_hand = pseudorandom_element(_poker_hands, pseudoseed((self.area and self.area.config.type == 'title') and 'false_to_do' or 'to_do'))
            if self.ability.to_do_poker_hand == old_hand then self.ability.to_do_poker_hand = nil end
        end
    end
    if self.ability.name == 'Caino' then 
        self.ability.caino_xmult = 1
    end
    if self.ability.name == 'Yorick' then 
        self.ability.yorick_discards = self.ability.extra.discards
    end
    if self.ability.name == 'Loyalty Card' then 
        self.ability.burnt_hand = 0
        self.ability.loyalty_remaining = self.ability.extra.every
    end
end

function SEALS.safe_set_seal(self, _seal)
    self.seal = nil
    if _seal then
        self.seal = _seal
        self.ability.seal = {}
        for k, v in pairs(G.P_SEALS[_seal].config or {}) do
            self.ability.seal[k] = copy_table(v)
        end
    end
end

if not Card.unapply_to_run then
    function Card:unapply_to_run(center)
        local center_table = {
            name = center and center.name or self and self.ability.name,
            extra = self and self.ability.extra or center and center.config.extra,
        }
        local obj = center or self.config.center
        if obj.unredeem and type(obj.unredeem) == "function" then
            obj:unredeem(self)
            return
        end

        if center_table.name == "Overstock" or center_table.name == "Overstock Plus" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    change_shop_size(-center_table.extra)
                    return true
                end,
            }))
        end
        if center_table.name == "Tarot Merchant" or center_table.name == "Tarot Tycoon" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.tarot_rate = G.GAME.tarot_rate / center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Planet Merchant" or center_table.name == "Planet Tycoon" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.planet_rate = G.GAME.planet_rate / center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Hone" or center_table.name == "Glow Up" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.edition_rate = G.GAME.edition_rate / center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Magic Trick" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.playing_card_rate = 0
                    return true
                end,
            }))
        end
        if center_table.name == "Crystal Ball" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit - center_table.extra
                    return true
                end,
            }))
        end
        if center_table.name == "Clearance Sale" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.discount_percent = 0
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then
                            v:set_cost()
                        end
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Liquidation" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.discount_percent = 25 -- no idea why the below returns nil, so it's hardcoded now
                    -- G.GAME.discount_percent = G.P_CENTERS.v_clearance_sale.extra
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then
                            v:set_cost()
                        end
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Reroll Surplus" or center_table.name == "Reroll Glut" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + self.ability.extra
                    G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + self.ability.extra)
                    return true
                end,
            }))
        end
        if center_table.name == "Seed Money" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.interest_cap = 25 --note: does not account for potential deck effects
                    return true
                end,
            }))
        end
        if center_table.name == "Money Tree" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.used_vouchers.v_seed_money then
                        G.GAME.interest_cap = 50
                    else
                        G.GAME.interest_cap = 25
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Grabber" or center_table.name == "Nacho Tong" then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - center_table.extra
            ease_hands_played(-center_table.extra)
        end
        if center_table.name == "Paint Brush" or center_table.name == "Palette" then
            G.hand:change_size(-center_table.extra)
        end
        if center_table.name == "Wasteful" or center_table.name == "Recyclomancy" then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - center_table.extra
            ease_discard(-center_table.extra)
        end
        if center_table.name == "Antimatter" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.jokers then
                        G.jokers.config.card_limit = G.jokers.config.card_limit - center_table.extra
                    end
                    return true
                end,
            }))
        end
        if center_table.name == "Hieroglyph" or center_table.name == "Petroglyph" then
            ease_ante(center_table.extra)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + center_table.extra

            if center_table.name == "Hieroglyph" then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + center_table.extra
                ease_hands_played(center_table.extra)
            end
            if center_table.name == "Petroglyph" then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + center_table.extra
                ease_discard(center_table.extra)
            end
        end
    end
end