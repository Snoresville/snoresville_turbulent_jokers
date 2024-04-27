local joker_name = "snoresville_seasonings"
local chip_gain = 2
local mult_gain = 0.5
local mult_x_gain = 0.1
local hand_mult_x_gain = 0.05
local money_gain = 1

local function choose_upgrade()
    local upgrade = math.random(5)
    if upgrade == 1 then
        return "CHIPS"
    elseif upgrade == 2 then
        return "MULT"
    elseif upgrade == 3 then
        return "X_MULT"
    elseif upgrade == 4 then
        return "HAND_X_MULT"
    end

    return "MONEY"
end

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Seasonings",
        text = {
            "When a card is scored,",
            "give a random card in hand either",
            "{C:blue}+#1# chips, {C:red}+#2# Mult,",
            "{X:mult,C:white}+X#3#{C:red} Mult, {X:mult,C:white}+X#4#{C:red} Hand Mult,",
            "or {C:money}+$#5# on score{}",
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
            return {chip_gain, mult_gain, mult_x_gain, hand_mult_x_gain, money_gain}
        end,
        calculate = function(self, context)
            if context.cardarea == G.play and context.individual and #G.hand.cards > 0 then
                local card = pseudorandom_element(G.hand.cards, pseudoseed(joker_name))
                local upgrade_choice = choose_upgrade()

                if upgrade_choice == "CHIPS" then
                    card.ability.perma_bonus = card.ability.perma_bonus + chip_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+"..chip_gain.." Chips",
                        colour = G.C.CHIPS,
                    })
                elseif upgrade_choice == "MULT" then
                    card.ability.mult = card.ability.mult + mult_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+"..mult_gain.." Mult",
                        mult_mod = mult_gain,
                        colour = G.C.MULT,
                    })
                elseif upgrade_choice == "X_MULT" then
                    card.ability.x_mult = card.ability.x_mult + mult_x_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+X"..mult_x_gain.." Mult",
                        Xmult_mod = mult_x_gain,
                        colour = G.C.XMULT,
                    })
                elseif upgrade_choice == "HAND_X_MULT" then
                    card.ability.h_x_mult = (card.ability.h_x_mult ~= 0 and card.ability.h_x_mult or 1) + mult_x_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+X"..hand_mult_x_gain.." Hand Mult",
                        Xmult_mod = hand_mult_x_gain,
                        colour = G.C.XMULT,
                    })
                elseif upgrade_choice == "MONEY" then
                    card.ability.p_dollars = card.ability.p_dollars + money_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "+$"..money_gain,
                        colour = G.C.MONEY,
                    })
                end
            end
        end
    },
}

return joker