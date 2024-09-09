-- used to template
local internal_name = "deck_name"
local display_name = "Deck Name Here"

local deck = {
    name = internal_name,
    config = {},
    sprite_pos = {x = 0, y = 0},
    loc_txt = {
        name = display_name,
    },
    setup_functions = {}
}

deck.loc_txt.text = {
    "example 1",
    "example 2",
    "example 3",
    "example 4",
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
    return {}
end

deck.ref_replacement = function()

end

return deck