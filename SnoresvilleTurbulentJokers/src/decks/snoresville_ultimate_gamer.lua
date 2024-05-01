local deck_internal_name = "snoresville_ultimate_gamer"
local deck_display_name = "Gamer's Journey"

local deck = {
    name = deck_internal_name,
    slug = deck_internal_name,
    config = {},
    sprite_pos = {x = 2, y = 1},
    loc_txt = {
        name = deck_display_name,
    },
    setup_functions = {}
}

deck.loc_txt.text = {
    "Start with 4",
    "{C:attention}True Gamer{}s,",
    "and a {C:attention}Showman"
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
        deck_joker("j_snoresville_true_gamer", nil, nil, false),
        deck_joker("j_snoresville_true_gamer", nil, nil, false),
        deck_joker("j_snoresville_true_gamer", nil, nil, false),
        deck_joker("j_snoresville_true_gamer", nil, nil, false),
        deck_joker("j_ring_master", nil, nil, false),
    }
end

deck.ref_replacement = function()

end

return deck