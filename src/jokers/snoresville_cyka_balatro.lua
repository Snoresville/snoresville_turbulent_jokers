local internal_name = "cyka_balatro"
local display_name = "Cyka Balatro"

local gamble_cost = 1
local gamble_mult_chance = 5
local gamble_mult_bonus = 20
local gamble_money_chance = 15
local gamble_money_bonus = 20

local joker = {
    name = internal_name,
    config = {
        extra = {
            mult_gained = 0
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
    functions = {}
}

joker.loc_txt = {
    name = display_name,
    text = {
        "On each {C:blue}hand{} played,",
        "gamble {C:money}$#1#{} to gain the following:",
        "{C:green}#2# in #3#{} chance to score {C:mult}+#4#{} Mult",
        "{C:green}#2# in #5#{} chance to win {C:money}$#6#{}",
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            gamble_cost,
            G.GAME.probabilities.normal,
            gamble_mult_chance,
            gamble_mult_bonus,
            gamble_money_chance,
            gamble_money_bonus,
        }
    }
end

function go_gambling(self)
    if pseudorandom(internal_name.."_mult_bonus") < G.GAME.probabilities.normal / gamble_mult_chance then
        self.ability.extra.mult_gained = self.ability.extra.mult_gained + gamble_mult_bonus
    end

    if pseudorandom(internal_name.."_money_bonus") < G.GAME.probabilities.normal / gamble_money_chance then
        G.E_MANAGER:add_event(Event({delay = 1, func = function()
            self:juice_up()
            ease_dollars(gamble_money_bonus)
            return true
        end}))
    end
end

joker.functions.calculate = function(self, card, context)
    if context.before and context.scoring_hand then
        if G.GAME.dollars - gamble_cost >= 0 then
            ease_dollars(-gamble_cost)
            go_gambling(card)
        end
    end

    if SMODS.end_calculate_context(context) and context.full_hand then
        local bonus_mult = card.ability.extra.mult_gained
        if bonus_mult > 0 then
            return {
                message = localize{type='variable',key='a_mult',vars={bonus_mult}},
                mult_mod = bonus_mult
            }
        end
    end

    if context.after then
        card.ability.extra.mult_gained = 0
    end
end

joker.ref_replacement = function()

end

return joker