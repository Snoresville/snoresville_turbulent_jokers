local internal_name = "negative_joker"
local display_name = "Negative Joker"

local bonus_mult = -4
local extra_joker_slots = 1

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
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
        "{C:red}#1#{} Mult,",
        "{C:dark_edition}+#2#{} Joker slot",
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            bonus_mult >= 0 and "+"..bonus_mult or bonus_mult, extra_joker_slots
        }
    }
end

joker.functions.calculate = function(self, card, context)
    -- if else if else if else if else if else in state_events.lua
    -- this function is a god send
    if SMODS.end_calculate_context(context) and context.full_hand then
        return {
            message = localize{type='variable',key='a_mult',vars={bonus_mult}},
            mult_mod = bonus_mult
        }
    end
end

joker.ref_replacement = function()
    local buy_space_ref = G.FUNCS.check_for_buy_space
    G.FUNCS.check_for_buy_space = function(card)
        if card.ability.name == internal_name then
            return true
        end
        return buy_space_ref(card)
    end

    local button_can_select_card_ref = G.FUNCS.can_select_card
    G.FUNCS.can_select_card = function(e)
        local card = e.config.ref_table
        if card.ability and card.ability.name == internal_name then
            e.config.colour = G.C.GREEN
            e.config.button = 'use_card'
        else
            button_can_select_card_ref(e)
        end
    end

    local card_add_to_deck_ref = Card.add_to_deck
    Card.add_to_deck = function(self, from_debuff)
        if self.ability and self.ability.name == internal_name and G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + extra_joker_slots
        end
        card_add_to_deck_ref(self, from_debuff)
    end

    local card_remove_from_deck_ref = Card.remove_from_deck
    Card.remove_from_deck = function(self, from_debuff)
        if self.added_to_deck and G.jokers then
            if self.ability and self.ability.name == internal_name then
                G.jokers.config.card_limit = G.jokers.config.card_limit - extra_joker_slots
            end
        end
        card_remove_from_deck_ref(self, from_debuff)
    end
end

return joker