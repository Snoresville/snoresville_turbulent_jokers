local internal_name = "vault"
local display_name = "Vault"
local pct_interest = 2

local function get_interest(joker)
    return math.ceil(joker.sell_cost * (1 + pct_interest/100)) - joker.sell_cost
end

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 2,
    cost = 100,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "After every hand played,",
        "increase this Joker's sell price",
        "by {C:attention}#1#%{}, rounded up",
        "{C:inactive}(Current interest: {C:money}$#2#{C:inactive})",
    }
}

joker.functions.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            pct_interest, get_interest(card)
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if SMODS.end_calculate_context(context) and not context.blueprint then
        local difference = get_interest(card)
        card.ability.extra_value = card.ability.extra_value + difference
        card:set_cost()
        card_eval_status_text(card, 'dollars', difference, nil, nil, {})
    end
end

return joker