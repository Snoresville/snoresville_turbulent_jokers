local internal_name = "metamorphosis"
local display_name = "Metamorphosis Deck"

local deck = {
    name = internal_name,
    config = {},
    sprite_pos = {x = 5, y = 1},
    setup_functions = {}
}

deck.loc_txt = {
    name = display_name,
    text = {
        "Start with an",
        "{C:attention}Eternal{} {C:dark_edition}Negative{} {C:attention}Emergence{},",
        "and a Deck full of",
        "{C:attention}Ace of Spades{}"
    }
}

deck.setup_functions.modify_base_cards = function(base_cards)
    for i = 1, #base_cards do
        local card = base_cards[i]
        card:set_base(G.P_CARDS['S_A'])
    end

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
        deck_joker("emergence", "negative", nil, true, true)
    }
end

return deck