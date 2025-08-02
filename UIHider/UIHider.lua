-- UIHider.lua

UIHider = {}
UIHider.hidden = false
UIHider.sessionConfig = {}

-- Frames available to hide
UIHider.availableFrames = {
    Minimap = Minimap,
    -- MainMenuBar = MainMenuBar,
    MicroMenuContainer = MicroMenuContainer,
    StatusTrackingBarManager = StatusTrackingBarManager,
    Bags = MainMenuBarBackpackButton,  -- Or correct frame name for bags
    BagSlot0 = CharacterBag0Slot,
    BagSlot1 = CharacterBag1Slot,
    BagSlot2 = CharacterBag2Slot,
    BagSlot3 = CharacterBag3Slot,
    ReagentBag = CharacterReagentBag0Slot,
    BuffFrame = BuffFrame,
    BagBarExpandToggle = BagBarExpandToggle,

 -- Action Bars
    ActionBar1 = MainMenuBar, -- placeholder for visibility
    ActionBar2 = MultiBarBottomLeft,
    ActionBar3 = MultiBarBottomRight,
    ActionBar4 = MultiBarRight,
    ActionBar5 = MultiBarLeft,
    ActionBar6 = MultiBar5,
    ActionBar7 = MultiBar6,
    ActionBar8 = MultiBar7,

    -- Objectives Tracker
    ObjectivesTracker = ObjectiveTrackerFrame,
}

-- Set default session values
local function InitDefaults()
    for frameName in pairs(UIHider.availableFrames) do
        if UIHider.sessionConfig[frameName] == nil then
            UIHider.sessionConfig[frameName] = true
        end
    end
end

-- Toggle function
function UIHider:ToggleUI()
    for frameName, frame in pairs(self.availableFrames) do
        if frame and self.sessionConfig[frameName] then
            if self.hidden then
                frame:Show()
            else
                frame:Hide()
            end
        end
    end
    self.hidden = not self.hidden
    print("UIHider: UI elements are now " .. (self.hidden 
        and "|cffff0000hidden.|r" 
        or "|cff00ff00visible.|r"))
end

-- Ace3 Options panel setup
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, event, addon)
    if addon == "UIHider" then
        InitDefaults()
        UIHider:CreateOptions() -- call to the options panel defined in UIHiderOptions.lua
    end
end)

-- Slash commands
SLASH_UIHIDER1 = "/uihider"
SlashCmdList["UIHIDER"] = function(msg)
    msg = msg:lower()
    if msg == "toggle" then
        UIHider:ToggleUI()
    else
        print("Usage: /uihider toggle")
    end
end