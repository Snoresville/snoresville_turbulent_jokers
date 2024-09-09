local internal_name = "medic"
local display_name = "Field Doctor"

local hands_increase_pct = 50

local function get_overheal_bonus()
    local base_amount = (G.GAME and G.GAME.round_resets and G.GAME.round_resets.hands) or 0
    local amount = math.ceil(base_amount * (hands_increase_pct / 100))
    return amount
end

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "At the start of a blind,",
        "gain extra hands based on",
        "{C:blue}#1#%{} of the base hands,",
        "rounded up",
        "{C:inactive}(Currently {C:blue}+#2# Hands{C:inactive})"
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            hands_increase_pct, get_overheal_bonus()
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.setting_blind then
        local amount = get_overheal_bonus()
        ease_hands_played(amount)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.25,
            func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                    message = "+"..amount.." hands!",
                    colour = G.C.BLUE,
                    instant = true
                })
                return true
            end
        }))
    end
end

return joker