local config = {}
local mod_id = ""
local mod_path = ""

local function assert_asset_exists(asset_name)
    return love.filesystem.exists(mod_path.."assets/2x/"..asset_name..".png")
    and love.filesystem.exists(mod_path.."assets/1x/"..asset_name..".png")
end

local function init_modded_jokers(jokers)
    local joker_objects = {}

    for _, joker_def in pairs(jokers) do
        local joker_name = joker_def.name
        if config.blacklist_jokers[joker_name] ~= true then
            joker_objects[joker_name] = SMODS.Joker:new(
                joker_def.name,
                joker_def.slug,
                joker_def.config,
                joker_def.spritePos,
                joker_def.loc_txt,
                joker_def.rarity,
                joker_def.cost,
                joker_def.unlocked,
                joker_def.discovered,
                joker_def.blueprint_compat,
                joker_def.eternal_compat,
                nil,
                nil,
                joker_def.soulPos
            )
            joker_objects[joker_name].yes_pool_flag = joker_def.yes_pool_flag
            joker_objects[joker_name].no_pool_flag = joker_def.no_pool_flag
        end
    end

    -- Order the jokers by rarity
    local joker_sorted = {}

    for joker_name, joker_data in pairs(joker_objects) do
        local j = {}
        j.name = joker_data.name
        j.rarity = joker_data.rarity
        j.slug = joker_name
        table.insert(joker_sorted, j)
    end

    table.sort(joker_sorted, function(a, b)
        if a.rarity ~= b.rarity then
            return a.rarity < b.rarity
        end
        return a.name < b.name
    end)

    for _, joker_data in ipairs(joker_sorted) do
        local name = joker_data.slug
        local v = joker_objects[name]

        v.slug = "j_" .. name
        v.mod = mod_id
        v:register()

        -- https://github.com/Steamopollys/Steamodded/wiki/Creating-new-game-objects#creating-jokers
        if assert_asset_exists(v.slug) then
            SMODS.Sprite:new(v.slug, mod_path, v.slug..".png", 71, 95, "asset_atli")
            :register()
        elseif config.fallback_sprite_name
        and assert_asset_exists(config.fallback_sprite_name) then
            SMODS.Sprite:new(v.slug, mod_path, config.fallback_sprite_name..".png", 71, 95, "asset_atli")
            :register()
        end
    end

    for _, joker_def in pairs(jokers) do
        local joker_name = joker_def.name
        if joker_objects[joker_name] then
            local joker_slug = "j_"..joker_name
            if joker_def.functions then
                for function_name, function_call in pairs(joker_def.functions) do
                    SMODS.Jokers[joker_slug][function_name] = function_call
                end
            end
            if joker_def.ref_replacement then
                joker_def.ref_replacement()
            end
        end
    end
end

local function init_modded_decks(decks)
    local deck_setup_functions = {}

    for _, deck_def in pairs(decks) do
        local deck_name = deck_def.name
        local deck_jokers = deck_def.setup_functions.add_deck_jokers()
        local joker_blacklisted = false

        for _, joker_def in ipairs(deck_jokers) do
            if config.blacklist_jokers[string.sub(joker_def.name, 3)] then
                joker_blacklisted = true
                break
            end
        end

        if not joker_blacklisted and config.blacklist_decks[deck_name] ~= true then
            local sprite_slug = "b_"..deck_def.slug
            deck_def.config.atlas = sprite_slug

            if assert_asset_exists(sprite_slug) then
                SMODS.Sprite:new(sprite_slug, mod_path, sprite_slug..".png", 71, 95, "asset_atli")
                :register()
            elseif config.fallback_sprite_name
            and assert_asset_exists(config.fallback_sprite_name)then
                SMODS.Sprite:new(sprite_slug, mod_path, config.fallback_sprite_name..".png", 71, 95, "asset_atli")
                :register()
            end

            SMODS.Deck:new(
                deck_def.name,
                deck_def.slug,
                deck_def.config,
                {x = 0, y = 0}, -- Hardcoded
                deck_def.loc_txt
            )
            :register()
            deck_setup_functions[deck_name] = deck_def.setup_functions
        end
    end

    local Backapply_to_runRef = Back.apply_to_run
    Back.apply_to_run = function (args)
        Backapply_to_runRef(args)

        if deck_setup_functions[args.name] ~= nil then
            local funcs = deck_setup_functions[args.name]
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.playing_cards = funcs.modify_base_cards(G.playing_cards)

                    for _, deck_joker in ipairs(funcs.add_deck_jokers()) do
                        add_joker(deck_joker.name, deck_joker.edition, deck_joker.silent, deck_joker.eternal)
                    end

                    return true
                end
            }))
        end
    end
end

local main = function(MOD_ID)
    mod_id = MOD_ID
    mod_path = SMODS.findModByID(mod_id).path
    config = NFS.load(mod_path.."src/config.lua")()
    index = NFS.load(mod_path.."src/index.lua")()(MOD_ID)

    init_modded_jokers(index.jokers)
    init_modded_decks(index.decks)
end

return main