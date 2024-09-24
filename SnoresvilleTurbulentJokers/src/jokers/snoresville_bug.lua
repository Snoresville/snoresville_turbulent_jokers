local internal_name = "bug"
local display_name = "Bug"

local prefix = G.SnoresvilleTurbulentJokers_getConfig().prefix

local spawn_probability = 64
local bug_message = "Bug!"

local joker = {
    name = internal_name,
    config = {
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {},
    yes_pool_flag = internal_name -- Restricted with this flag disabled
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Fixed {C:green}#1# in #2#{} chance to appear,",
        "does not require free space",
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            1, spawn_probability
        }
    }
end

local roll_spawning_bug = function()
    local edition = nil
    local success = pseudorandom('j_'..prefix..'_'..internal_name) < 1/spawn_probability

    if success then
        local edition_roll = poll_edition()
        local bug = add_joker('j_'..prefix..'_'..internal_name, edition)
        bug:set_edition(edition_roll)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card_eval_status_text(bug, 'extra', nil, nil, nil, {
                    message = bug_message
                })
                return true
            end
        }))
    end
end

--[[
    Buy,
    Sell,
    Reroll,
    Play,
    Discard,
    Exit Shop,
    Select Blind,
    Use Consumable,
    Skip Blind
]]
joker.ref_replacement = function()
    local buy_from_shop_ref = G.FUNCS.buy_from_shop
    G.FUNCS.buy_from_shop = function(e)
        buy_from_shop_ref(e)
        roll_spawning_bug()
    end

    local sell_card_ref = G.FUNCS.sell_card
    G.FUNCS.sell_card = function(e)
        sell_card_ref(e)
        roll_spawning_bug()
    end

    local reroll_shop_ref = G.FUNCS.reroll_shop
    G.FUNCS.reroll_shop = function(e)
        reroll_shop_ref(e)
        roll_spawning_bug()
    end

    local play_cards_ref = G.FUNCS.play_cards_from_highlighted
    G.FUNCS.play_cards_from_highlighted = function(e, hook)
        play_cards_ref(e, hook)
        roll_spawning_bug()
    end

    local discard_cards_ref = G.FUNCS.discard_cards_from_highlighted
    G.FUNCS.discard_cards_from_highlighted = function(e, hook)
        discard_cards_ref(e, hook)
        roll_spawning_bug()
    end

    local exit_shop_ref = G.FUNCS.toggle_shop
    G.FUNCS.toggle_shop = function(e)
        exit_shop_ref(e)
        roll_spawning_bug()
    end

    local select_blind_ref = G.FUNCS.select_blind
    G.FUNCS.select_blind = function(e)
        select_blind_ref(e)
        roll_spawning_bug()
    end

    local end_consumable_ref = G.FUNCS.end_consumeable
    G.FUNCS.end_consumeable = function(e, delayfac)
        end_consumable_ref(e, delayfac)
        roll_spawning_bug()
    end

    local skip_blind_ref = G.FUNCS.skip_blind
    G.FUNCS.skip_blind = function(e)
        skip_blind_ref(e)
        roll_spawning_bug()
    end
end

return joker