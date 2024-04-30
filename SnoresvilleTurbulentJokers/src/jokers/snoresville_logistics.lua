local joker_name = "snoresville_logistics"

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Logistics",
        text = {
            "Apply the sum of",
            "{C:attention}after-hand{} {C:blue}Joker {C:red}Bonuses{}",
            "every time a card is scored",
        }
    },
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {
        calculate = function(self, context)
            if context.cardarea == G.play and context.individual and not context.blueprint then
                local logistics_total = {
                    chips = 0,
                    mult = 0,
                    x_mult = 1,
                    card = self,
                }

                for i=1, #G.jokers.cards do
                    local joker = G.jokers.cards[i]
                    if joker.ability.name ~= joker_name then
                        local effects = eval_card(joker, {
                            cardarea = G.jokers,
                            full_hand = G.play.cards,
                            scoring_hand = context.scoring_hand,
                            scoring_name = context.scoring_name,
                            poker_hands = context.poker_hands,
                            joker_main = true
                        })
                        if effects.jokers then
                            logistics_total.chips = logistics_total.chips + (effects.jokers.chip_mod or 0)
                            logistics_total.mult = logistics_total.mult + (effects.jokers.mult_mod or 0)
                            logistics_total.x_mult = logistics_total.x_mult * (effects.jokers.Xmult_mod or 1)
                        end
                    end
                end

                return logistics_total
            end
        end
    },
}

return joker