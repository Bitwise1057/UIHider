local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

function UIHider:CreateOptions()
    local options = {
        name = "UIHider",
        type = "group",
        args = {
            header = {
                type = "header",
                name = "UIHider Configuration",
                order = 0,
            },
            description = {
                type = "description",
                name = "Toggle individual UI frames to hide/show with the button or slash command.",
                fontSize = "medium",
                order = 1,
            },
            spacer = {
                type = "description",
                name = " ",
                order = 2,
            },

            -- HUD Elements top-level category
            hud = {
                type = "group",
                name = "HUD Elements",
                order = 3,
                inline = false,
                args = {
                    main = {
                        type = "group",
                        name = "Core HUD",
                        order = 1,
                        inline = true,
                        args = {},
                    },
                },
            },

            -- Bags top-level category
            bags = {
                type = "group",
                name = "Bags",
                order = 4,
                inline = false,
                args = {
                    bagToggles = {
                        type = "group",
                        name = "Bag Elements",
                        order = 1,
                        inline = true,
                        args = {},
                    },
                },
            },

            -- Action Bars top-level category
            actionbars = {
                type = "group",
                name = "Action Bars",
                order = 5,
                inline = false,
                args = {
                    left = {
                        type = "group",
                        name = "Action Bars 1-4",
                        inline = true,
                        order = 1,
                        width = "half",
                        args = {},
                    },
                    right = {
                        type = "group",
                        name = "Action Bars 5-8",
                        inline = true,
                        order = 2,
                        width = "half",
                        args = {},
                    },
                },
            },

            spacer3 = {
                type = "description",
                name = " ",
                order = 6,
            },

            toggleControls = {
                type = "group",
                name = "",
                inline = true,
                order = 7,
                args = {
                    toggle = {
                        type = "execute",
                        name = "Toggle UI Now",
                        desc = "Hide or show selected UI elements immediately.",
                        order = 1,
                        width = "normal",
                        func = function() self:ToggleUI() end,
                    },
                    toggleAll = {
                        type = "execute",
                        name = "Toggle All Options",
                        desc = "Enable or disable all checkboxes at once.",
                        order = 2,
                        width = "normal",
                        func = function()
                            local enableAll = false
                            for _, enabled in pairs(self.sessionConfig) do
                                if not enabled then
                                    enableAll = true
                                    break
                                end
                            end
                            for key in pairs(self.sessionConfig) do
                                self.sessionConfig[key] = enableAll
                            end
                            LibStub("AceConfigRegistry-3.0"):NotifyChange("UIHider")
                        end,
                    },
                },
            },
        },
    }

    -- Frame groups
    local hudFrames = {
        "Minimap", "ObjectivesTracker", "StatusTrackingBarManager", "MicroMenuContainer", "BuffFrame",
    }

    local bagFrames = {
        "Bags", "BagBarExpandToggle", "ReagentBag", "BagSlot0", "BagSlot1", "BagSlot2", "BagSlot3",
    }

    local actionBarFramesLeft = { "ActionBar1", "ActionBar2", "ActionBar3", "ActionBar4" }
    local actionBarFramesRight = { "ActionBar5", "ActionBar6", "ActionBar7", "ActionBar8" }

    local frameDisplayNames = {
        Minimap = "Minimap",
        ObjectivesTracker = "Quest Tracker",
        StatusTrackingBarManager = "XP / Rep Bar",
        MicroMenuContainer = "Micro Menu",
        BuffFrame = "Player Buffs Bar",

        Bags = "Bags",
        BagBarExpandToggle = "Bag Bar Expand Toggle",
        ReagentBag = "Reagent Bag",
        BagSlot0 = "Bag Slot 1",
        BagSlot1 = "Bag Slot 2",
        BagSlot2 = "Bag Slot 3",
        BagSlot3 = "Bag Slot 4",

        ActionBar1 = "Action Bar #1",
        ActionBar2 = "Action Bar #2",
        ActionBar3 = "Action Bar #3",
        ActionBar4 = "Action Bar #4",
        ActionBar5 = "Action Bar #5",
        ActionBar6 = "Action Bar #6",
        ActionBar7 = "Action Bar #7",
        ActionBar8 = "Action Bar #8",
    }

    -- HUD Toggles
    for i, frameName in ipairs(hudFrames) do
        if self.availableFrames[frameName] then
            options.args.hud.args.main.args[frameName] = {
                type = "toggle",
                name = frameDisplayNames[frameName],
                desc = "Hide/Show " .. frameDisplayNames[frameName],
                width = "full",
                order = i,
                get = function() return self.sessionConfig[frameName] end,
                set = function(_, val) self.sessionConfig[frameName] = val end,
            }
        end
    end

    -- Bag Toggles
    for i, frameName in ipairs(bagFrames) do
        if self.availableFrames[frameName] then
            options.args.bags.args.bagToggles.args[frameName] = {
                type = "toggle",
                name = frameDisplayNames[frameName],
                desc = "Hide/Show " .. frameDisplayNames[frameName],
                width = "quarter",
                order = i,
                get = function() return self.sessionConfig[frameName] end,
                set = function(_, val) self.sessionConfig[frameName] = val end,
            }
        end
    end

    -- Action Bar Toggles
    for i, frameName in ipairs(actionBarFramesLeft) do
        if self.availableFrames[frameName] then
            options.args.actionbars.args.left.args[frameName] = {
                type = "toggle",
                name = frameDisplayNames[frameName],
                desc = "Hide/Show " .. frameDisplayNames[frameName],
                width = "full",
                order = i,
                get = function() return self.sessionConfig[frameName] end,
                set = function(_, val) self.sessionConfig[frameName] = val end,
            }
        end
    end

    for i, frameName in ipairs(actionBarFramesRight) do
        if self.availableFrames[frameName] then
            options.args.actionbars.args.right.args[frameName] = {
                type = "toggle",
                name = frameDisplayNames[frameName],
                desc = "Hide/Show " .. frameDisplayNames[frameName],
                width = "full",
                order = i,
                get = function() return self.sessionConfig[frameName] end,
                set = function(_, val) self.sessionConfig[frameName] = val end,
            }
        end
    end

    AceConfig:RegisterOptionsTable("UIHider", options)
    AceConfigDialog:AddToBlizOptions("UIHider", "UIHider")
end
