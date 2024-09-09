local internal_name = "edgeworth"
local display_name = "Edgeworth"

local edging_reward = 1
local message_edged = "Edged!"

local joker = {
    name = internal_name,
    config = {
        extra = {

        },
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "You can only win a blind",
        "at zero {C:blue}hands{} remaining",
        "Gain {C:money}$#1#{} if you would win",
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            edging_reward
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.after and not context.blueprint then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function()
            if G.GAME.chips >= G.GAME.blind.chips then
                ease_dollars(edging_reward)
                if G.GAME.current_round.hands_left > 0 then
                    local new_goal = G.GAME.chips + 1
                    local difference = new_goal - G.GAME.blind.chips

                    G.GAME.blind.chips = new_goal
                    G.GAME.blind.chip_text = number_format(new_goal)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = message_edged,
                        instant = true
                    })

                    local ui = G.HUD_blind:get_UIE_by_ID('HUD_blind_count')
                    attention_text({
                        text = "+"..tostring(difference),
                        scale = 0.8,
                        hold = 0.7,
                        cover = ui.parent,
                        cover_colour = G.C.BLUE,
                        align = 'cm',
                    })
                end
            end
            return true
        end}))
    end
end

joker.ref_replacement = function()

end

return joker