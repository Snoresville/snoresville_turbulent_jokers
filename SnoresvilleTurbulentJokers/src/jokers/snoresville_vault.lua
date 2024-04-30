local joker_internal_name = "snoresville_vault"
local joker_display_name = "Vault"
local pct_interest = 2

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
    blueprint_compat = true,
    eternal_compat = false,
    functions = {},
}

joker.loc_txt.text = {
    "After every hand played,",
    "increase this Joker's sell price",
    "by {C:attention}#1#%{}, rounded up",
}

joker.functions.loc_def = function(self)
    return {pct_interest}
end

joker.functions.calculate = function(self, context)
    if SMODS.end_calculate_context(context) and not context.blueprint then
        local old_sell_cost = self.sell_cost
        local new_sell_cost = math.ceil(old_sell_cost * (1 + pct_interest/100))
        local difference = new_sell_cost - old_sell_cost
        self.ability.extra_value = self.ability.extra_value + difference
        self:set_cost()
        card_eval_status_text(self, 'dollars', difference, nil, nil, {})
    end
end

return joker