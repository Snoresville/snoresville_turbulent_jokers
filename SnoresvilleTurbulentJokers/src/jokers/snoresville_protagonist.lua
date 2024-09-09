local internal_name = "protagonist"
local display_name = "Protagonist"

local x_mult_gain = 0.8

local function calculate_protagonist_multiplier(card_object)
    local position = 0
    local total = 0

    if G.jokers and G.jokers.cards then
        total = #G.jokers.cards
        for i = 1, total do
            if G.jokers.cards[i] == card_object then
                position = i
                break
            end
        end
    end

    return math.abs(
        x_mult_gain *
        (position - 1) *
        x_mult_gain *
        (total - position))
end

local joker = {
    name = internal_name,
    config = {
        extra = {
            joker_x_mult_gain = x_mult_gain
        }
    },
    spritePos = {x = 0, y = 0},
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {}
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Count other Jokers as {X:mult,C:white}X#1#{} Mult.",
        "Total the left and right sides separately",
        "and {C:attention}multiply{} them together. Score that amount.",
        "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
    }
}

joker.functions.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            x_mult_gain,
            calculate_protagonist_multiplier(card)
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if SMODS.end_calculate_context(context) and context.full_hand then
        local final_multiplier = calculate_protagonist_multiplier(card)
        return {
            Xmult_mod = final_multiplier,
            message = localize{
                type = 'variable',
                key = 'a_xmult',
                vars = {
                    final_multiplier
                }
            }
        }
    end
end

return joker