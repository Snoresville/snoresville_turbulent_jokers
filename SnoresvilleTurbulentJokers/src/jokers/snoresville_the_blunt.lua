local joker_name = "snoresville_the_blunt"
local starting_chips = 10
local starting_mult = 1

local joker = {
    name = joker_name,
    slug = joker_name,
    config = {
        extra = {
            chips = starting_chips,
            mult = starting_mult,
            smoked = {},
        }
    },
    spritePos = {x = 0, y = 0},
    loc_txt = {
        name = "The Blunt",
        text = {
            "Unscored cards are fed into {C:green}The Blunt{}.",
            "Adds {C:blue}Chips{} and {C:red}Mult{} everytime",
            "a card is scored in {C:attention}High Card{} hands.",
            "{C:inactive}(Currently {C:blue}+#1# Chips{C:inactive} and {C:red}+#2# Mult{C:inactive})"
        }
    },
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {
        loc_def = function(self)
            return {self.ability.extra.chips, self.ability.extra.mult}
        end,
        calculate = function(self, context)
            if context.scoring_name == "High Card" and context.cardarea == G.play and context.individual then
                return {
                    chips = self.ability.extra.chips,
                    mult = self.ability.extra.mult,
                    card = self
                }
            end
            if context.cardarea == G.jokers and context.joker_main then
                for i = 1, #context.full_hand do
                    local card = context.full_hand[i]
                    local destroyed = true

                    for j = 1, #context.scoring_hand do
                        if context.scoring_hand[j] == card then
                            destroyed = false
                            break
                        end
                    end

                    if destroyed then
                        local bonus_chips = card.base.nominal + card.ability.bonus + (card.ability.perma_bonus or 0) + (card.edition and card.edition.chips or 0)
                        local bonus_mult = (card.ability.mult or 0) + (card.edition and card.edition.mult or 0)
                        self.ability.extra.chips = self.ability.extra.chips + bonus_chips
                        self.ability.extra.mult = self.ability.extra.mult + bonus_mult
                        table.insert(self.ability.extra.smoked, card)

                        if not card.getting_sliced then
                            G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.5, func = function()
                                if card and not card.shattered and not card.destroyed then
                                    card.destroyed = true
                                    card:start_dissolve()
                                    card_eval_status_text(self, 'extra', nil, nil, nil, {
                                        message = "Smoked",
                                        colour = G.C.RED,
                                        instant = true
                                    })
                                end
                                return true
                            end}))
                        end
                        card.getting_sliced = true

                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                            if bonus_chips > 0 then
                                card_eval_status_text(self, 'chips', bonus_chips, nil, nil, {
                                    instant = true
                                })
                            end
                            return true
                        end}))
                        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 1, func = function()
                            if bonus_mult > 0 then
                                card_eval_status_text(self, 'mult', bonus_mult, nil, nil, {
                                    instant = true
                                })
                            end
                            return true
                        end}))
                    end
                end
            elseif context.end_of_round then
                -- This is how cards are permanently removed from the deck with the blunt
                -- The destroy methods above are not enough
                if not context.blueprint and not context.repetition then
                    for i = 1, #self.ability.extra.smoked do
                        self.ability.extra.smoked[i]:start_dissolve(nil, true, 0, true)
                    end
                    self.ability.extra.smoked = {}
                end
            end
        end
    }
}

return joker