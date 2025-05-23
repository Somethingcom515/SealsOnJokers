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
                    "Cards can have {s:3,C:dark_edition}infinite{}",
                    "seals"
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
                    "Purple"
                }
            },
            j_soe_infinitygold = {
                name = 'Infinity Gold',
                text={
                    "Gold"
                }
            },
            j_soe_infinityblue = {
                name = 'Infinity Blue',
                text={
                    "Blue"
                }
            },
            j_soe_theinfinityseal = {
                name = 'The Infinity Seal',
                text={
                    "{C:dark_edition}ALL CARDS{}",
                    "Do the following things:",
                    "Give {C:money}$#1#{}",
                    "Get retriggered {C:attention}#2#{} times",
                    "Give {C:attention}#3#{} {C:dark_edition}Negative{} Black holes",
                    "Giv {C:attention}#4#{} random {C:dark_edition}Negative{} consumables",
                    "{V:1}LAG{}",
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
                    "{C:inactive}(Currently {}{X:dark_edition,C:white}^#2#{} {C:inactive}Mult){}",
                }
            },
            j_soe_reversesplash = {
                name = 'Drought',
                text={
                    "{C:attention}Played{} cards do {C:attention}not{} score",
                }
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
                    '{C:inactive}(For Jokers){}',
                    'If this Joker has an edition,',
                    'Scored cards will give the edition mult/chips',
                    '{C:inactive}(For Playing Cards){}',
                    'If this card has an edition,',
                    '1 in 4 chance cards in hand will give the edition mult/chips',
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
            red_seal_joker = {
                name="Red Seal",
                text={
                    "Retrigger this",
                    "Joker {C:attention}1{} time",
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
            gold_seal_joker = {
                name="Gold Seal",
                text={
                    "Earn {C:money}$3{} when this",
                    "Joker is scored",
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
            legallyplasmasleeve = {
                name = "Plasma Sleeve",
                text = G.localization.descriptions.Back["b_plasma"].text
            },
        },
        Planet={
            c_soe_demjoker={
                name="Dem Joker",
				text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chip#<s>4#",
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
            }
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
                    "Vanilla seal effects are doubled"
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

            soe_hand_joker_central = "Joker Central",
            
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

            k_soe_infinity = "Infinity",
        },
        poker_hand_descriptions = {
            soe_joker_central = {"5 Jokers"},
            soe_nil = {"nil"},
        },
        poker_hands = {
            soe_joker_central = "Joker Central",
            soe_nil = "nil",
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
