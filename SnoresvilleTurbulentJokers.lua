--- STEAMODDED HEADER
--- MOD_NAME: Snoresville's Turbulent Jokers
--- MOD_ID: SnoresvilleTurbulentJokers
--- PREFIX: snoresville
--- MOD_AUTHOR: [Snoresville]
--- MOD_DESCRIPTION: they are very good jokers
--- BADGE_COLOUR: FFA500
--- DISPLAY_NAME: Turbulent Jokers
--- VERSION: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------
local MOD_ID = "SnoresvilleTurbulentJokers"
local MOD_INIT_MESSAGE = "it comes"

sendDebugMessage(MOD_INIT_MESSAGE)
init_localization()

G.SnoresvilleTurbulentJokers_getConfig = function()
    return NFS.load(SMODS.Mods[MOD_ID].path.."src/config.lua")()
end

NFS.load(SMODS.Mods[MOD_ID].path.."src/main.lua")()(MOD_ID)
----------------------------------------------
------------MOD CODE END----------------------