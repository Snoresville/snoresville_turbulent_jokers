local deck_internal_name = "snoresville_tag_fanatics"
local deck_display_name = "Tag Fanatic Deck"

local deck = {
    name = deck_internal_name,
    slug = deck_internal_name,
    config = {},
    sprite_pos = {x = 2, y = 4},
    loc_txt = {
        name = deck_display_name,
    },
    setup_functions = {}
}

deck.loc_txt.text = {
    "Start with 5",
    "{C:attention}Eternal{} Tag Teams",
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
        deck_joker("j_snoresville_tag_team", nil, nil, true),
        deck_joker("j_snoresville_tag_team", nil, nil, true),
        deck_joker("j_snoresville_tag_team", nil, nil, true),
        deck_joker("j_snoresville_tag_team", nil, nil, true),
        deck_joker("j_snoresville_tag_team", nil, nil, true),
    }
end

return deck