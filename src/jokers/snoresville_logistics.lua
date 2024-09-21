local internal_name = "logistics"
local display_name = "Logistics"

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Apply the sum of",
        "{C:attention}after-hand{} {C:blue}Joker {C:red}Bonuses{}",
        "every time a card is scored",
    }
}

joker.functions.calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and not context.blueprint then
        local logistics_total = {
            chips = 0,
            mult = 0,
            x_mult = 1,
            card = card,
        }

        for _, joker in ipairs(G.jokers.cards) do
            if joker.ability.name ~= internal_name then
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

                    if effects.jokers.edition then
                        logistics_total.chips = logistics_total.chips + (effects.edition.chip_mod or 0)
                        logistics_total.mult = logistics_total.mult + (effects.edition.mult_mod or 0)
                        logistics_total.x_mult = logistics_total.x_mult * (effects.edition.Xmult_mod or 1)
                    end
                end
            end

            for _, other_joker in ipairs(G.jokers.cards) do
                local effects = joker:calculate_joker{
                    full_hand = G.play.cards,
                    scoring_hand = context.scoring_hand,
                    scoring_name = context.text,
                    poker_hands = context.poker_hands,
                    other_joker = other_joker
                }
                if effects then
                    logistics_total.chips = logistics_total.chips + (effects.chip_mod or 0)
                    logistics_total.mult = logistics_total.mult + (effects.mult_mod or 0)
                    logistics_total.x_mult = logistics_total.x_mult * (effects.Xmult_mod or 1)
                end
            end
        end

        return logistics_total
    end
end

return joker