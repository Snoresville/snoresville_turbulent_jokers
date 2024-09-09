local internal_name = "neat_library"
local display_name = "Ordered Library"

local prefix = G.SnoresvilleTurbulentJokers_getConfig().prefix

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Whenever possible, you will",
        "draw cards of {C:attention}unique rank{}",
    }
}

joker.functions.loc_vars = function(self)
    return {}
end

local function draw_card_neat_library(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    percent = percent or 50
    delay = delay or 0.1
    if dir == 'down' then
        percent = 1-percent
    end
    sort = sort or false
    local drawn = nil

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = delay,
        func = function()
            local chosen_card = nil
            local occupied_ranks = {}
            for _, hand_card in ipairs(G.hand.cards) do
                occupied_ranks[hand_card.base.value] = (occupied_ranks[hand_card.base.value] or 0) + 1
            end

            for _, deck_card in ipairs(G.deck.cards) do
                if not occupied_ranks[deck_card.base.value] then
                    chosen_card = deck_card
                    break
                end
            end

            if not chosen_card and #G.deck.cards > 0 then
                chosen_card = pseudorandom_element(G.deck.cards, pseudoseed(internal_name))
            end

            if chosen_card then
                stay_flipped = stay_flipped or (G.GAME and G.GAME.blind and G.GAME.blind:stay_flipped(to, chosen_card))
                if G.GAME.modifiers.flipped_cards then
                    if pseudorandom(pseudoseed('flipped_card')) < 1/G.GAME.modifiers.flipped_cards then
                        stay_flipped = true
                    end
                end
                from:remove_card(chosen_card)
                drawn = true
                to:emplace(chosen_card, nil, stay_flipped)

                if not mute and drawn then
                    if from == G.deck or from == G.hand or from == G.play or from == G.jokers or from == G.consumeables or from == G.discard then
                        G.VIBRATION = G.VIBRATION + 0.6
                    end
                    play_sound('card1', 0.85 + percent*0.2/100, 0.6*(vol or 1))
                end

                if sort then
                    to:sort()
                end
            end
            return true
        end
    }))
end

joker.ref_replacement = function()
    local draw_card_ref = draw_card
    draw_card = function(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
        delay = delay or 0.1
        if next(find_joker("j_"..prefix.."_"..internal_name))
        and from == G.deck
        and to == G.hand
        and card == nil then
            draw_card_neat_library(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
        else
            draw_card_ref(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
        end
    end
end

return joker