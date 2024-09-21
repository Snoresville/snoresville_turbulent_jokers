local internal_name = "the_blunt"
local display_name = "The Blunt"

local starting_chips = 10
local starting_mult = 1

local joker = {
    name = internal_name,
    config = {
        extra = {
            chips = starting_chips,
            mult = starting_mult,
            smoked = {},
        }
    },
    spritePos = {x = 0, y = 0},
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {}
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Unscored cards are fed into {C:green}The Blunt{}.",
        "Adds {C:blue}Chips{} and {C:red}Mult{} every time",
        "a card is scored in {C:attention}High Card{} hands.",
        "{C:inactive}(Currently {C:blue}+#1# Chips{C:inactive} and {C:red}+#2# Mult{C:inactive})"
    }
}

joker.functions.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            card.ability.extra.chips, card.ability.extra.mult
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.scoring_name == "High Card" and context.cardarea == G.play and context.individual then
        return {
            chips = card.ability.extra.chips,
            mult = card.ability.extra.mult,
            card = card
        }
    end
    if context.cardarea == G.jokers and context.before then
        for i = 1, #context.full_hand do
            local other_card = context.full_hand[i]
            local destroyed = true

            for j = 1, #context.scoring_hand do
                if context.scoring_hand[j] == other_card then
                    destroyed = false
                    break
                end
            end

            if destroyed then
                local bonus_chips = other_card.base.nominal + other_card.ability.bonus + (other_card.ability.perma_bonus or 0) + (other_card.edition and other_card.edition.chips or 0)
                local bonus_mult = (other_card.ability.mult or 0) + (other_card.edition and other_card.edition.mult or 0)
                card.ability.extra.chips = card.ability.extra.chips + bonus_chips
                card.ability.extra.mult = card.ability.extra.mult + bonus_mult
                table.insert(card.ability.extra.smoked, other_card)

                if not other_card.getting_sliced then
                    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.5, func = function()
                        if other_card and not other_card.shattered and not other_card.destroyed then
                            other_card.destroyed = true
                            other_card:start_dissolve()
                            card_eval_status_text(other_card, 'extra', nil, nil, nil, {
                                message = "Smoked",
                                colour = G.C.RED,
                                instant = true
                            })
                        end
                        return true
                    end}))
                end
                other_card.getting_sliced = true

                G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                    if bonus_chips > 0 then
                        card_eval_status_text(card, 'chips', bonus_chips, nil, nil, {
                            instant = true
                        })
                    end
                    return true
                end}))
                G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                    if bonus_mult > 0 then
                        card_eval_status_text(card, 'mult', bonus_mult, nil, nil, {
                            instant = true
                        })
                    end
                    return true
                end}))
            end
        end
    elseif context.end_of_round then
        -- This is how cards are permanently removed from the deck with the blunt
        -- The destroy methods above are not enough
        if not context.blueprint and not context.repetition then
            for i = 1, #card.ability.extra.smoked do
                card.ability.extra.smoked[i]:start_dissolve(nil, true, 0, true)
            end
            card.ability.extra.smoked = {}
        end
    end
end

return joker