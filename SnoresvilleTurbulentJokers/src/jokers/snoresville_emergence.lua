local internal_name = "emergence"
local display_name = "Emergence"

local prefix = G.SnoresvilleTurbulentJokers_getConfig().prefix

local upgrade_message = "Emerge!"
local broken_message = "Broken..."

local EMERGENCE_BREAK_DENOMINATOR = 8
local metamorphosis_value_scaling = {
    ["A"] = '2',

    ["2"] = '5',
    ["3"] = '5',
    ["4"] = '5',

    ["5"] = '8',
    ["6"] = '8',
    ["7"] = '8',

    ["8"] = 'T',
    ["9"] = 'T',

    ["T"] = 'J',
    ["J"] = 'Q',
    ["Q"] = 'K',
    ["K"] = 'K',
}

local get_card_value_code = function(card)
    return (card.base.value == 'Ace' and 'A') or
    (card.base.value == 'King' and 'K') or
    (card.base.value == 'Queen' and 'Q') or
    (card.base.value == 'Jack' and 'J') or
    (card.base.value == '10' and 'T') or
    (card.base.value)
end

local get_card_suit_code = function(card)
    return SMODS.Suits[card.base.suit].card_key
end

local card_is_rspskoh = function(card)
    return card.seal == 'Red'
    and card.edition and card.edition.polychrome
    and card.ability and card.ability.name == 'Steel Card'
    and get_card_value_code(card) == 'K'
    and get_card_suit_code(card) == 'H'
end

local choose_metamorphosis_upgrade = function(card)
    local special_upgrades = {}

    if card.seal ~= 'Red' then
        special_upgrades[#special_upgrades + 1] = "SEAL"
    end
    if not (card.edition and card.edition.polychrome) then
        special_upgrades[#special_upgrades + 1] = "POLYCHROME"
    end
    if not (card.ability and card.ability.name == 'Steel Card') then
        special_upgrades[#special_upgrades + 1] = "STEEL"
    end
    if get_card_suit_code(card) ~= 'H' then
        special_upgrades[#special_upgrades + 1] = "SUIT"
    end

    local valueGoal = 13
    local valueCurrent = get_card_value_code(card)
    local valueCurrentNumeric = (valueCurrent == 'K' and 13) or
    (valueCurrent == 'Q' and 12) or
    (valueCurrent == 'J' and 11) or
    (valueCurrent == 'T' and 10) or
    (valueCurrent == 'A' and 1) or
    tonumber(valueCurrent)
    local valueDifference = valueGoal - valueCurrentNumeric

    local weights = #special_upgrades + valueDifference * 4
    local choice = math.random(weights)

    if choice <= #special_upgrades then
        return special_upgrades[choice]
    end
    return "VALUE"
end

local apply_metamorphosis_upgrade = function(card)
    local upgrade = choose_metamorphosis_upgrade(card)
    if upgrade == "SEAL" then
        card:set_seal('Red', nil, true)
    elseif upgrade == "POLYCHROME" then
        card:set_edition({polychrome = true}, true)
    elseif upgrade == "STEEL" then
        card:set_ability(G.P_CENTERS.m_steel)
    elseif upgrade == "SUIT" then
        local card_value = get_card_value_code(card)
        card:set_base(G.P_CARDS["H_"..card_value])
    elseif upgrade == "VALUE" then
        local card_suit = get_card_suit_code(card)
        local card_value_current = get_card_value_code(card)
        local card_upgrade = metamorphosis_value_scaling[card_value_current] or 'K'
        card:set_base(G.P_CARDS[card_suit.."_"..card_upgrade])
    end
    return card
end

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {}
}

joker.loc_txt = {
    name = display_name,
    text = {
        "If a scoring card is not a",
        "{C:red}Red Seal{} {C:dark_edition}Polychrome{} {C:inactive}Steel{} {C:hearts}King of Hearts{},",
        "partially transform the card towards it,",
        "{C:green}#1# in #2#{} chance of breaking the card instead."
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            G.GAME.probabilities.normal, EMERGENCE_BREAK_DENOMINATOR
        }
    }
end

joker.functions.calculate = function(self, _, context)
    if context.cardarea == G.jokers and context.after and context.scoring_hand then
        local emergenceCards = {}
        for i, card in ipairs(context.scoring_hand) do
            -- Still need this if condition for when blueprint/brainstorm is used with it
            if not card.destroyed and not card.shattered and not card_is_rspskoh(card) then
                emergenceCards[#emergenceCards + 1] = card
            end
        end

        if #emergenceCards == 0 then
            return
        end

        -- Flip the cards over for suspense...
        for i, card in ipairs(emergenceCards) do
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.15, func = function()
                if not card.destroyed and not card.shattered and not card_is_rspskoh(card) then
                    play_sound('card1')
                    card:flip()
                end
                return true
            end}))
            G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
                if not card.destroyed and not card.shattered and not card_is_rspskoh(card) then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = upgrade_message,
                        instant = true
                    })
                end
                return true
            end}))
        end
        delay(0.2)

        -- This is where I transform the cards
        for i, card in ipairs(emergenceCards) do
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function()
                if not card.destroyed and not card.shattered and not card_is_rspskoh(card) then
                    apply_metamorphosis_upgrade(card)
                end
                return true
            end}))
        end

        -- Unflip it for the fans
        for i, card in ipairs(emergenceCards) do
            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.15, func = function()
                if not card.destroyed and not card.shattered and card.facing == 'back' then
                    play_sound('tarot2')
                    card:flip()
                    card:juice_up(0.3, 0.3)
                end
                return true
            end}))
        end

        delay(0.5)
    -- This phase happens just after scoring but before triggering the joker aftermath
    elseif context.destroying_card and not context.blueprint then
        local card = context.destroying_card
        if not card.getting_sliced and not card_is_rspskoh(card) and pseudorandom('j_'..prefix..'_emergence_break') < G.GAME.probabilities.normal/EMERGENCE_BREAK_DENOMINATOR then
            card.getting_sliced = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = broken_message,
                    colour = G.C.RED,
                    instant = true
                })
                card:set_ability(G.P_CENTERS.m_glass)
                card:juice_up(0.3, 0.5)
                return true -- if i dont return true here, the game freezes
            end}))

            return true
        end
    end
end

return joker