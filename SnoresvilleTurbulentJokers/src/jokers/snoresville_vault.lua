local joker_internal_name = "snoresville_vault"
local joker_display_name = "Vault"
local pct_interest = 2

local function get_interest(joker)
    return math.ceil(joker.sell_cost * (1 + pct_interest/100)) - joker.sell_cost
end

local joker = {
    name = joker_internal_name,
    slug = joker_internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    loc_txt = {
        name = joker_display_name,
    },
    rarity = 2,
    cost = 100,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt.text = {
    "After every hand played,",
    "increase this Joker's sell price",
    "by {C:attention}#1#%{}, rounded up",
    "{C:inactive}(Current interest: {C:money}$#2#{C:inactive})",
}

joker.functions.loc_def = function(self)
    return {pct_interest, get_interest(self)}
end

joker.functions.calculate = function(self, context)
    if SMODS.end_calculate_context(context) and not context.blueprint then
        local difference = get_interest(self)
        self.ability.extra_value = self.ability.extra_value + difference
        self:set_cost()
        card_eval_status_text(self, 'dollars', difference, nil, nil, {})
    end
end

return joker