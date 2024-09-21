local internal_name = "sentry_gun"
local display_name = "Sentry Gun"
local engineer_internal_name = "engineer"

local prefix = G.SnoresvilleTurbulentJokers_getConfig().prefix

local message_repeat = "Fire!"
local message_disabled = "Disabled..."

local joker = {
    name = internal_name,
    config = {
        extra = {
            upgrades = 1,
            repeat_distribution = {}
        },
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 2,
    cost = 0,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
    yes_pool_flag = internal_name, -- Restricted with this flag disabled
}

joker.loc_txt = {
    name = display_name,
    text = {
        "Retrigger a scoring card",
        "for each upgrade this Joker has",
        "{X:green,C:white}#2#{}{X:mult,C:white}#3#{}",
        "{C:inactive}(Currently has {C:attention}#1#{C:inactive} upgrades)",
    }
}

local has_engineer = function()
    if not G.jokers or not G.jokers.cards then return false end
    for _, joker in ipairs(G.jokers.cards) do
        if joker.ability.name == "j_"..prefix.."_"..engineer_internal_name then
            return true
        end
    end
end

joker.functions.loc_vars = function(self, info_queue, card)
    local engineer_exists = has_engineer()
    return {
        vars = {
            card.ability.extra.upgrades,
            engineer_exists and "Active!" or "",
            not engineer_exists and "Inactive! Engineer must be owned!" or "",
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.before and context.scoring_hand then
        card.ability.extra.repeat_distribution = {}
        local scoring_hand_count = #context.scoring_hand

        for i = 1, scoring_hand_count do
            card.ability.extra.repeat_distribution[i] = 0
        end
        for i = 1, card.ability.extra.upgrades do
            local distributed_index = math.random(scoring_hand_count)
            card.ability.extra.repeat_distribution[distributed_index] = card.ability.extra.repeat_distribution[distributed_index] + 1
        end
    end

    if context.cardarea == G.play and context.repetition and context.scoring_hand and context.other_card then
        if not has_engineer() then
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = message_disabled,
                colour = G.C.RED,
            })
            return
        end

        local other_card = context.other_card
        local index = 0
        for i, scoring_card in ipairs(context.scoring_hand) do
            if scoring_card == other_card then
                index = i
                break
            end
        end

        local repeats = card.ability.extra.repeat_distribution[index] or 0
        if index ~= 0 and repeats > 0 then
            return {
                message = message_repeat,
                repetitions = repeats,
                card = card
            }
        end
    end
end

joker.ref_replacement = function()

end

return joker