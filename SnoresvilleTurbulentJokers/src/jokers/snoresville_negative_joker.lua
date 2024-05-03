local joker_name = "snoresville_negative_joker"
local bonus_mult = -4
local extra_joker_slots = 1

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Negative Joker",
        text = {
            "{C:red}#1#{} Mult,",
            "{C:dark_edition}+#2#{} Joker slot",
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
            return {bonus_mult >= 0 and "+"..bonus_mult or bonus_mult, extra_joker_slots}
        end,
        calculate = function(self, context)
            -- if else if else if else if else if else in state_events.lua
            -- this function is a god send
            if SMODS.end_calculate_context(context) and context.full_hand then
                return {
                    message = localize{type='variable',key='a_mult',vars={bonus_mult}},
                    mult_mod = bonus_mult
                }
            end
        end
    },
    ref_replacement = function()
        local buy_space_ref = G.FUNCS.check_for_buy_space
        G.FUNCS.check_for_buy_space = function(card)
            if card.ability.name == joker_name then
                return true
            end
            return buy_space_ref(card)
        end

        local button_can_select_card_ref = G.FUNCS.can_select_card
        G.FUNCS.can_select_card = function(e)
            local card = e.config.ref_table
            if card.ability and card.ability.name == joker_name then
                e.config.colour = G.C.GREEN
                e.config.button = 'use_card'
            else
                button_can_select_card_ref(e)
            end
        end

        local card_add_to_deck_ref = Card.add_to_deck
        Card.add_to_deck = function(self, from_debuff)
            if self.ability and self.ability.name == joker_name and G.jokers then
                G.jokers.config.card_limit = G.jokers.config.card_limit + extra_joker_slots
            end
            card_add_to_deck_ref(self, from_debuff)
        end

        local card_remove_from_deck_ref = Card.remove_from_deck
        Card.remove_from_deck = function(self, from_debuff)
            if self.added_to_deck and G.jokers then
                if self.ability and self.ability.name == joker_name then
                    G.jokers.config.card_limit = G.jokers.config.card_limit - extra_joker_slots
                end
            end
            card_remove_from_deck_ref(self, from_debuff)
        end
    end
}

return joker