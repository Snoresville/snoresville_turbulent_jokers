-- used to template
local joker_name = "snoresville_mr_hands"

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
                        card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {
                            message = "MR. HANDS!!",
                            colour = G.C.DARK_EDITION,
                            instant = true
                        })
                        local card_count = #G.deck.cards
                        for i = 1, card_count do
                            draw_card(G.deck,G.hand, i*100/card_count,nil, nil , nil, 0.07)
                            G.E_MANAGER:add_event(Event({func = function() G.hand:sort() return true end}))
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