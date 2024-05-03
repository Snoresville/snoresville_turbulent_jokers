local function get_decks(MOD_ID)
    local function deck(deck_name)
        return require(SMODS.findModByID(MOD_ID).path.."src/decks/"..deck_name)
    end

    local decks = {
        deck("snoresville_metamorphosis"),
        deck("snoresville_shortcut_to_library"),
        deck("snoresville_ethereal_vault"),
        deck("snoresville_high_deck"),
        deck("snoresville_tag_fanatics"),
        deck("snoresville_ultimate_gamer"),
        deck("snoresville_pi_delivery"),
    }

    return decks
end

return get_decks