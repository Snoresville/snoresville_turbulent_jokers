local deck_internal_name = "snoresville_pi_delivery"
local deck_display_name = "Pi Delivery"

local deck = {
    name = deck_internal_name,
    slug = deck_internal_name,
    config = {},
    sprite_pos = {x = 3, y = 4},
    loc_txt = {
        name = deck_display_name,
    },
    setup_functions = {}
}

deck.loc_txt.text = {
    "Start with an",
    "{C:attention}Eternal Pi{}",
    "and an {C:attention}Eternal Logistics",
}

deck.setup_functions.modify_base_cards = function(base_cards)
    return base_cards
end

local function deck_joker(name, edition, silent, eternal)
    return {
        name = name,
        edition = edition,
        silent = silent,
        eternal = eternal
    }
end

deck.setup_functions.add_deck_jokers = function()
    return {
        deck_joker("j_snoresville_pi", nil, nil, true),
        deck_joker("j_snoresville_logistics", nil, nil, true),
    }
end

deck.ref_replacement = function()

end

return deck