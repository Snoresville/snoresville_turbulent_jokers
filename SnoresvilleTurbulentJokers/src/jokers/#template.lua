-- used to template
local joker_internal_name = "snoresville_joker_name"
local joker_display_name = "Joker Name Here"

local joker = {
    name = joker_internal_name,
    slug = joker_internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    loc_txt = {
        name = joker_display_name,
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt.text = {
    "example 1",
    "example 2",
    "example 3",
    "example 4",
}

joker.functions.loc_def = function(self)
    return {}
end

joker.functions.calculate = function(self, context)
    if SMODS.end_calculate_context(context) and context.full_hand then
        -- return {
        --     message = localize{type='variable',key='a_mult',vars={bonus_mult}},
        --     mult_mod = bonus_mult
        -- }
    end
end

joker.ref_replacement = function()

end

return joker