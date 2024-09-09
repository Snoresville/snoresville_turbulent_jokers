-- used to template
local internal_name = "joker_name"
local display_name = "Joker Name Here"

local joker = {
    name = internal_name,
    config = {
        extra = {

        },
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
    yes_pool_flag = nil, -- Restricted with this flag disabled
    no_pool_flag = nil -- Restricted with this flag enabled
}

joker.loc_txt = {
    name = display_name,
    text = {
        "example 1",
        "example 2",
        "example 3",
        "example 4",
    }
}

joker.functions.loc_vars = function(self, info_queue, card)
    return {
        vars = {}
    }
end

joker.functions.calculate = function(self, card, context)
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