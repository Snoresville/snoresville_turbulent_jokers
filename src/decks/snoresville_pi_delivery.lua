local internal_name = "pi_delivery"
local display_name = "Pi Delivery"

local deck = {
    name = internal_name,
    config = {},
    sprite_pos = {x = 3, y = 4},
    setup_functions = {}
}

deck.loc_txt = {
    name = display_name,
    text = {
        "Start with an",
        "{C:attention}Eternal Pi{}",
        "and an {C:attention}Eternal Logistics",
    }
}

deck.setup_functions.modify_base_cards = function(base_cards)
    return base_cards
end

local function deck_joker(name, edition, silent, eternal, modpack)
    return {
        name = name,
        edition = edition,
        silent = silent,
        eternal = eternal,
        modpack = modpack,
    }
end

deck.setup_functions.add_deck_jokers = function()
    return {
        deck_joker("pi", nil, nil, true, true),
        deck_joker("logistics", nil, nil, true, true),
    }
end

deck.ref_replacement = function()

end

return deck