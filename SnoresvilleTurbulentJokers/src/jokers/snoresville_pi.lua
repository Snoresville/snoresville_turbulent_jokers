local internal_name = "pi"
local display_name = "Pi"

local pi = "3141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609433057270365759591953092186117381932611793105118548074462379962749567351885752724891227938183011949129833673362440656643086021394946395224737190702179860943702770539217176293176752384674818467669405132000568127145263560827785771342757789609173637178721468440901224953430146549585371050792279689258923542019956112129021960864034418159813629774771309960518707211349999998372978049951059731732816096318595024459455346908302642522308253344685035261931188171010003137838752886587533208381420617177669147303598253490428755468731159562863882353787593751957781857780532171226806613001927876611195909216420198938095257201065485863278865936153381827968230301952"
local mult_x_base = 1
local mult_x_gain = 0.1

local function get_pi_at_index(i)
    local digit = pi:sub(i % #pi + 1, i % #pi + 1)
    return (digit == "0" and "10")
    or (digit == "1" and "Ace")
    or digit
end

local joker = {
    name = internal_name,
    config = {
        extra = {
            pi_index = 0
        }
    },
    spritePos = {x = 0, y = 0},
    rarity = 2,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    functions = {}
}

joker.loc_txt = {
    name = display_name,
    text = {
        "This Joker gains {X:mult,C:white}X#1#{} Mult",
        "every time a scored card's rank",
        "matches the next rank of Pi",
        "Next ranks are: {C:attention}#3#, #4#, #5#, #6#, #7#{}",
        "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
    }
}

joker.functions.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            mult_x_gain, mult_x_base + mult_x_gain * card.ability.extra.pi_index,
            get_pi_at_index(card.ability.extra.pi_index + 0),
            get_pi_at_index(card.ability.extra.pi_index + 1),
            get_pi_at_index(card.ability.extra.pi_index + 2),
            get_pi_at_index(card.ability.extra.pi_index + 3),
            get_pi_at_index(card.ability.extra.pi_index + 4)
        }
    }
end

joker.functions.calculate = function(self, card, context)
    if context.cardarea == G.play and context.individual and not context.blueprint then
        local other_card = context.other_card
        if not card.debuff then
            local card_rank = (other_card.base.value == "10" and "0")
            or (other_card.base.value == "Ace" and "1")
            or other_card.base.value
            local next_number = pi:sub(card.ability.extra.pi_index % #pi + 1, card.ability.extra.pi_index % #pi + 1)

            if card_rank == next_number then
                card.ability.extra.pi_index = card.ability.extra.pi_index + 1
                return {
                    extra = {focus = card, message = localize('k_upgrade_ex'), colour = G.C.MULT},
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
    if SMODS.end_calculate_context(context) and context.full_hand then
        if card.ability.extra.pi_index > 0 then
            return {
                Xmult_mod = mult_x_base + mult_x_gain * card.ability.extra.pi_index,
                message = localize{
                    type = 'variable',
                    key = 'a_xmult',
                    vars = {
                        mult_x_base + mult_x_gain * card.ability.extra.pi_index
                    }
                }
            }
        end
    end
end

return joker