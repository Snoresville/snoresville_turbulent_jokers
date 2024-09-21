local internal_name = "ultimate_gamer"
local display_name = "Gamer's Journey"

local deck = {
    name = internal_name,
    config = {},
    sprite_pos = {x = 2, y = 1},
    setup_functions = {}
}

deck.loc_txt = {
    name = display_name,
    text = {
        "Start with 4",
        "{C:attention}True Gamer{}s,",
        "and a {C:attention}Showman"
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
        deck_joker("true_gamer", nil, nil, false, true),
        deck_joker("true_gamer", nil, nil, false, true),
        deck_joker("true_gamer", nil, nil, false, true),
        deck_joker("true_gamer", nil, nil, false, true),
        deck_joker("ring_master", nil, nil, false, false),
    }
end

deck.ref_replacement = function()

end

return deck