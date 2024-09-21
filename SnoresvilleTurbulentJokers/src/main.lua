local config = G.SnoresvilleTurbulentJokers_getConfig()
local mod_path = ""

-- https://github.com/Steamopollys/Steamodded/wiki/Creating-new-game-objects#creating-jokers
local function assert_asset_exists(asset_name)
    local info1 = NFS.getInfo(mod_path.."assets/2x/"..asset_name..".png")
    local info2 = NFS.getInfo(mod_path.."assets/1x/"..asset_name..".png")

    return info1 and info2
end

local function try_create_atlas(slug, asset_name)
    local atlas
    if assert_asset_exists(asset_name) then
        atlas = SMODS.Atlas{
            key = slug,
            path = asset_name..".png",
            px = 71,
            py = 95,
        }
    elseif config.fallback_sprite_name
    and assert_asset_exists(config.fallback_sprite_name) then
        atlas = SMODS.Atlas{
            key = slug,
            path = config.fallback_sprite_name..".png",
            px = 71,
            py = 95,
        }
    end

    return atlas and true or false
end

local function init_modded_jokers(jokers)
    -- Order the jokers by rarity
    local joker_sorted = {}

    for _, def in pairs(jokers) do
        local joker_name = def.name
        if config.blacklist_jokers[joker_name] ~= true then
            table.insert(joker_sorted, def)
        end
    end

    table.sort(joker_sorted, function(a, b)
        if a.rarity ~= b.rarity then
            return a.rarity < b.rarity
        end
        return a.name < b.name
    end)

    for _, def in ipairs(joker_sorted) do
        local name = def.name
        local asset_name = "j_"..config.prefix.."_"..name
        local asset_exists = try_create_atlas(name, asset_name)

        local joker = SMODS.Joker{
            key = name,
            config = def.config,
            pos = def.spritePos,
            loc_txt = def.loc_txt,
            rarity = def.rarity,
            cost = def.cost,
            unlocked = def.unlocked,
            discovered = def.discovered,
            blueprint_compat = def.blueprint_compat,
            eternal_compat = def.eternal_compat,
            soul_pos = def.soulPos,
            atlas = asset_exists and name,
            yes_pool_flag = def.yes_pool_flag,
            no_pool_flag = def.no_pool_flag,
        }

        if def.functions then
            for function_name, function_call in pairs(def.functions) do
                joker[function_name] = function_call
            end
        end
        if def.ref_replacement then
            def.ref_replacement()
        end
    end
end

local function init_modded_decks(decks)
    for _, def in pairs(decks) do
        local deck_name = def.name
        local deck_jokers = def.setup_functions.add_deck_jokers()
        local joker_blacklisted = false

        for _, joker_def in ipairs(deck_jokers) do
            if config.blacklist_jokers[joker_def.name] then
                joker_blacklisted = true
                break
            end
        end

        if not joker_blacklisted and config.blacklist_decks[deck_name] ~= true then
            local name = def.name
            local asset_name = "b_"..config.prefix.."_"..name
            local asset_exists = try_create_atlas(name, asset_name)

            SMODS.Back{
                key = def.name,
                pos = {x = 0, y = 0}, -- Hardcoded
                config = def.config,
                loc_txt = def.loc_txt,
                atlas = asset_exists and name,
                apply = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local funcs = def.setup_functions

                            G.playing_cards = funcs.modify_base_cards(G.playing_cards)

                            for _, deck_joker in ipairs(funcs.add_deck_jokers()) do
                                local joker_search_name = "j_"..(deck_joker.modpack and config.prefix.."_" or "")..deck_joker.name
                                add_joker(joker_search_name, deck_joker.edition, deck_joker.silent, deck_joker.eternal)
                            end
                            return true
                        end
                    }))
                end
            }
        end
    end
end

local main = function(mod_id)
    mod_path = SMODS.Mods[mod_id].path
    config = NFS.load(mod_path.."src/config.lua")()
    local index = NFS.load(mod_path.."src/index.lua")()(mod_id)

    init_modded_jokers(index.jokers)
    init_modded_decks(index.decks)
end

return main