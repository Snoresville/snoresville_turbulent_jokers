local joker_internal_name = "snoresville_edgeworth"
local joker_display_name = "Edgeworth"

local edging_reward = 1
local message_edged = "Edged!"

local joker = {
    name = joker_internal_name,
    slug = joker_internal_name,
    config = {
        extra = {

        },
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    loc_txt = {
        name = joker_display_name,
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt.text = {
    "You can only win a blind",
    "at zero {C:blue}hands{} remaining",
    "Gain {C:money}$#1#{} if you would win",
}

joker.functions.loc_def = function(self)
    return {edging_reward}
end

joker.functions.calculate = function(self, context)
    if context.after and not context.blueprint then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.25, func = function()
            if G.GAME.chips >= G.GAME.blind.chips then
                ease_dollars(edging_reward)
                if G.GAME.current_round.hands_left > 0 then
                    local new_goal = G.GAME.chips + 1
                    G.GAME.blind.chips = new_goal
                    G.GAME.blind.chip_text = number_format(new_goal)
                    card_eval_status_text(self, 'extra', nil, nil, nil, {
                        message = message_edged,
                        instant = true
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