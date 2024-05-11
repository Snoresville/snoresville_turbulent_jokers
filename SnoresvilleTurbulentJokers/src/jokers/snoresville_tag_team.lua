local joker_name = "snoresville_tag_team"
local tag_denominator = 4
local tag_id = "tag_double"

local joker = {
    name = joker_name, -- If I put "Seeing Double" here, Balatro is going to kill me
    slug = joker_name,
    config = {},
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "Tag Team",
        text = {
            "{C:green}#1# in #2# chance{} to",
            "gain a {C:attention}#3#{} for every",
            "{C:attention}two cards{} of the {C:attention}same rank{}",
            "contained in a played hand"
        }
    },
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        loc_def = function(self)
            return {G.GAME.probabilities.normal, tag_denominator, G.P_TAGS[tag_id].name}
        end,
        calculate = function(self, context)
            if context.cardarea == G.jokers and context.after and context.full_hand then
                local card_pairs = {}
                for i = 1, #context.full_hand do
                    local card = context.full_hand[i]
                    if card.ability.effect ~= 'Stone Card' then
                        card_pairs[card.base.value] = (card_pairs[card.base.value] or 0) + 1
                    end
                end

                for card_face, card_freq in pairs(card_pairs) do
                    for _ = 2, card_freq, 2 do
                        if pseudorandom(joker_name) < G.GAME.probabilities.normal/tag_denominator then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = (function()
                                    card_eval_status_text(self, 'extra', nil, nil, nil, {
                                        message = "Double Tag!",
                                        colour = G.C.GREEN,
                                        instant = true
                                    })

                                    add_tag(Tag('tag_double'))
                                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                                    return true
                                end)
                            }))
                        end
                    end
                end
            end
        end
    }
}

return joker