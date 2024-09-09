local internal_name = "shortcut_to_library"
local display_name = "Shortcut to Libary"

local deck = {
    name = internal_name,
    config = {},
    sprite_pos = {x = 1, y = 4},
    setup_functions = {}
}

deck.loc_txt = {
    name = display_name,
    text = {
        "Start with a {C:attention}Eternal Shortcut{}",
        "and an {C:attention}Eternal Ordered Library{}"
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
        deck_joker("shortcut", nil, nil, true, false),
        deck_joker("neat_library", nil, nil, true, true)
    }
end

return deck