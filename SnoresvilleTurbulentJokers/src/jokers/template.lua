-- used to template
local joker_name = "snoresville_joker_name"

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Joker Name Here",
        text = {
            "example 1",
            "example 2",
            "example 3",
            "example 4",
        }
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        loc_def = function(self)
            return {}
        end,
        calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- return {
                --     message = localize{type='variable',key='a_mult',vars={bonus_mult}},
                --     mult_mod = bonus_mult
                -- }
            end
        end
    },
}

return joker