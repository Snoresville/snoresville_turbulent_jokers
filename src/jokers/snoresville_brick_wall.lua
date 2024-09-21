local internal_name = "brick_wall"
local display_name = "Brick Wall"

local percentage_chips = 20

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    rarity = 1,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Add {C:attention}#1#%{} of the",
        "remaining required {C:blue}chips{}",
        "at the start of a blind",
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            percentage_chips
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.setting_blind then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.25,
            func = function()
                local chips_remaining = G.GAME.blind.chips - G.GAME.chips
                local chips_gained = math.floor(chips_remaining * (percentage_chips/100))

                G.GAME.chips = G.GAME.chips + chips_gained
                card_eval_status_text(context.blueprint_card or card, 'chips', chips_gained, nil, nil, {
                    instant = true,
                })

                local ui = G.HUD:get_UIE_by_ID('chip_UI_count')
                attention_text({
                    text = "+"..tostring(chips_gained),
                    scale = 0.8,
                    hold = 1.5,
                    cover = ui.parent,
                    cover_colour = G.C.BLUE,
                    align = 'cm',
                })
                play_sound('chips1', math.random()*0.1 + 0.55, 0.42)
                return true
            end
        }))
    end
end

return joker