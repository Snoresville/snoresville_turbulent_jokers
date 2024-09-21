local internal_name = "true_gamer"
local display_name = "True Gamer"

local prefix = G.SnoresvilleTurbulentJokers_getConfig().prefix

local beaten_message = "Beaten!"
local base_chips = 25

local function current_chips(players_beaten)
    return base_chips * (2 ^ players_beaten)
end

local function beat_gamer(self, beating_card)
    beating_card.getting_sliced = true
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            card_eval_status_text(beating_card, 'extra', nil, nil, nil, {
                message = beaten_message,
                colour = G.C.RED,
                instant = true,
            })
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            beating_card:shatter()
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            self.ability.extra.players_beaten = self.ability.extra.players_beaten + 1
            card_eval_status_text(self, 'extra', nil, nil, nil, {
                message = localize{type = 'variable', key = 'a_chips', vars = {current_chips(self.ability.extra.players_beaten) - current_chips(self.ability.extra.players_beaten - 1)}},
                colour = G.C.BLUE,
                instant = true,
            })
            return true
        end
    }))
end

local joker = {
    name = internal_name,
    config = {
        extra = {
            players_beaten = 0
        }
    },
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
        "At the start of a blind,",
        "fight all {C:attention}#1#{}s,",
        "and double the {C:blue}Chips{} scored",
        "for each {C:attention}#1#{} beaten",
        "{C:inactive}(Currently {C:blue}+#2# Chips{C:inactive})",
    }
}

joker.functions.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            display_name, current_chips(card.ability.extra.players_beaten)
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint and not card.getting_sliced then
        for i = 1, #G.jokers.cards do
            local other_card = G.jokers.cards[i]
            if other_card ~= card
            and not other_card.ability.eternal
            and not other_card.getting_sliced
            and other_card.ability.name == "j_"..prefix.."_"..internal_name
            and card.ability.extra.players_beaten >= other_card.ability.extra.players_beaten then
                beat_gamer(card, other_card)
            end
        end
    end

    if SMODS.end_calculate_context(context) and context.full_hand and not card.getting_sliced then
        local bonus_chips = current_chips(card.ability.extra.players_beaten)
        return {
            message = localize{type='variable',key='a_chips',vars={bonus_chips}},
            chip_mod = bonus_chips
        }
    end
end


return joker