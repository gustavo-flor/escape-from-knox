require "OptionScreens/NewGameScreen"

local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

local super = NewGameScreen.create
function NewGameScreen:create()
    super(self)
    local y = 0
    for _,child in ipairs(self.mainPanel:getChildren()) do
        if child.y > y then
            y = child.y
        end
    end
    y = y + FONT_HGT_LARGE + 4

    local x = 16
    local xoffset = 20
    local mediumFontHgt = FONT_HGT_MEDIUM + 4
    
    local raider = ISLabel:new(x + xoffset, y, mediumFontHgt, getText("UI_NewGame_EFKExtractionMode"), 1, 1, 1, 1, UIFont.NewMedium, true)
    raider.internal = "EFKEXTRACTIONMODE"
    raider.mode = "EFKExtractionMode"
    raider.desc = getText("UI_NewGame_EFKExtractionMode_desc")
    raider.thumb = "media/ui/EFKExtractionMode/spiffoRaider.png"
    raider:initialise()
    self.mainPanel:addChild(raider)
    raider.onMouseDown = NewGameScreen.onMenuItemMouseDown
    raider:setOnMouseDoubleClick(self, NewGameScreen.dblClickPlaystyle)

    local raiderDesc = ISLabel:new(raider:getRight(), y, mediumFontHgt, " - " .. getText("UI_NewGame_EFKExtractionMode_desc"), 0.5, 0.5, 0.5, 1, UIFont.Small, true)
    raiderDesc:initialise()
    self.mainPanel:addChild(raiderDesc)
end 
