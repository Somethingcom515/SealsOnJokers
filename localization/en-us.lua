return {
    descriptions = {
        Back={
            b_soe_seal = {
                name = 'Seal Deck',
                text = {
                    "All cards in shop",
                    "have seals",
                }
            },
			b_cry_sl_deck = {
				name = "Seal Deck",
				text = {
					"All cards have a {C:dark_edition}#1#{}",
					"Cards cannot change seals",
					"{C:inactive}(Click to edit)",
				},
				unlock = {
					"Use {C:spectral}Typhoon",
				},
			},
        },
        Blind={
            bl_soe_theseal = {
                name = 'The Seal',
                text = {
                    'All cards are face down',
                    'Seals show on the back of cards during this round',
                }
            },
        },
        Edition={},
        Enhanced={},
        Joker={
            j_soe_stonecardjoker = {
                name = 'Stone Card Joker',
                text={
                    "{C:chips}+#1#{} Chips",
                },
            },
            j_soe_sealjoker = {
                name = 'Seal',
                text={
                    "Cards can have {s:3,C:soe_infinity}infinite{}",
                    "seals"
                },
            },
            j_soe_sealjoker2 = {
                name = 'Seal 2',
                text={
                    "Cards can have {X:soe_infinity,C:white}Unlimited{} amounts",
                    "of all {C:attention}properties{}",
                    "{C:inactive}(Expect more than average lag!){}"
                },
            },
            j_soe_infinityred = {
                name = 'Infinity Red',
                text={
                    "Every time a card triggers",
                    "put a {C:red}Red Seal{} on it",
                }
            },
            j_soe_infinitypurple = {
                name = 'Infinity Purple',
                text={
                    "Seals are {C:attention}forcetriggered{}",
                    "when the card it's on is scored",
                }
            },
            j_soe_infinitygold = {
                name = 'Infinity Gold',
                text={
                    "Cards played and held in hand along with jokers",
                    "give {X:money,C:white}#1#*n{} when scored,",
                    "where {C:attention}n{} is the amount of seals that card has",
                }
            },
            j_soe_infinityblue = {
                name = 'Infinity Blue',
                text={
                    "{C:green}#1# in #2#{} chance for",
                    "each scored card to be copied",
                    "as a {C:dark_edition}Negative{} Joker"
                }
            },
            j_soe_extralife = {
                name = 'Extra Life',
                text={
                    "Prevents a game over {C:attention}#1#{} times",
                }
            },
            j_soe_unorganizedjoker = {
                name = 'Unorganized Joker',
                text={
                    "If a card has a property that was not meant for that card,",
                    "it gives {X:mult,C:white}X#1#{} Mult",
                }
            },
            j_soe_seeder = {
                name = 'Seeder',
                text={
                    "Change the current runs {C:attention}seed{}",
                    "once per ante",
                    "{C:inactive}(#1#){}"
                }
            },
            j_soe_v_blankjoker = {
                name = 'Blank Joker',
                text={
                    "In {C:attention}#1#{} rounds, turn into",
                    "{C:dark_edition}Antimatter Joker{}",
                }
            },
            j_soe_v_antimatterjoker = {
                name = 'Antimatter Joker',
                text={
                    "{C:attention}ALL{} {C:dark_edition}Negative{} cards",
                    "give {X:mult,C:white}X#1#{} Mult",
                    "and {C:dark_edition}Negative{} is {X:dark_edition,C:white}#2#X{} as often to appear"
                }
            },
            j_soe_c_talismanjoker = {
                name = 'Talisman Joker',
                text={
                    "Gives a random scoring card",
                    "A {C:attention}Gold Seal{}",
                    "{C:inactive}(if possible){}",
                }
            },
            j_soe_thinkingemoji = {
                name = 'Thinking Emoji',
                text={
                    "Gains {X:dark_edition,C:white}^#1#{} Mult",
                    "for every idea that I get",
                    "Every non-playing card that mentions seals gives {X:dark_edition,C:white}^#3#{} Mult",
                    "{C:inactive}(Currently {}{X:dark_edition,C:white}^#2#{} {C:inactive}Mult){}",
                }
            },
            j_soe_reversesplash = {
                name = 'Drought',
                text={
                    "{C:attention}Played cards{} don't",
                    "count in scoring",
                },
            },
            j_soe_ascendedjoker = {
                name = 'Every Joker',
                text={
                    "All at the same time",
                }
            },
            j_soe_someinone = {
                name = 'Some Jokers',
                text={
                    "Click this joker to choose a joker to replicate permanently!",
                    "{C:inactive}(Expect crashes!){}",
                }
            },
            j_soe_allinone = {
                name = 'Almost LITERALLY EVERY Joker',
                text={
                    "ALL at the same time",
                }
            },
            j_joker_u = {
                name="Joker",
                text={
                    "{C:chips,s:1.1}+#2#{} Chips",
                    "{C:red,s:1.1}+#1#{} Mult",
                    "{X:red,s:1.1,C:white}X#3#{} Mult"
                },
            },
            j_soe_raspberryprint = {
                name = 'Raspberryprint',
                text={
                    "Copies the ability of a random {C:attention}Joker{}",
                    "{C:inactive}(Any Joker that exists is valid){}",
                    "{C:inactive}(Resets every round and cannot copy itself){}",
                    "{C:inactive}(Currently copying: #1#){}",
                }
            },
            j_soe_purpureusprint = {
                name = 'Purpureusprint',
                text={
                    "Copies the ability of a random {C:tarot}Tarot{}/{C:planet}Planet{}",
                    "{C:inactive}(Any Tarot/Planet that exists is valid){}",
                    "{C:inactive}(Resets every round){}",
                    "{C:inactive}(Currently copying: #1#){}",
                }
            },
            j_soe_amazonprint = {
                name = 'Amazonprint',
                text={
                    "Copies the ability of a random {C:attention}Voucher{}",
                    "{C:inactive}(Any Voucher that exists is valid){}",
                    "{C:inactive}(Resets every round){}",
                    "{C:inactive}(Currently copying: #1#){}",
                }
            },
            j_soe_newinfinifusion = {
                name = "{C:dark_edition}NEW{} InfiniFusion",
                text = {
                    "A {C:dark_edition}NEW{} fusion of",
                    "{C:attention}multiple{} Jokers"
                }
            }
        },
        Other={
            soe_sealseal_seal = {
                name = 'Seal Seal',
                text = {
                    'If this card has a second seal,',
                    'Spread it to adjacent cards before scoring',
                    'Otherwise, {C:mult}+#1#{} Mult'
                },
            },
            soe_rainbowseal_seal = {
                name = 'Rainbow Seal',
                text = {
                    "This card counts as {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
                    "and {C:dark_edition}Polychrome{}",
                },
            },
            soe_reverseseal_seal = {
                name = 'Reverse Seal',
                text = {
                    'If this card is facing {C:attention}down{},',
                    '{X:mult,C:white}X#1#{} Mult',
                },
            },
            soe_negativeseal_seal = {
                name = 'Negative Seal',
                text = {
                    'This card {C:attention}ignores{} the selection limit,',
                },
            },
            soe_carmineseal_seal = {
                name = 'Carmine Seal',
                text = {
                    'If this card is played and not scored,',
                    'destroy this card',
                },
            },
            soe_aquaseal_seal = {
                name = 'Aqua Seal',
                text = {
                    'If this card is played and not scored,',
                    'destroy this card',
                },
            },
            soe_yellowseal_seal = {
                name = 'Yellow Seal',
                text = {
                    'This card is returned to hand',
                    'after scoring',
                },
            },
            soe_foilseal_seal = {
                name = 'Foil Seal',
                text = {
                    '{C:dark_edition}Editions{} on this card',
                    'happen when {C:attention}triggered{} instead',
                },
            },
            soe_holoseal_seal = {
                name = 'Holographic Seal',
                text = {
                    "This card will {C:attention}retrigger{}",
                    "until a {C:green}probability{} hits"
                },
            },
            soe_rustyseal_seal = {
                name = 'Rusty Seal',
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "when this card is {C:attention}retriggered{}"
                },
            },
            red_seal_joker = {
                name="Red Seal",
                text={
                    "Retrigger this",
                    "Joker {C:attention}1{} time",
                },
            },
            purple_seal={
                name="Purple Seal",
                text={
                    "Creates a {C:tarot}Tarot{} card",
                    "when {C:attention}discarded",
                    "{C:inactive}(Must have room)",
                },
            },
            purple_seal_joker = {
                name="Purple Seal",
                text={
                    "Creates a {C:tarot}Tarot{} card",
                    "when {C:attention}sold",
                    "{C:inactive}(Must have room)",
                },
            },
            gold_seal={
                name="Gold Seal",
                text={
                    "Earn {C:money}$3{} when this",
                    "card is played",
                    "and scores",
                },
            },
            gold_seal_joker = {
                name="Gold Seal",
                text={
                    "Earn {C:money}$3{} when this",
                    "Joker triggers",
                },
            },
            blue_seal_joker = {
                name="Blue Seal",
                text={
                    "Creates the {C:planet}Planet{} card",
                    "for final played {C:attention}poker hand{}",
                    "of round",
                    "{C:inactive}(Must have room)",
                },
            },
            cry_green_seal_joker = {
				name = "Green Seal",
				text = {
					"Creates a {C:cry_code}Code{} card",
					"when this Joker does not score",
					"{C:inactive}(Must have room)",
				},
			},
            cry_azure_seal_joker = {
				name = "Azure Seal",
				text = {
					"Create {C:attention}3{} {C:dark_edition}Negative{}",
					"{C:planet}Planets{} for played",
					"{C:attention}poker hand{}, then",
					"{C:red}destroy{} this Joker",
				},
			},
            legallygold = {
                name="Gold Card",
                text={
                    "{C:money}$#1#{} at",
                    "end of round",
                },
            },
            legallysleevePlasma = {
                name = "Plasma Sleeve",
                text = G.localization.descriptions.Back["b_plasma"].text
            },
            sealevolve = {
                name = "Seal Evolve",
                text = {
                    "If all Cards in deck have an enhancement, edition",
                    "and 2 or more seals, evolve into {X:soe_infinity,C:white}Seal{} {X:soe_infinity,C:white}2{}",
                }
            },
            p_soe_synonym_normal = {
                name = "Synonym Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {X:soe_synonym_gradient,C:white}Synonym{} cards to",
                    "be used immediately",
                },
            }
        },
        Planet={
            c_soe_demjoker={
                name="Dem Joker",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
				},
            },
        },
        Spectral={
            c_soe_dejavuq = {
                name = 'Deja Vu?',
                text = {
                    'Add a {C:red}Red Seal{}',
                    'to a random joker',
                }
            },
            c_soe_tranceq = {
                name = 'Trance?',
                text = {
                    'Add a {C:blue}Blue Seal{}',
                    'to a random joker',
                }
            },
            c_soe_talismanq = {
                name = 'Talisman?',
                text = {
                    'Add a {C:gold}Gold Seal{}',
                    'to a random joker',
                }
            },
            c_soe_mediumq = {
                name = 'Medium?',
                text = {
                    'Add a {C:purple}Purple Seal{}',
                    'to a random joker',
                }
            },
            c_soe_typhoonq = {
                name = 'Typhoon?',
                text = {
                    'Add a {C:cry_azure}Azure Seal{}',
                    'to a random joker',
                }
            },
            c_soe_sourceq = {
                name = 'Source?',
                text = {
                    'Add a {C:cry_code}Green Seal{}',
                    'to a random joker',
                }
            },
            c_soe_eternalq = {
                name = 'Eternal?',
                text = {
                    'Add {C:attention}Eternal{}',
                    'to a random card in hand',
                }
            },
            c_soe_dejavuqq = {
                name = 'Deja Vu??',
                text = {
                    'Add a {C:red}Red Seal{}',
                    'to a random consumable',
                }
            },
            c_soe_dejavuqqq = {
                name = 'DEJA VU???',
                text = {
                    'Add a {C:red}Red Seal{}',
                    'to the blind',
                }
            },
            c_soe_allinone = {
                name = 'ALL IN ONE???',
                text = {
                    "UNBELIEVEABLE"
                }
            },
        },
        Stake={},
        Tag={},
        Tarot={
            c_soe_devilq = {
                name = 'Devil?',
                text = {
                    'Add the {C:attention}Gold{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_towerq = {
                name = 'Tower?',
                text = {
                    'Add the {C:attention}Stone{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_chariotq = {
                name = 'Chariot?',
                text = {
                    'Add the {C:attention}Steel{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_empressq = {
                name = 'Empress?',
                text = {
                    'Add the {C:attention}Mult{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_hierophantq = {
                name = 'Hierophant?',
                text = {
                    'Add the {C:attention}Bonus{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_magicianq = {
                name = 'Magician?',
                text = {
                    'Add the {C:attention}Lucky{} Enhancement',
                    'to a random joker',
                }
            },
            c_soe_justiceq = {
                name = 'Justice?',
                text = {
                    'Add the {C:attention}Glass{} Enhancement',
                    'to a random joker',
                }
            },
        },
        Voucher={
            v_soe_blueprint = {
                name = "Blueprint",
                text = {
                    "Copies ability of",
                    "another {C:attention}Voucher{}",
                    "{C:inactive}(Currently copying: #1#){}",
                }
            },
            v_soe_brainstorm = {
                name = "Brainstorm",
                text = {
                    "Copies the ability",
                    "of another {C:attention}Voucher{}",
                    "{C:inactive}(Currently copying: #1#){}",
                }
            },
            v_soe_orbitalconnoisseur = {
                name = "Orbital Connoisseur",
                text = {
                    "{C:attention}Joker Hands{} are now available and",
                    "{C:soe_orbital}Orbital{} cards can now appear in the shop",
                }
            },
            v_soe_rerolloverflow = {
                name = "Reroll Overflow",
                text = {
                    "{C:green}Rerolls{} are",
                    "{C:attention}#1#%{} off",
                }
            },
        },
        Sleeve = {
            sleeve_soe_seal = {
                name = "Seal Sleeve",
                text = {
                    "All cards in shop",
                    "have seals",
                }
            },
            sleeve_soe_seal_extra = {
                name = "Seal Sleeve",
                text = {
                    "Cards can have {C:attention}2{} Seals",
                }
            },
            sleeve_soe_redseal = {
                name = "Red Seal",
                text = {
                    "Effects of this deck",
                    "happen twice",
                    "{C:inactive}(#1#){}"
                }
            },
            sleeve_soe_goldseal = {
                name = "Gold Seal",
                text = {
                    "First scoring card",
                    "each hand gives {C:money}$3{}",
                }
            },
        },
        BakeryCharm = {
			BakeryCharm_soe_sealcharm={
				name = "Seal Charm",
                text = {
                    "Seal effects are doubled"
                }
			},
		},
        SkillPerks = {
            sp_soe_egg_upgrade1 = {
                name = "Egg",
                text = {
                    "Egg upgrades by {C:money}$5{}",
                    "{C:inactive}(#1#/1)",
                }
            },
            sp_soe_egg_upgrade1_name = {
                name = "Egg",
                text = {
                    "Egg",
                }
            },
            sp_soe_egg_upgrade2 = {
                name = "Egg",
                text = {
                    "Egg upgrades by {C:money}$8{}",
                    "{C:inactive}(#1#/1)",
                }
            },
            sp_soe_egg_upgrade2_name = {
                name = "Egg",
                text = {
                    "Egg",
                }
            },
            sp_soe_egg_upgrade3 = {
                name = "Egg",
                text = {
                    "{C:green}1 in 4{} chance to give sell value",
                    "at end of round",
                    "{C:inactive}(#1#/1)",
                }
            },
            sp_soe_egg_upgrade3_name = {
                name = "Egg",
                text = {
                    "Egg",
                }
            },
            sp_soe_egg_upgrade4 = {
                name = "Egg",
                text = {
                    "Egg upgrades by {C:money}$15{}",
                    "{C:inactive}(#1#/1)",
                }
            },
            sp_soe_egg_upgrade4_name = {
                name = "Egg",
                text = {
                    "Egg",
                }
            },
            sp_soe_egg_upgrade5 = {
                name = "Egg",
                text = {
                    "Egg upgrade 3's chance is improved to {C:green}1 in 2{}",
                    "Guaranteed if blind is a boss blind",
                    "{C:inactive}(#1#/1)",
                }
            },
            sp_soe_egg_upgrade5_name = {
                name = "Egg",
                text = {
                    "Egg",
                }
            },
        },
        soe_Vice = {
            c_soe_idiot = {
                name="The Idiot",
				text = {
                    "Creates the last",
                    "{C:attention}Joker{} card",
                    "sold during this run",
				},
            },
            c_soe_governor = {
                name="The Governor",
                text={
                    "Creates a {X:soe_synonym_gradient,C:white}Synonym{} card",
                    "and its original",
                    "{C:inactive}(Must have room)",
                },
            },
            c_soe_energy = {
                name="Energy",
                text={
                    "Increases all values of",
                    "up to {C:attention}#1#{} selected",
                    "#3# by {C:attention}#2#{}",
                    "{C:inactive}(May cause issues){}"
                },
            },
            c_soe_gallowsbird = {
                name="The Gallows Bird",
                text={
                    "Destroys up to",
                    "{C:attention}#1#{} selected Jokers",
                    "{C:inactive}(Bypasses{} {X:dark_edition,C:soe_synonym_gradient}LITERALLY{} {X:dark_edition,C:soe_synonym_gradient}EVERYTHING{}{C:inactive}){}"
                },
            },
            c_soe_murder = {
                name = 'Murder',
                text = {
                    "Select {C:attention}#1#{} Jokers,",
                    "convert the {C:attention}left{} Joker",
                    "into the {C:attention}right{} Joker",
                    "{C:inactive}(Drag to rearrange)",
                }
            },
        },
        soe_Orbital = {
            c_soe_degrade={
                name="Degrade",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#{}",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
				},
            },
        },
        soe_Phantom = {
            c_soe_sacrifice = {
                name = 'Sacrifice',
                text = {
                    "Destroys {C:attention}#1#{} random",
                    "Jokers,",
                    "gain {C:money}$#2#",
                },
            },
            c_soe_decimal = {
                name = 'Decimal',
                text = {
                    "Add {C:dark_edition}Polychrome{} to a",
                    "random {C:attention}Playing card{} in hand, destroy",
                    "all other Playing cards in hand",
                },
            },
            c_soe_ghost = {
                name = 'Ghost',
                text = {
                    "Create {C:attention}#1#{} copies of",
                    "{C:attention}1{} selected Joker",
                },
            },
            c_soe_psyche = {
                name = 'Psyche',
                text = {
                    "Creates an",
                    "{X:soe_seal_gradient,C:white}Infinity{} Joker",
                    "{C:inactive}(Must have room){}"
                },
            },
            c_soe_dejajed = {
                name = 'Dej{f:soe_11x6m}ajeD',
                text = {
                    '{C:attention}Detach{} a seal',
                    'from any {C:attention}1{} selected',
                    'card'
                }
            },
        },
        soe_DetachedSeal = {
            Red = {
                name = 'Red Seal',
                text = {
                    "{C:attention}Retriggers{} the closest",
                    "card or joker or consumable {C:attention}#1#{} time(s)",
                }
            },
            Blue = {
                name = 'Blue Seal',
                text = {
                    "Creates the {C:planet}Planet{} card",
                    "for final played {C:attention}poker hand{}",
                    "of round",
                },
            },
            Gold = {
                name = 'Gold Seal',
                text = {
                    "Gives {C:money}$#1#{}",
                    "before scoring"
                }
            },
            Purple = {
                name = 'Purple Seal',
                text = {
                    "Creates a {C:tarot}Tarot{} card",
                    "when {C:attention}discarding{}",
                    "{C:inactive}(Must have room)",
                },
            }
        },
    },
    misc = {
        achievement_descriptions={
            ach_soe_completionist_plus_plus_plus = "Earn a Gold Sticker on every Playing Card",
        },
        achievement_names={
            ach_soe_completionist_plus_plus_plus = "Completionist+++",
        },
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_soe_infinity = "Infinity",

            k_following_joker_hands = "Contributes to the following Joker Hands:",
            k_joker_hands = "Joker Hands",
        
            b_soe_orbital_cards = "Orbital Cards",
            k_soe_orbital = "Orbital",
            b_soe_phantom_cards = "Phantom Cards",
            k_soe_phantom = "Phantom",
            b_soe_vice_cards = "Vice Cards",
            k_soe_vice = "Vice",
            k_synonym_pack = "Synonym Pack",
            k_life_used = "Life Used!",
            
            soe_skill_tree_jokerupgrades = "Joker Upgrades",
        },
        high_scores={},
        labels={
            soe_sealseal_seal = 'Seal Seal',
            soe_rainbowseal_seal = 'Rainbow Seal',
            soe_reverseseal_seal = 'Reverse Seal',
            soe_negativeseal_seal = 'Negative Seal',
            soe_carmineseal_seal = 'Carmine Seal',
            soe_aquaseal_seal = 'Aqua Seal',
            soe_yellowseal_seal = 'Yellow Seal',
            soe_foilseal_seal = 'Foil Seal',
            soe_holoseal_seal = 'Holographic Seal',
            soe_rustyseal_seal = 'Rusty Seal',

            k_soe_infinity = "Infinity",
        },
        poker_hand_descriptions = {
            soe_joker_central = {"5 Jokers"},
            soe_nil = {"nil"},
            soe_seal_flush = {"5 cards that share the same seal"},
        },
        poker_hands = {
            soe_joker_central = "Joker Central",
            soe_nil = "nil",
            soe_seal_flush = "Seal Flush",
        },
        soe_joker_hands = {
            soe_simple_jimbo = "A Simple Jimbo",
            soe_best_brothers = "Best Brothers",
        },
        quips={
            again = {
                "Again!"
            }
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={},
        v_text={},
    },
}
