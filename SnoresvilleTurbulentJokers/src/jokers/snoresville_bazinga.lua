local joker_internal_name = "snoresville_bazinga"
local joker_display_name = "Bazinga"

local bazinga_message = "BAZINGA!"
local increase_message = "Knock..."

local starting_value = 1
local destroy_chance = 16
local value_increase = 1

local joker = {
    name = joker_internal_name,
    slug = joker_internal_name,
    config = {
        extra = {
            bonus_x_mult = starting_value,
            chance = starting_value,
        },
    },
    spritePos = {x = 0, y = 0},
    soulPos = nil, -- {x = 1, y = 0}
    loc_txt = {
        name = joker_display_name,
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt.text = {
    "{X:mult,C:white}X#1#{} Mult, {C:green}#2# in #3#{} chance to",
    "destroy all Jokers after playing a {C:blue}hand{}",
    "Increase by {X:mult,C:white}X#4#{} and {C:green}#5# in #3#{} chance",
    "after each {C:blue}hand{}",
}

function get_bazinga_chance(card)
    return card.ability.extra.chance * G.GAME.probabilities.normal
end

joker.functions.loc_def = function(self)
    return {
        self.ability.extra.bonus_x_mult,
        get_bazinga_chance(self),
        destroy_chance,
        value_increase,
        value_increase * G.GAME.probabilities.normal
    }
end

joker.functions.calculate = function(self, context)
    if SMODS.end_calculate_context(context) and context.full_hand then
        local x_mult = self.ability.extra.bonus_x_mult
        return {
            message = localize{type='variable',key='a_xmult',vars={x_mult}},
            Xmult_mod = x_mult
        }
    elseif context.after and not context.blueprint then
        local bazinga = pseudorandom('j_'..joker_internal_name) < get_bazinga_chance(self) / destroy_chance
        if bazinga then
            for _, joker in ipairs(G.jokers.cards) do
                if not joker.ability.eternal
                and not joker.getting_sliced then
                    joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            joker:shatter()
                        return true
                    end }))
                end
            end
            G.E_MANAGER:add_event(Event({
                delay = 1,
                func = function()
                    play_sound('timpani')
                    attention_text({
                        scale = 1.4, text = bazinga_message, hold = 5, align = 'cm', offset = {x = 0,y = -2.7}, major = G.play
                    })
                return true
            end }))
        else
            self.ability.extra.bonus_x_mult = self.ability.extra.bonus_x_mult + value_increase
            self.ability.extra.chance = self.ability.extra.chance + value_increase
            for i=1,3 do
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil, {
                            message = increase_message,
                            instant = true,
                        })
                    return true
                end }))
            end
        end
    end
end

joker.ref_replacement = function()

end

return joker