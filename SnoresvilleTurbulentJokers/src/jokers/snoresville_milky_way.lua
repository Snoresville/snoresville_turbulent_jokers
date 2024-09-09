local internal_name = "milky_way"
local display_name = "Milky Way"

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    rarity = 3,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {}
}

joker.loc_txt = {
    name = display_name,
    text = {
        "When playing a hand, set the",
        "played poker hand's {C:attention}level{} equal to the ",
        "{C:attention}sum of all other poker hands' levels + 1{}",
        "contained in the full hand."
    }
}

joker.functions.calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
        local played_poker_hand = context.scoring_name
        local contained_hands = evaluate_poker_hand(context.full_hand)
        local current_level = G.GAME.hands[played_poker_hand].level
        local total_level = 1

        for hand_name, count in pairs(contained_hands) do
            if hand_name ~= "top"
            and hand_name ~= played_poker_hand
            and #count > 0 then
                total_level = total_level + math.max(G.GAME.hands[hand_name].level, 1)
            end
        end

        local difference = total_level - current_level
        if difference ~= 0 then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                handname = localize(played_poker_hand, 'poker_hands'),
                chips = G.GAME.hands[played_poker_hand].chips,
                mult = G.GAME.hands[played_poker_hand].mult,
                level = G.GAME.hands[played_poker_hand].level
            })
            level_up_hand(card, played_poker_hand, nil, difference)
        end
    end
end

return joker