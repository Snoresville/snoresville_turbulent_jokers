local internal_name = "seasonings"
local display_name = "Seasonings"

local chip_gain = 2
local mult_gain = 0.5
local mult_x_gain = 0.1
local hand_mult_x_gain = 0.05
local money_gain = 1

local upgrades_chip = "chips"
local upgrades_mult = "mult"
local upgrades_x_mult = "x_mult"
local upgrades_hand_x_mult = "hand_x_mult"
local upgrades_money = "money"
local upgrades = {
    upgrades_chip,
    upgrades_mult,
    upgrades_x_mult,
    upgrades_hand_x_mult,
    upgrades_money,
}
local function choose_upgrade()
    local upgrade = pseudorandom_element(upgrades, pseudoseed(internal_name.."_upgrade"))
    return upgrade
end
local function add_seasoning(card, seasoning, value)
    if not card[internal_name] then card[internal_name] = {} end
    card[internal_name][seasoning] = (card[internal_name][seasoning] or 0) + value
end

local joker = {
    name = internal_name,
    config = {},
    spritePos = {x = 0, y = 0},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    functions = {},
}

joker.loc_txt = {
    name = display_name,
    text = {
        "When a card is scored,",
        "give a random card in hand either",
        "{C:blue}+#1# chips, {C:red}+#2# Mult,",
        "{X:mult,C:white}+X#3#{C:red} Mult, {X:mult,C:white}+X#4#{C:red} Hand Mult,",
        "or {C:money}+$#5# on score{}",
    }
}

joker.functions.loc_vars = function(self)
    return {
        vars = {
            chip_gain, mult_gain, mult_x_gain, hand_mult_x_gain, money_gain
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and #G.hand.cards > 0 then
        local card = pseudorandom_element(G.hand.cards, pseudoseed(internal_name))
        local upgrade_choice = choose_upgrade()
        local upgrade_value = 0

        if upgrade_choice == upgrades_chip then
            upgrade_value = chip_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "+"..chip_gain.." Chips",
                colour = G.C.CHIPS,
            })
        elseif upgrade_choice == upgrades_mult then
            upgrade_value = mult_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "+"..mult_gain.." Mult",
                mult_mod = mult_gain,
                colour = G.C.MULT,
            })
        elseif upgrade_choice == upgrades_x_mult then
            upgrade_value = mult_x_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "+X"..mult_x_gain.." Mult",
                Xmult_mod = mult_x_gain,
                colour = G.C.XMULT,
            })
        elseif upgrade_choice == upgrades_hand_x_mult then
            upgrade_value = hand_mult_x_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "+X"..hand_mult_x_gain.." Hand Mult",
                Xmult_mod = hand_mult_x_gain,
                colour = G.C.XMULT,
            })
        elseif upgrade_choice == upgrades_money then
            upgrade_value = money_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "+$"..money_gain,
                colour = G.C.MONEY,
            })
        end
        add_seasoning(card, upgrade_choice, upgrade_value)
    end
end

joker.ref_replacement = function()
    local chip_bonus_ref = Card.get_chip_bonus
    Card.get_chip_bonus = function(self)
        if self.debuff then return 0 end
        local bonus = chip_bonus_ref(self)
        return bonus + (self[internal_name] and self[internal_name][upgrades_chip] or 0)
    end

    local mult_bonus_ref = Card.get_chip_mult
    Card.get_chip_mult = function(self)
        if self.debuff then return 0 end
        local bonus = mult_bonus_ref(self)
        return bonus + (self[internal_name] and self[internal_name][upgrades_mult] or 0)
    end

    local x_mult_bonus_ref = Card.get_chip_x_mult
    Card.get_chip_x_mult = function(self)
        if self.debuff then return 0 end
        local bonus = x_mult_bonus_ref(self)
        local seasoning_bonus = self[internal_name] and self[internal_name][upgrades_x_mult] or 0

        if seasoning_bonus > 0 and bonus == 0 then
            bonus = 1
        end
        return bonus + seasoning_bonus
    end

    local h_x_mult_bonus_ref = Card.get_chip_h_x_mult
    Card.get_chip_h_x_mult = function(self)
        if self.debuff then return 0 end
        local bonus = h_x_mult_bonus_ref(self)
        local seasoning_bonus = self[internal_name] and self[internal_name][upgrades_hand_x_mult] or 0

        if seasoning_bonus > 0 and bonus == 0 then
            bonus = 1
        end
        return bonus + seasoning_bonus
    end

    local p_dollars_ref = Card.get_p_dollars
    Card.get_p_dollars = function(self)
        if self.debuff then return 0 end
        local bonus = p_dollars_ref(self)
        return bonus + (self[internal_name] and self[internal_name][upgrades_money] or 0)
    end

    -- Load and save those seasoning buffs!!!
    local card_save_ref = Card.save
    Card.save = function(self)
        cardTable = card_save_ref(self)
        cardTable[internal_name] = self[internal_name]
        return cardTable
    end

    local card_load_ref = Card.load
    Card.load = function(self, cardTable, other_card)
        card_load_ref(self, cardTable, other_card)
        self[internal_name] = cardTable[internal_name]
    end
end

return joker