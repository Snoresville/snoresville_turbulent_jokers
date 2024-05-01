local deck_internal_name = "snoresville_ethereal_vault"
local deck_display_name = "Ethereal Vault"

local deck = {
    name = deck_internal_name,
    slug = deck_internal_name,
    config = {},
    sprite_pos = {x = 4, y = 0},
    loc_txt = {
        name = deck_display_name,
    },
    setup_functions = {}
}

deck.loc_txt.text = {
    "Start with an",
    "{C:attention}Eternal {C:dark_edition}Negative{C:attention} Vault",
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
        deck_joker("j_snoresville_vault", "negative", nil, true)
    }
end

return deck