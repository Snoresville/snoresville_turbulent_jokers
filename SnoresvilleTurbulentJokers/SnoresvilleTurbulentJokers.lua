--- STEAMODDED HEADER
--- MOD_NAME: Snoresville's Turbulent Jokers
--- MOD_ID: SnoresvilleTurbulentJokers
--- MOD_AUTHOR: [Snoresville]
--- MOD_DESCRIPTION: they are very good jokers
--- BADGE_COLOUR: FFA500
--- DISPLAY_NAME: Turbulent Jokers

----------------------------------------------
------------MOD CODE -------------------------
local MOD_ID = "SnoresvilleTurbulentJokers"
local MOD_INIT_MESSAGE = "it comes"

SMODS.INIT[MOD_ID] = function ()
    sendDebugMessage(MOD_INIT_MESSAGE)
    init_localization()

    local main = require(SMODS.findModByID(MOD_ID).path.."src/main")
    main(MOD_ID)
end