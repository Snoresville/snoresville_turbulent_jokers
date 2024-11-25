local MOD_ID = "SnoresvilleTurbulentJokers"
local MOD_INIT_MESSAGE = "it comes"

sendDebugMessage(MOD_INIT_MESSAGE)
init_localization()

G.SnoresvilleTurbulentJokers_getConfig = function()
    return NFS.load(SMODS.Mods[MOD_ID].path.."src/config.lua")()
end

NFS.load(SMODS.Mods[MOD_ID].path.."src/main.lua")()(MOD_ID)