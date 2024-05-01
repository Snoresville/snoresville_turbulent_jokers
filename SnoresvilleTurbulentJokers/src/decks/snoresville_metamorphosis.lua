local deck_internal_name = "snoresville_metamorphosis"
local deck_display_name = "Metamorphosis Deck"

local deck = {
    name = deck_internal_name,
    slug = deck_internal_name,
    config = {},
    sprite_pos = {x = 5, y = 1},
    loc_txt = {
        name = deck_display_name,
    },
    setup_functions = {}
}

deck.loc_txt.text = {
    "Start with an",
    "{C:attention}Eternal{} {C:dark_edition}Negative{} {C:attention}Emergence{},",
    "and a Deck full of",
    "{C:attention}Ace of Spades{}"
}

deck.setup_functions.modify_base_cards = function(base_cards)
    for i = 1, #base_cards do
        local card = base_cards[i]
        card:set_base(G.P_CARDS['S_A'])
    end

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
        deck_joker("j_snoresville_emergence", "negative", nil, true)
    }
end

return deck