local internal_name = "engineer"
local display_name = "Engineer"
local sentry_internal_name = "sentry_gun"

local prefix = G.SnoresvilleTurbulentJokers_getConfig().prefix

local message_build_failure = "Cannot Build!"
local message_build_success = "Built!"
local message_upgrade = "Upgrade!"

local joker = {
    name = internal_name,
    config = {
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "At the beginning of a blind,",
        "build or upgrade a {C:attention}Sentry Gun{}",
        "The Sentry Gun {C:attention}inherits{} the Engineer's {C:dark_edition}edition{}",
        "{C:inactive}(Must have room to build){}"
    }
}

joker.functions.loc_vars = function(self)
    return {}
end

local find_sentry = function()
    if not G.jokers or not G.jokers.cards then return end
    for _, joker in ipairs(G.jokers.cards) do
        if joker.ability.name == 'j_'..prefix..'_'..sentry_internal_name then
            return joker
        end
    end
end

local sentry_maintenance = function(self)
    local sentry = find_sentry()
    if not sentry then
        if #G.jokers.cards >= G.jokers.config.card_limit and not (self.edition and self.edition.negative) then
            card_eval_status_text(self, 'extra', nil, nil, nil, {
                message = message_build_failure,
                colour = G.C.RED,
            })
            return
        end

        local sentry = add_joker('j_'..prefix..'_'..sentry_internal_name, self.edition and self.edition.type, nil, self.ability.eternal)
        self:juice_up()
        card_eval_status_text(sentry, 'extra', nil, nil, nil, {
            message = message_build_success,
            colour = G.C.GREEN,
        })
    else
        sentry.ability.extra.upgrades = sentry.ability.extra.upgrades + 1
        self:juice_up()
        card_eval_status_text(sentry, 'extra', nil, nil, nil, {
            message = message_upgrade
        })
    end
end

joker.functions.calculate = function(self, card, context)
    if context.setting_blind then
        G.E_MANAGER:add_event(
            Event({
                trigger = 'after',
                func = function()
                    sentry_maintenance(card)
                    return true
                end
            })
        )
    end
end

joker.ref_replacement = function()

end

return joker