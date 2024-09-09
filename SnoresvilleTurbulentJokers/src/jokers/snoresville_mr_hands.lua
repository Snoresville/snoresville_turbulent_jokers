local internal_name = "mr_hands"
local display_name = "Mr. Hands"

local trigger_message = "Mr. Hands grabs your deck..."

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    soulPos = {x = 1, y = 0},
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "{C:attention}Draw your entire deck{}",
        "into your hand",
        "at the start of the blind",
    }
}

joker.functions.calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
        G.E_MANAGER:add_event(Event({func = function()
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('gong', 0.94, 0.3)
                play_sound('gong', 0.94*1.5, 0.2)
                play_sound('tarot1', 1.5)
                attention_text({
                    scale = 1.4, text = trigger_message, hold = 5, align = 'cm', offset = {x = 0,y = -2.7}, major = G.play
                })
                local card_count = #G.deck.cards
                for i = 1, card_count do
                    card:juice_up(0.3, 0.5)
                    draw_card(G.deck, G.hand, i*100/card_count, nil, true, nil, 0.07)
                end
                return true end }))
                return true
            end
        }))
    end
end

return joker