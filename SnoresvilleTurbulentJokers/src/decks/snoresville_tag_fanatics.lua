local internal_name = "tag_fanatics"
local display_name = "Tag Fanatic Deck"

local deck = {
    name = internal_name,
    config = {},
    sprite_pos = {x = 2, y = 4},
    setup_functions = {}
}

deck.loc_txt = {
    name = display_name,
    text = {
        "Start with 5",
        "{C:attention}Eternal{} Tag Teams",
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
        deck_joker("tag_team", nil, nil, true, true),
        deck_joker("tag_team", nil, nil, true, true),
        deck_joker("tag_team", nil, nil, true, true),
        deck_joker("tag_team", nil, nil, true, true),
        deck_joker("tag_team", nil, nil, true, true),
    }
end

return deck