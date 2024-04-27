-- used to template
local joker_name = "snoresville_true_gamer"
local display_name = "True Gamer"
local beaten_message = "Beaten!"
local base_chips = 25

local function current_chips(players_beaten)
    return base_chips * (2 ^ players_beaten)
end

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {
        extra = {
            players_beaten = 0
        }
    },
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = display_name,
        text = {
            "{C:blue}+#1# Chips{}",
            "At the start of a blind,",
            "fight another {C:attention}#2#{},",
            "and double the {C:blue}Chips{}",
            "{C:inactive}(Currently {C:blue}+#3# chips{C:inactive})",
        }
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        loc_def = function(self)
            return {base_chips, display_name, current_chips(self.ability.extra.players_beaten)}
        end,
        calculate = function(self, context)
            if context.setting_blind and not context.blueprint and not self.getting_sliced then
                local beating_card = nil
                for i = #G.jokers.cards, 1, -1 do
                    local card = G.jokers.cards[i]
                    if card ~= self
                    and not card.ability.eternal
                    and not card.getting_sliced
                    and card.ability.name == joker_name
                    and self.ability.extra.players_beaten >= card.ability.extra.players_beaten then
                        beating_card = card
                        break
                    end
                end

                if beating_card ~= nil then
                    beating_card.getting_sliced = true
                    self.ability.extra.players_beaten = self.ability.extra.players_beaten + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                        card_eval_status_text(beating_card, 'extra', nil, nil, nil, {
                            message = beaten_message,
                            colour = G.C.RED,
                            instant = true,
                        })
                        return true
                    end}))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                        beating_card:shatter()
                        return true
                    end}))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                        card_eval_status_text(self, 'extra', nil, nil, nil, {
                            message = localize{type = 'variable', key = 'a_chips', vars = {current_chips(self.ability.extra.players_beaten) - current_chips(self.ability.extra.players_beaten - 1)}},
                            colour = G.C.BLUE,
                            instant = true,
                        })
                        return true
                    end}))
                end
            end

            if SMODS.end_calculate_context(context) and context.full_hand and not self.getting_sliced then
                local bonus_chips = current_chips(self.ability.extra.players_beaten)
                return {
                    message = localize{type='variable',key='a_chips',vars={bonus_chips}},
                    chip_mod = bonus_chips
                }
            end
        end
    },
}

return joker