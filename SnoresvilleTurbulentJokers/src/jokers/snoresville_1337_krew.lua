local internal_name = "1337_krew"
local display_name = "Bombsite Rusher"

local chips_per_dollar = 5
local mult_per_dollar = 2
local max_money_spent = 4

local joker = {
    name = internal_name,
    config = {
        extra = {
            money_spent = 0
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
}

joker.loc_txt = {
    name = display_name,
    text = {
        "If this Joker is on the left half of owned Jokers,",
        "this scores {C:chips}Chips{}, otherwise it scores {C:mult}Mult{}",
        "Spend up to {C:money}$#1#{} at the start of each blind to gain",
        "{C:chips}+#5#{} Chips or {C:mult}+#6#{} Mult per {C:money}$1{}",
        "{C:inactive}(Currently {C:chips}#2#{C:inactive}{C:mult}#3#{C:inactive} #4#)",
    }
}

local get_chips_scored = function(self)
    return self.ability.extra.money_spent * chips_per_dollar
end

local get_mult_scored = function(self)
    return self.ability.extra.money_spent * mult_per_dollar
end

local is_scoring_chips = function(self)
    local position = 0
    local midpoint = 0

    if G.jokers and G.jokers.cards then
        midpoint = math.floor(#G.jokers.cards / 2)
        for i, joker in ipairs(G.jokers.cards) do
            if G.jokers.cards[i] == self then
                position = i
                break
            end
        end
    end

    return position <= midpoint
end

joker.functions.loc_vars = function(self, info_queue, card)
    local scoring_chips = is_scoring_chips(card)

    return {
        vars = {
            max_money_spent,
            scoring_chips and "+"..get_chips_scored(card) or "",
            not scoring_chips and "+"..get_mult_scored(card) or "",
            scoring_chips and "Chips" or "Mult",
            chips_per_dollar,
            mult_per_dollar,
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.setting_blind then
        -- If this procs a million times, I don't want this joker to create debt
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.25,
            func = function()
                local money_spent = math.min(math.max(G.GAME.dollars - max_money_spent, 0), max_money_spent)
                if money_spent > 0 then
                    card.ability.extra.money_spent = card.ability.extra.money_spent + money_spent
                    ease_dollars(-money_spent)
                    card_eval_status_text(card, 'dollars', -money_spent, nil, nil, {
                        instant = true,
                    })
                end
                return true
            end
        }))
    end

    if SMODS.end_calculate_context(context) and context.full_hand then
        if is_scoring_chips(card) then
            local bonus_chips = get_chips_scored(card)
            return {
                message = localize{type='variable',key='a_chips',vars={bonus_chips}},
                chip_mod = bonus_chips
            }
        end

        local bonus_mult = get_mult_scored(card)
        return {
            message = localize{type='variable',key='a_mult',vars={bonus_mult}},
            mult_mod = bonus_mult
        }
    end
end

joker.ref_replacement = function()

end

return joker