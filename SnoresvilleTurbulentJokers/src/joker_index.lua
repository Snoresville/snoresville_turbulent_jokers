local MOD_ID = "SnoresvilleTurbulentJokers"
local function joker(joker_name)
    return require(SMODS.findModByID(MOD_ID).path.."src/jokers/"..joker_name)
end

local jokers = {
    snoresville_emergence = joker("snoresville_emergence"),
    snoresville_the_blunt = joker("snoresville_the_blunt"),
    snoresville_tag_team = joker("snoresville_tag_team"),
    snoresville_negative_joker = joker("snoresville_negative_joker"),
    snoresville_milky_way = joker("snoresville_milky_way"),
    snoresville_pi = joker("snoresville_pi"),
    snoresville_protagonist = joker("snoresville_protagonist"),
    snoresville_medic = joker("snoresville_medic")
}

return jokers