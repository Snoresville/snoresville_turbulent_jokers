local MOD_ID = "SnoresvilleTurbulentJokers"
local function joker(joker_name)
    return require(SMODS.findModByID(MOD_ID).path.."src/jokers/"..joker_name)
end

local jokers = {
    joker("snoresville_emergence"),
    joker("snoresville_the_blunt"),
    joker("snoresville_tag_team"),
    joker("snoresville_negative_joker"),
    joker("snoresville_milky_way"),
    joker("snoresville_pi"),
    joker("snoresville_protagonist"),
    joker("snoresville_medic"),
    joker("snoresville_logistics"),
    joker("snoresville_mr_hands"),
    joker("snoresville_brick_wall"),
    joker("snoresville_true_gamer"),
    joker("snoresville_seasonings"),
    joker("snoresville_neat_library"),
}

return jokers