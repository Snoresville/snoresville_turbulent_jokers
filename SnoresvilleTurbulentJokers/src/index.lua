local MOD_PATH = ""
local function get_objects(objects_path)
    local path = MOD_PATH..objects_path
    local objects = {}
    local object_files = NFS.getDirectoryItems(path)

    for _, filename in pairs(object_files) do
        if not string.find(filename, "#template.lua") and string.find(filename, ".lua") then
            table.insert(objects, NFS.load(path.."/"..filename)())
        end
    end

    return objects
end

local index = function(MOD_ID)
    MOD_PATH = SMODS.Mods[MOD_ID].path

    return {
        jokers = get_objects("src/jokers"),
        decks = get_objects("src/decks")
    }
end

return index