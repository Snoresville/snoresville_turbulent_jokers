local main = function(MOD_ID)
    local config = require(SMODS.findModByID(MOD_ID).path.."src/config")
    local mod_path = SMODS.findModByID(MOD_ID).path

    local function assert_asset_exists(asset_name)
        return love.filesystem.exists(mod_path.."assets/2x/"..asset_name..".png")
        and love.filesystem.exists(mod_path.."assets/1x/"..asset_name..".png")
    end

    local function init_modded_jokers()
        local jokers = require(mod_path.."src/joker_index")
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
            v.mod = MOD_ID
            v:register()

            -- https://github.com/Steamopollys/Steamodded/wiki/Creating-new-game-objects#creating-jokers
            if assert_asset_exists(v.slug)
            and assert_asset_exists(v.slug) then
                SMODS.Sprite:new(v.slug, mod_path, v.slug..".png", 71, 95, "asset_atli")
                :register()
            elseif config.fallback_sprite_name
            and assert_asset_exists(config.fallback_sprite_name)
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

    init_modded_jokers()
end

return main