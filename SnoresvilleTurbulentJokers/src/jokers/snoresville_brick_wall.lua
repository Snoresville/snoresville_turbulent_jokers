local joker_name = "snoresville_brick_wall"
local percentage_chips = 20

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Brick Wall",
        text = {
            "Add {C:attention}#1#%{} of the",
            "remaining required {C:blue}chips{}",
            "at the start of a blind",
        }
    },
    rarity = 1,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        loc_def = function(self)
            return {percentage_chips}
        end,
        calculate = function(self, context)
            if context.setting_blind then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.25,
                    func = function()
                        local chips_remaining = G.GAME.blind.chips - G.GAME.chips
                        local chips_gained = math.floor(chips_remaining * (percentage_chips/100))

                        G.GAME.chips = G.GAME.chips + chips_gained
                        card_eval_status_text(context.blueprint_card or self, 'chips', chips_gained, nil, nil, nil, {
                            instant = true,
                        })
                        return true
                    end
                }))
            end
        end
    },
}

return joker