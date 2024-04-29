local joker_name = "snoresville_mr_hands"
local trigger_message = "Mr. Hands grabs your deck..."

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    soulPos = {x = 1, y = 0},
    loc_txt = {
        name = "Mr. Hands",
        text = {
            "{C:attention}Draw your entire deck{}",
            "into your hand",
            "at the start of the blind",
        }
    },
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        calculate = function(self, context)
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
                            self:juice_up(0.3, 0.5)
                            draw_card(G.deck, G.hand, i*100/card_count, nil, true, nil, 0.07)
                        end
                        return true end }))
                        return true
                    end
                }))
            end
        end
    },
}

return joker