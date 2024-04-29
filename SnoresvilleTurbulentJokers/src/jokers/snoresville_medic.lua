local joker_name = "snoresville_medic"
local hands_increase_pct = 50

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Field Doctor",
        text = {
            "At the start of a blind,",
            "gain hands based on",
            "{C:blue}#1#%{} of the base hands,",
            "rounded up"
        }
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        loc_def = function(self)
            return {hands_increase_pct}
        end,
        calculate = function(self, context)
            if context.setting_blind then
                local amount = math.ceil(G.GAME.round_resets.hands * (hands_increase_pct / 100))
                ease_hands_played(amount)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.25,
                    func = function()
                        card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {
                            message = "+"..amount.." hands!",
                            colour = G.C.BLUE,
                            instant = true
                        })
                        return true
                    end
                }))
            end
        end
    },
}

return joker