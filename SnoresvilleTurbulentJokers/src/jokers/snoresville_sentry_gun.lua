local joker_internal_name = "snoresville_sentry_gun"
local joker_display_name = "Sentry Gun"
local engineer_internal_name = "snoresville_engineer"

local message_repeat = "Fire!"
local message_disabled = "Disabled..."

local joker = {
    name = joker_internal_name,
    slug = joker_internal_name,
    config = {
        extra = {
            upgrades = 1,
            repeat_distribution = {}
        },
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    loc_txt = {
        name = joker_display_name,
    },
    rarity = 2,
    cost = 0,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
    yes_pool_flag = joker_internal_name, -- Restricted with this flag disabled
}

joker.loc_txt.text = {
    "Retrigger a scoring card",
    "for each upgrade this Joker has",
    "{X:green,C:white}#2#{}{X:mult,C:white}#3#{}",
    "{C:inactive}(Currently has {C:attention}#1#{C:inactive} upgrades)",
}

local has_engineer = function()
    if not G.jokers or not G.jokers.cards then return false end
    for _, joker in ipairs(G.jokers.cards) do
        if joker.ability.name == engineer_internal_name then
            return true
        end
    end
end

joker.functions.loc_def = function(self)
    local engineer_exists = has_engineer()
    return {
        self.ability.extra.upgrades,
        engineer_exists and "Active!" or "",
        not engineer_exists and "Inactive! Engineer must be owned!" or "",
    }
end

joker.functions.calculate = function(self, context)
    if context.before and context.scoring_hand then
        self.ability.extra.repeat_distribution = {}
        local scoring_hand_count = #context.scoring_hand

        for i = 1, scoring_hand_count do
            self.ability.extra.repeat_distribution[i] = 0
        end
        for i = 1, self.ability.extra.upgrades do
            local distributed_index = math.random(scoring_hand_count)
            self.ability.extra.repeat_distribution[distributed_index] = self.ability.extra.repeat_distribution[distributed_index] + 1
        end
    end

    if context.cardarea == G.play and context.repetition and context.scoring_hand and context.other_card then
        if not has_engineer() then
            card_eval_status_text(self, 'extra', nil, nil, nil, {
                message = message_disabled,
                colour = G.C.RED,
            })
            return
        end

        local card = context.other_card
        local index = 0
        for i, scoring_card in ipairs(context.scoring_hand) do
            if scoring_card == card then
                index = i
            end
        end

        local repeats = self.ability.extra.repeat_distribution[index] or 0
        if index ~= 0 and repeats > 0 then
            return {
                message = message_repeat,
                repetitions = repeats,
                card = self
            }
        end
    end
end

joker.ref_replacement = function()

end

return joker