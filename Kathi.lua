local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- This is private version of V2 Panel. (By Carolin)

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

localPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "SignGUI" then
        for _, childchild in child:GetDescendants() do
            childchild:Destroy()
        end
    end
end)

local loopList = {}

for _, tool in workspace:GetDescendants() do
    if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
        CollectionService:AddTag(tool, "Collectible")
    end
end

local spawnLocationDependancy = ReplicatedStorage:FindFirstChild("spawnLocationDependancy") or Instance.new("StringValue")
spawnLocationDependancy.Parent = ReplicatedStorage
spawnLocationDependancy.Name = "spawnLocationDependancy"
spawnLocationDependancy.Value = "Village"

local spawnDependancy = ReplicatedStorage:FindFirstChild("spawnDependancy") or Instance.new("BoolValue")
spawnDependancy.Parent = ReplicatedStorage
spawnDependancy.Name = "spawnDependancy"
spawnDependancy.Value = false

local healdependantYZ = ReplicatedStorage:FindFirstChild("healdependantY") or Instance.new("BoolValue")
healdependantYZ.Parent = ReplicatedStorage
healdependantYZ.Name = "healdependantY"
healdependantYZ.Value = false

local loopdependaNCY = ReplicatedStorage:FindFirstChild("loopdependaNCY") or Instance.new("StringValue")
loopdependaNCY.Parent = ReplicatedStorage
loopdependaNCY.Name = "loopdependaNCY"
loopdependaNCY.Value = "Ignis"

local loopdependaNCYUSER = ReplicatedStorage:FindFirstChild("loopdependaNCYUSER") or Instance.new("StringValue")
loopdependaNCYUSER.Parent = ReplicatedStorage
loopdependaNCYUSER.Name = "loopdependaNCYUSER"
loopdependaNCYUSER.Value = ""

local loopToggle = ReplicatedStorage:FindFirstChild("loopToggle") or Instance.new("BoolValue")
loopToggle.Parent = ReplicatedStorage
loopToggle.Name = "loopToggle"
loopToggle.Value = false

local activeLoopFolder = ReplicatedStorage:FindFirstChild("LoopFolder") or Instance.new("Folder")
activeLoopFolder.Parent = ReplicatedStorage
activeLoopFolder.Name = "LoopFolder"

local autoItemCollectDependancy = ReplicatedStorage:FindFirstChild("autoItemCollectDependancy") or Instance.new("BoolValue")
autoItemCollectDependancy.Parent = ReplicatedStorage
autoItemCollectDependancy.Name = "autoItemCollectDependancy"
autoItemCollectDependancy.Value = false

local ignoreAppleDependancy = ReplicatedStorage:FindFirstChild("ignoreAppleDependancy") or Instance.new("BoolValue")
ignoreAppleDependancy.Parent = ReplicatedStorage
ignoreAppleDependancy.Name = "ignoreAppleDependancy"
ignoreAppleDependancy.Value = true

local autoClearInvDependancy = ReplicatedStorage:FindFirstChild("autoClearInvDependancy") or Instance.new("BoolValue")
autoClearInvDependancy.Parent = ReplicatedStorage
autoClearInvDependancy.Name = "autoClearInvDependancy"
autoClearInvDependancy.Value = false

local teleportationPrefix = ReplicatedStorage:FindFirstChild("teleportationPrefix") or Instance.new("StringValue")
teleportationPrefix.Parent = ReplicatedStorage
teleportationPrefix.Name = "teleportationPrefix"
teleportationPrefix.Value = ""

local teleportPart = ReplicatedStorage:FindFirstChild("teleportPart") or Instance.new("Part")
teleportPart.Parent = ReplicatedStorage
teleportPart.Name = "teleportPart"
teleportPart.Anchored = true

local pastelPinkTheme = {
    -- Text
    TextColor                    = Color3.fromRGB(255, 255, 255),  -- pure white

    -- Main panels & window
    Background                   = Color3.fromRGB(40, 15, 30),     -- deep but softened
    Topbar                       = Color3.fromRGB(100, 40, 70),    -- muted magenta
    Shadow                       = Color3.fromRGB(20, 5, 10),      -- very dark

    -- Tabs
    TabBackground                = Color3.fromRGB(80, 25, 50),    -- dark pastel pink
    TabStroke                    = Color3.fromRGB(140, 60, 100),  -- stronger border
    TabBackgroundSelected        = Color3.fromRGB(180, 100, 140), -- brighter pastel
    TabTextColor                 = Color3.fromRGB(255, 255, 255), -- white
    SelectedTabTextColor         = Color3.fromRGB(255, 200, 210), -- soft pink text

    -- Sections & elements
    ElementBackground            = Color3.fromRGB(60, 20, 45),    -- panel pink
    ElementBackgroundHover       = Color3.fromRGB(140, 70, 110),  -- hover highlight
    SecondaryElementBackground   = Color3.fromRGB(50, 15, 40),    -- secondary panels
    ElementStroke                = Color3.fromRGB(160, 80, 120),  -- element borders
    SecondaryElementStroke       = Color3.fromRGB(100, 50, 75),   -- secondary borders

    -- Sliders
    SliderBackground             = Color3.fromRGB(200, 120, 160), -- slider track
    SliderProgress               = Color3.fromRGB(255, 150, 190), -- progress fill
    SliderStroke                 = Color3.fromRGB(255, 180, 210), -- stroke

    -- Toggles
    ToggleBackground             = Color3.fromRGB(70, 25, 55),
    ToggleEnabled                = Color3.fromRGB(255, 120, 160), -- lighter toggle
    ToggleDisabled               = Color3.fromRGB(100, 40, 70),
    ToggleEnabledStroke          = Color3.fromRGB(255, 150, 190),
    ToggleDisabledStroke         = Color3.fromRGB(130, 60, 90),
    ToggleEnabledOuterStroke     = Color3.fromRGB(160, 80, 120),
    ToggleDisabledOuterStroke    = Color3.fromRGB(80, 30, 50),

    -- Dropdowns & inputs
    DropdownSelected             = Color3.fromRGB(120, 60, 100),
    DropdownUnselected           = Color3.fromRGB(60, 20, 45),
    InputBackground              = Color3.fromRGB(60, 20, 45),
    InputStroke                  = Color3.fromRGB(140, 70, 110),
    PlaceholderColor             = Color3.fromRGB(200, 200, 200), -- light gray for contrast

    -- Notifications
    NotificationBackground       = Color3.fromRGB(90, 35, 65),
    NotificationActionsBackground= Color3.fromRGB(255, 120, 160),
}


local function getPlayersFromName(fragment)
	fragment = fragment:lower()
    local matches = {}
    if fragment == "" then
      return nil
    end

    for _, player in ipairs(game.Players:GetPlayers()) do
        local name = player.Name:lower()
        if name:sub(1, #fragment) == fragment then
            table.insert(matches, player)
        end
    end

    return matches
end

local teleportLocations = {
    ["village"] = Vector3.new(-419.82928466796875, 21.22026824951172, -305.716552734375),
    ["circle"] = Vector3.new(187.88427734375, 51.109397888183594, -295.9070739746094),
    ["con"] = Vector3.new(-61.974891662597656, 37.22483825683594, -317.0556335449219),
    ["caves"] = Vector3.new(344.6943664550781, 44.49121856689453, 11.379171371459961),
    ["tower"] = Vector3.new(-500.42254638671875, 21.02484130859375, -221.71759033203125),
    ["bed"] = Vector3.new(-269.9762268066406, 6064.51318359375, -1439.7659912109375),
    ["fusion"] = Vector3.new(-70.91943359375, 40073.75390625, 32.82231140136719),
    ["lake"] = Vector3.new(-49.42745590209961, 37.12672424316406, -50.54151153564453),
    ["void"] = Vector3.new(-387.3877258300781, 24987.783203125, -701.6082763671875),
    ["banish"] = Vector3.new(136.04330444335938, 27993.23828125, -483.8507385253906),
    ["heaven"] = Vector3.new(-271.7498474121094, 5864.48046875, -1403.644775390625)
}

local function getLocationNameFromVector(vector)
    for name, vec in pairs(teleportLocations) do
        if vec == vector then
            return name
        end
    end
    return nil -- Not found
end




local teamColors = {
    ["Mortal"] = BrickColor.new("Fossil"),
    ["Pagan Witch"] = BrickColor.new("Bright bluish green"),
    ["Weak Witch /Warlock"] = BrickColor.new("Lapis"),
    ["Advanced Witch /Warlock"] = BrickColor.new("Royal purple"),
    ["Hex Witch"] = BrickColor.new("Persimmon"),
    ["Fairy"] = BrickColor.new("Sea green"),
    ["Angel"] = BrickColor.new("Cool yellow"),
    ["Fallen Angel"] = BrickColor.new("Black"),
    ["Royal Bloodline"] = BrickColor.new("Crimson"),
    ["Pagan God"] = BrickColor.new("Steel blue"),
    ["Egyptian Queen"] = BrickColor.new("Really red"),
    ["Archangel"] = BrickColor.new("Mid gray"),
    ["Hecate"] = BrickColor.new("Dark indigo")
}

local fireTypes = {
    ["Ignis"] = ReplicatedStorage.HellFire,
    ["Vines"] = ReplicatedStorage.VineTrap,
    ["Poison"] = ReplicatedStorage.PoisonFire,
    ["Freeze"] = ReplicatedStorage.FreezeFire,
    ["HellFire"] = ReplicatedStorage.HellFire2,
    ["Holy-Fire"] = ReplicatedStorage.HellFire3,
    ["Heal"] = ReplicatedStorage.HealFire2
}

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local jumpConnection -- to store the event connection

local function getHumanoid(target)
    local character = target.Character or target.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local MainWindow = Rayfield:CreateWindow({
   Name = "WitchCraft V2 - Carolin",
   Icon = "moon-star", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by Carolin",
   Theme = pastelPinkTheme, -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "n", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "WitchCraftV2", -- Create a custom folder for your hub/game
      FileName = "ZaWindowVladdy"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "You need a Key for this!",
      Subtitle = "Key System",
      Note = "All Keys are Secret and expected to stay that way.", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Kathi69"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Home = MainWindow:CreateTab("Home", "home")
local welcomeSection = Home:CreateSection("Welcome - ")
local Paragraph = Home:CreateParagraph({Title = "The Hub -", Content = "I made this for fun when I recognised that the game this was made for, frankly had almost no security. Anyway I have some warnings, some things may be buggy. And also Coin related exploits have higher anti-cheat. Don't give yourself too many coins at once and stay below 1 Million coins at all times! Alright, hope you enjoy. - Carolin"})

local playerModTab = MainWindow:CreateTab("Player", "users")

local customSpellTab = MainWindow:CreateTab("Spells", "sparkle")

local bindsTab = MainWindow:CreateTab("Binds", "key")

local miscTab = MainWindow:CreateTab("Misc", "bolt")


local playerModSection = playerModTab:CreateSection("Player Mods -")

local efindyDivider = Home:CreateDivider()

local prefixSectionHOWYOUDOING = Home:CreateSection("Prefix - ")

local teleportPrefix = Home:CreateInput({
   Name = "Teleportation Prefix - ",
   CurrentValue = "",
   Flag = "teleportPrefix",
   PlaceholderText = "Prefix Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        if Text ~= "" then
            teleportationPrefix.Value = Text
        end
   end,
})

-- Trim function
local function trim(str)
    return str:match("^%s*(.-)%s*$")
end

-- Chat connection
localPlayer.Chatted:Connect(function(message)
    local rawPrefix = teleportationPrefix.Value or ""
    if rawPrefix == "" then return end

    -- Normalize prefix: ensure it ends with a space
    if not rawPrefix:match(" $") then
        rawPrefix = rawPrefix .. " "
    end

    -- Compare message start with prefix (case-insensitive)
    if message:sub(1, #rawPrefix):lower() == rawPrefix:lower() then
        -- Slice off the prefix and trim the rest to get the location name
        local locationName = trim(message:sub(#rawPrefix + 1)):lower()
        local position = teleportLocations[locationName]

        if position then
            print("✅ Teleporting to:", locationName, "→", position)
            -- Actual teleport code here
        else
            warn("❌ Unknown location:", locationName)
        end
    end
end)

local teleportLocationsSection = Home:CreateSection("Teleports - ")

local teleportVillage = Home:CreateButton({
   Name = "Village Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["village"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Village!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportCircle = Home:CreateButton({
   Name = "Circle Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["circle"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Magic Circle!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportChurch = Home:CreateButton({
   Name = "Church Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["con"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Church of Night!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportCaves = Home:CreateButton({
   Name = "Caves Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["caves"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Caves!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local cavesSefindyDivider = Home:CreateDivider()

local teleportPotion = Home:CreateButton({
   Name = "Potion-Tower Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["tower"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Potion-Tower!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportFairy = Home:CreateButton({
   Name = "Fairy-Pond Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["lake"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Fairy-Pond!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportVoid = Home:CreateButton({
   Name = "The Void Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["void"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to The Void!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportFusion = Home:CreateButton({
   Name = "Fusion-(Horns) Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["fusion"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Fusion!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportBanish = Home:CreateButton({
   Name = "Banished-Realm Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["banish"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Banished-Realm!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local bedsSefindyDivider = Home:CreateDivider()

local teleportBed = Home:CreateButton({
   Name = "Royal-Bed Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["bed"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Royal Bed!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportCelestTower = Home:CreateButton({
   Name = "Celestial-Tower Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["heaven"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to Celestial Tower!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportDividerr = Home:CreateDivider()

local resetButton = playerModTab:CreateButton({
   Name = "Respawn Character - ",
   Callback = function()
      local currentTeam = localPlayer.Team.Name
      local collour = teamColors[currentTeam]
      local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

      a9oiw:FireServer(collour)
   end,
})

local infJump = playerModTab:CreateToggle({
   Name = "Infinite Jump - ",
   CurrentValue = false,
   Flag = "infJump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
		if Value == true then
			-- Enable infinite jumping
			jumpConnection = UserInputService.JumpRequest:Connect(function()
				local humanoid = getHumanoid(localPlayer)
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
		else
			-- Disable infinite jumping
			if jumpConnection then
				jumpConnection:Disconnect()
				jumpConnection = nil
			end
		end
	end,
})

local jumpPower = playerModTab:CreateInput({
   Name = "Jump Power - ",
   CurrentValue = "",
   PlaceholderText = "50 - Default",
   RemoveTextAfterFocusLost = false,
   Flag = "jumpPower",
   Callback = function(Text)

    local humanoid = getHumanoid(localPlayer)
   
   local num = tonumber(Text)

    if num then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = num
    elseif Text == "" then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = 50
    else
      Rayfield:Notify({
            Title = "Bad Input - ",
            Content = "Please Enter a Number!",
            Duration = 6.5,
            Image = "octagon-alert",
        })
    end
    
   end,
})

local walkSpeed = playerModTab:CreateInput({
   Name = "Walk Speed - ",
   CurrentValue = "",
   PlaceholderText = "16 - Default",
   RemoveTextAfterFocusLost = false,
   Flag = "walkSpeed",
   Callback = function(Text)

   local humanoid = getHumanoid(localPlayer)
   
   local num = tonumber(Text)

    if num then
        humanoid.WalkSpeed = num
    elseif Text == "" then
        humanoid.WalkSpeed = 16
    else
      Rayfield:Notify({
            Title = "Bad Input - ",
            Content = "Please Enter a Number!",
            Duration = 6.5,
            Image = "octagon-alert",
        })
    end
    
   end,
})

local teamSection = playerModTab:CreateSection("Teams -")

local rankDropdown = playerModTab:CreateDropdown({
   Name = "Rank Selector - ",
   Options = {"Mortal", "Pagan Witch", "Weak Witch /Warlock", "Advanced Witch /Warlock", "Hex Witch", "Fairy", "Angel", "Fallen Angel", "Royal Bloodline"},
   CurrentOption = "Mortal",
   MultipleOptions = false,
   Flag = "currentTeam", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
      local selectedOption = Options[1]
      local collour = teamColors[selectedOption]
      local ReplicatedStorage = game:GetService("ReplicatedStorage")

      if collour then
         -- Remote
         local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

         a9oiw:FireServer(collour)
      end
   end,
})

local royalButton = playerModTab:CreateButton({
   Name = "(Temp) Royal-Spam Button - ",
   Callback = function()
         local collour = BrickColor.new("Crimson")
         local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

         a9oiw:FireServer(collour)
      
   end,
})



-- SPELLS SECTION!!!!!
local loopsSpelldiv = customSpellTab:CreateSection("Spell Loops -")

local function contains(list, value)
    for _, v in ipairs(list) do
        if v == value then
            return true
        end
    end
    return false
end


local function removeByValue(list, value)
    for i, v in ipairs(list) do
        if v == value then
            table.remove(list, i)
            break  -- stop after first match
        end
    end
end

local loopSelector = customSpellTab:CreateDropdown({
   Name = "Loop Selector - ",
   Options = {"Ignis", "Poison", "Freeze", "Vines", "HellFire", "Holy-Fire", "Heal"},
   CurrentOption = "Ignis",
   MultipleOptions = false,
   Callback = function(Options)
        local selectedOption = Options[1]
        local fireType = fireTypes[selectedOption]

        if fireType then
            loopdependaNCY.Value = selectedOption

            Rayfield:Notify({
                Title = "Loop Selected - ",
                Content = 'You selected "' .. selectedOption .. '" for Looping!',
                Duration = 6.5,
                Image = "flame",
            })

        end
   end,
})

local loopPlayer = customSpellTab:CreateInput({
   Name = "Player to Loop - ",
   CurrentValue = "",
   PlaceholderText = "Victim-Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        local target = getPlayersFromName(Text)
        if Text ~= "all" then
            if target then

                for _, player in target do
                    local inList = contains(loopList, player.Name)

                    if inList == true then
                        removeByValue(loopList, player.Name)
                        if loopToggle.Value == true then
                            loopToggle.Value = false
                        elseif loopToggle.Value == false then
                            loopToggle.Value = true
                        end

                    elseif inList == false then
                        table.insert(loopList, player.Name)
                        if loopToggle.Value == true then
                            loopToggle.Value = false
                        elseif loopToggle.Value == false then
                            loopToggle.Value = true
                        end


                    end
                    
                end

                loopdependaNCYUSER.Value = Text
            elseif not target then
                loopdependaNCYUSER.Value = Text
                if loopToggle.Value == true then
                    loopToggle.Value = false
                elseif loopToggle.Value == false then
                    loopToggle.Value = true
                end
            end
        elseif Text == "all" then
            loopdependaNCYUSER.Value = "allPlayers"
        end
   end,
})

local function hasPartForPlayer(player)
    return activeLoopFolder:FindFirstChild(player.Name) ~= nil
end


loopToggle.Changed:Connect(function(toggle)
    local Value = loopdependaNCYUSER.Value
    local target = getPlayersFromName(Value)
    local fireType = fireTypes[loopdependaNCY.Value]
    if Value ~= "allPlayers" then
        if target and fireType then
            for _, player in target do

                print("joshyy")
                
                while player do
                    task.wait(1)
                    if Value == loopdependaNCYUSER.Value then
                        if fireType ~= "HellFire3" then
                            fireType:FireServer(
                                player.Character.HitPart
                            )
                        elseif fireType == "HellFire3" then
                            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            local shieldBolts = hrp:FindFirstChild("ShieldBolts")
                            if not (shieldBolts and shieldBolts:IsA("ParticleEmitter") and shieldBolts.Enabled) then
                                fireType:FireServer(
                                    player.Character.HitPart
                                )
                            end
                        end
                    end
                end
            end
        end
    end
end)

local massFlamesSection = customSpellTab:CreateSection("Mass Flames -")

local massIgnis = customSpellTab:CreateButton({
    Name = "Mass Ignis -",
    Callback = function()
        if localPlayer.Team.Name ~= "Mortal" and localPlayer.Team.Name ~= "Pagan Witch" and localPlayer.Team.Name ~= "Weak Witch / Warlock" then
            local lCount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player ~= localPlayer and player.Team.Name ~= "Angel" and player.Team.Name ~= "Fallen Angel" and player.Team.Name ~= "Archangel" and player.Team.Name ~= "Royal Bloodline" and player.Team.Name ~= "Hecate" then
                    lCount = lCount + 1
                local HellFire2 = ReplicatedStorage.HellFire -- RemoteEvent 
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end

                
                
            end
            if lCount > 0 then
                Rayfield:Notify({
                    Title = "Mass Ignis - ",
                    Content = "You set " .. lCount .. " people on Fire!",
                    Duration = 6.5,
                    Image = "flame",
                })
            end
        elseif localPlayer.Team.Name == "Mortal" or localPlayer.Team.Name == "Pagan Witch" or localPlayer.Team.Name == "Weak Witch / Warlock" then
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You are not the right Rank!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massHellFire = customSpellTab:CreateButton({
    Name = "Mass Hellfire (Fallen and Royals only!) -",
    Icon = "zap",
    Callback = function()
        if localPlayer.Team.Name == "Fallen Angel" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player ~= localPlayer and player.Team.Name ~= "Fallen Angel" and player.Team.Name ~= "Archangel" and player.Team.Name ~= "Royal Bloodline" and player.Team.Name ~= "Hecate" then
                    local HellFire2 = ReplicatedStorage.HellFire2 -- RemoteEvent 
                    lcount = lcount + 1
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end
            
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Hellfire - ",
                    Content = "You cast `HELLFIRE!` on " .. lcount .. " people!",
                    Duration = 6.5,
                    Image = "flame",
                })
            end
        elseif localPlayer.Team.Name == "Royal Bloodline" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player ~= localPlayer and player.Team.Name ~= "Archangel" and player.Team.Name ~= "Royal Bloodline" and player.Team.Name ~= "Hecate" then
                    local HellFire2 = ReplicatedStorage.HellFire2 -- RemoteEvent 
                    lcount = lcount + 1
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end
            
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Hellfire - ",
                    Content = "You cast `HELLFIRE!` on " .. lcount .. " people!",
                    Duration = 6.5,
                    Image = "flame",
                })
            end
        elseif localPlayer.Team.Name ~= "Royal Bloodline" and localPlayer.Team.Name ~= "Fallen Angel" then
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You are not the right Rank!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massHolyFire = customSpellTab:CreateButton({
    Name = "Mass Holy-Fire (Angel Only!) -",
    Callback = function()
        
        if localPlayer.Team.Name == "Angel" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                local character = player.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                local hitPart = character and character:FindFirstChild("HitPart")

                if hrp and hitPart then
                    local shieldBolts = hrp:FindFirstChild("ShieldBolts")

                    -- Exclude if ShieldBolts exists and is enabled
                    if not (shieldBolts and shieldBolts:IsA("ParticleEmitter") and shieldBolts.Enabled)  and player ~= localPlayer and player.Team.Name ~= "Archangel" and player.Team.Name ~= "Hecate" then
                        lcount = lcount + 1
                        local HellFire2 = ReplicatedStorage.HellFire3 -- RemoteEvent 
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                    end
                end
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Holy-Fire - ",
                    Content = "You purged " .. lcount .. " evils!",
                    Duration = 6.5,
                    Image = "flame",
                })
            end
        elseif localPlayer.Team.Name ~= "Angel" then
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You are not the right Rank!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massHolyHeal = customSpellTab:CreateButton({
    Name = "Mass Heal -",
    Callback = function()
        if localPlayer.Team.Name ~= "Mortal" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player.Character.Humanoid.Health < player.Character.Humanoid.MaxHealth then
                    lcount = lcount + 1
                local HellFire2 = ReplicatedStorage.HealFire2 -- RemoteEvent 
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end
                
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Heal - ",
                    Content = "You saved " .. lcount .. " saints!",
                    Duration = 6.5,
                    Image = "flame",
                })
            end
        elseif localPlayer.Team.Name == "Mortal" then
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You are not the right Rank!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})


local massSpellsSection = customSpellTab:CreateSection("Mass Spells -")

local massPoison = customSpellTab:CreateButton({
    Name = "Mass Poison -",
    Callback = function()
        if localPlayer.Team.Name ~= "Mortal" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player ~= localPlayer and player.Team.Name ~= "Angel" and player.Team.Name ~= "Fallen Angel" and player.Team.Name ~= "Archangel" and player.Team.Name ~= "Royal Bloodline" and player.Team.Name ~= "Hecate" then
                local HellFire2 = ReplicatedStorage.PoisonFire -- RemoteEvent 
                lcount = lcount + 1
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end
                
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Poison - ",
                    Content = lcount .. " people ate bad food!",
                    Duration = 6.5,
                    Image = "biohazard",
                })
            end
        elseif localPlayer.Team.Name == "Mortal" then
                Rayfield:Notify({
                    Title = "Mass Denied - ",
                    Content = "You are not the right Rank!",
                    Duration = 6.5,
                    Image = "octagon-alert",
                })
        end
    end,
})

local massFreeze = customSpellTab:CreateButton({
    Name = "Mass Freeze -",
    Callback = function()
        if localPlayer.Team.Name ~= "Mortal" and localPlayer.Team.Name ~= "Pagan Witch" and localPlayer.Team.Name ~= "Weak Witch / Warlock" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player ~= localPlayer then
                local HellFire2 = ReplicatedStorage.FreezeFire -- RemoteEvent 
                lcount = lcount + 1
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end
                
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Freeze - ",
                    Content = lcount .. " people froze to death..",
                    Duration = 6.5,
                    Image = "dessert",
                })
            end
        elseif localPlayer.Team.Name == "Mortal" or localPlayer.Team.Name == "Pagan Witch" or localPlayer.Team.Name == "Weak Witch / Warlock" then
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You are not the right Rank!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massVines = customSpellTab:CreateButton({
    Name = "Mass Vines -",
    Callback = function()
        if localPlayer.Team.Name ~= "Mortal" then
            local lcount = 0
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HitPart") and player ~= localPlayer then
                    lcount = lcount + 1
                local HellFire2 = ReplicatedStorage.VineTrap -- RemoteEvent 
                    HellFire2:FireServer(
                        player.Character.HitPart
                    )
                end
                
            end

            if lcount > 0 then
                Rayfield:Notify({
                    Title = "Mass Vines - ",
                    Content = "The bite of 87' killed " .. lcount .. " people..",
                    Duration = 6.5,
                    Image = "leaf",
                })
            end
        elseif localPlayer.Team.Name == "Mortal" then
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You are not the right Rank!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local targettDivider = customSpellTab:CreateDivider()

local targettedFlameSection = customSpellTab:CreateSection("Targetted Flames -")

local targtIgnis = customSpellTab:CreateInput({
   Name = "Targetted Ignis - ",
   CurrentValue = "",
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.HellFire -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target Ignis - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "flame",
        })

      end
   end,
})

local targtHellFire = customSpellTab:CreateInput({
   Name = "Targetted HellFire - ",
   CurrentValue = "",
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.HellFire2 -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target HellFire - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "flame",
        })

      end
   end,
})

local targtHolyFire = customSpellTab:CreateInput({
   Name = "Targetted Holy-Fire - ",
   CurrentValue = "",
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.HellFire3 -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target Holy-Fire - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "flame",
        })

      end
   end,
})

local targtHolyHeal = customSpellTab:CreateInput({
   Name = "Targetted Heal - ",
   CurrentValue = "",
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.HealFire2 -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target Heal - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "flame",
        })

      end
   end,
})

local targettedSpellSection = customSpellTab:CreateSection("Targetted Spells -")

local targtPoison = customSpellTab:CreateInput({
   Name = "Targetted Poison - ",
   CurrentValue = "",
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.PoisonFire -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target Poison - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "biohazard",
        })

      end
   end,
})

local targtVines = customSpellTab:CreateInput({
   Name = "Targetted Vines - ",
   CurrentValue = localPlayer.Name,
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.VineTrap -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target Vines - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "leaf",
        })

      end
   end,
})

local targtFreeze = customSpellTab:CreateInput({
   Name = "Targetted Freeze - ",
   CurrentValue = localPlayer.Name,
   PlaceholderText = "Username Here!",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local target = getPlayersFromName(Text)

      for _, player in ipairs(target) do
         -- Remote
         local HellFire = ReplicatedStorage.FreezeFire -- RemoteEvent 

         -- Variables
         local HitPart = player.Character.HitPart

         HellFire:FireServer(
            HitPart
         )

         Rayfield:Notify({
            Title = "Target Freeze - ",
            Content = player.Name,
            Duration = 6.5,
            Image = "leaf",
        })

      end
   end,
})


local bargetDivider = customSpellTab:CreateDivider()

local targettedifimalivethissaturdaynightwillyouhearmyremedySpellSection = playerModTab:CreateSection("Item Hacks -")

-- THIS IS IMPORTANT AREA I THINK LOL

local function isInTable(instance, table)
    for _, v in pairs(table) do
        if v == instance then
            return false
        end
    end
    return true
end

local function isOwnedbyPlayer(instance)
    for _, player in Players:GetPlayers() do
        if player.Name == instance.Parent.Name then
            return false
        end
    end
    return true
end

local autoItemCollect = playerModTab:CreateToggle({
   Name = "Auto Item Collect - ",
   CurrentValue = false,
   Callback = function(Value)
        if Value == true then
            autoItemCollectDependancy.Value = true

            Rayfield:Notify({
                Title = "Auto Item Collect - ",
                Content = "You greedy bastard!",
                Duration = 6.5,
                Image = "gem",
            })
        elseif Value == false then
            autoItemCollectDependancy.Value = false

            Rayfield:Notify({
                Title = "Auto Item Collect - ",
                Content = "It's turned off now ig..",
                Duration = 6.5,
                Image = "gem",
            })
        end
        
    end,
})

local autoItemCollectApples = playerModTab:CreateToggle({
   Name = "Auto Item Collect Apples - ",
   CurrentValue = false,
   Callback = function(Value)
        if Value == true then
            ignoreAppleDependancy.Value = false

            Rayfield:Notify({
                Title = "Auto Item Collect - ",
                Content = "Ew-? Freak.",
                Duration = 6.5,
                Image = "apple",
            })
        elseif Value == false then
            ignoreAppleDependancy.Value = true

            Rayfield:Notify({
                Title = "Auto Item Collect Apples - ",
                Content = "Damn right we turn that shit off-",
                Duration = 6.5,
                Image = "apple",
            })
        end
        
    end,
})

local autoClearItems = playerModTab:CreateToggle({
   Name = "Auto Clear Inventory - ",
   CurrentValue = false,
   Callback = function(Value)
        if Value == true then
            autoClearInvDependancy.Value = true

            Rayfield:Notify({
                Title = "Auto Clear Inventory - ",
                Content = "There are starving chilren in Africa-",
                Duration = 6.5,
                Image = "trash-2",
            })
        elseif Value == false then
            autoClearInvDependancy.Value = false

            Rayfield:Notify({
                Title = "Auto Item Collect Apples - ",
                Content = "Fatty.",
                Duration = 6.5,
                Image = "trash-2",
            })
        end
        
    end,
})

local invisPotion = playerModTab:CreateButton({
   Name = "Buy Invis-Potion - ",
   Callback = function()
        local BuyItem = ReplicatedStorage.Remotes.BuyItem -- RemoteEvent 

        BuyItem:FireServer(
            "Invisibility Potion"
        )

        Rayfield:Notify({
                Title = "Bought Invis Potion - ",
                Content = "You look so ugly you need that shi?",
                Duration = 6.5,
                Image = "drama",
            })


   end,
})

local fffendyDivider = playerModTab:CreateDivider()

local doneObjects = {}

workspace.DescendantAdded:Connect(function(object)
    if object:IsA("Tool") then
         CollectionService:AddTag(object, "Collectible")
    end
end)

RunService.Heartbeat:Connect(function()  
    task.wait(1)
    for _, object in CollectionService:GetTagged("Collectible") do
        local humanoidRootPart = localPlayer.Character.HumanoidRootPart
        local isTable = isInTable(object, doneObjects)
        local isOwned = isOwnedbyPlayer(object)
        local appDependant = ignoreAppleDependancy.Value
        local collectItem = autoItemCollectDependancy.Value
        if object:IsA("Tool") and isTable == true and isOwned == true and object.Name ~= "Dimensional Shards" and object.Name ~= "Blood" and object.Name ~= "Celestial Blood" and collectItem == true then
            if appDependant == false then
                object.Handle.CFrame = humanoidRootPart.CFrame
                table.insert(doneObjects, object)
            elseif appDependant == true then
                if object.Name ~= "Apple" then
                    object.Handle.CFrame = humanoidRootPart.CFrame
                    table.insert(doneObjects, object)
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()  
    task.wait(1)
    local pOI = {}
    for _, child in localPlayer.Backpack:GetChildren() do
        table.insert(pOI, child)
    end

    for _, child in localPlayer.Character:GetChildren() do
        table.insert(pOI, child)
    end

    for _, object in pOI do
        local collectItem = autoClearInvDependancy.Value
        if object:IsA("Tool") and collectItem == true then
            if object.Name == "Apple" or object.Name == "Golden Apple" or object.Name == "Earth Core" or object.Name == "Core Of Phoenix" or object.Name == "Sealing Amber" then
                object:Destroy()
            end
        end
    end
end)

local massFlameBinds = bindsTab:CreateSection("Mass Flames -")

local bindMassIgnis = bindsTab:CreateKeybind({
   Name = "Mass Ignis - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindIgnis", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass Ignis - ",
            Content = "You got them alright!",
            Duration = 6.5,
            Image = "flame",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HitPart") then
           local HellFire2 = ReplicatedStorage.HellFire -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
        end
        
    end
    end,
})

local bindMassHellFire = bindsTab:CreateKeybind({
   Name = "Mass HellFire - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindHellFire", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass HellFire - ",
            Content = "You got them alright!",
            Duration = 6.5,
            Image = "flame",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HitPart") then
           local HellFire2 = ReplicatedStorage.HellFire2 -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
        end
        
    end
    end,
})

local bindMassHolyFire = bindsTab:CreateKeybind({
   Name = "Mass Holy-Fire - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindHolyFire", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass Holy-Fire - ",
            Content = "You got them alright!",
            Duration = 6.5,
            Image = "flame",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        local hitPart = character and character:FindFirstChild("HitPart")

        if hrp and hitPart then
            local shieldBolts = hrp:FindFirstChild("ShieldBolts")

            -- Exclude if ShieldBolts exists and is enabled
            if not (shieldBolts and shieldBolts:IsA("ParticleEmitter") and shieldBolts.Enabled) then
                local HellFire2 = ReplicatedStorage.HellFire3 -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
            end
        end
    end
    end,
})

local bindHolyHeal = bindsTab:CreateKeybind({
   Name = "Mass Heal - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindHeal", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass Heal - ",
            Content = "You got them alright!",
            Duration = 6.5,
            Image = "flame",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HitPart") then
           local HellFire2 = ReplicatedStorage.HealFire2 -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
        end
        
    end
    end,
})

local massBinds = bindsTab:CreateSection("Mass Spells -")

local bindMassPoison = bindsTab:CreateKeybind({
   Name = "Mass Poison - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindPoison", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass Poison - ",
            Content = "Not Food!",
            Duration = 6.5,
            Image = "biohazard",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HitPart") then
           local HellFire2 = ReplicatedStorage.PoisonFire -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
        end
        
    end
    end,
})

local bindMassFreeze = bindsTab:CreateKeybind({
   Name = "Mass Freeze - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindFreeze", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass Freeze - ",
            Content = "Frozen or Chilly?",
            Duration = 6.5,
            Image = "desert",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HitPart") then
           local HellFire2 = ReplicatedStorage.FreezeFire -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
        end
        
    end
    end,
})

local bindMassVines = bindsTab:CreateKeybind({
   Name = "Mass Vines - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindVines", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Mass Vinees - ",
            Content = "Sticky or Stiff?",
            Duration = 6.5,
            Image = "leaf",
        })

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HitPart") then
           local HellFire2 = ReplicatedStorage.VineTrap -- RemoteEvent 
            HellFire2:FireServer(
                player.Character.HitPart
            )
        end
        
    end
    end,
})

local endyDivider = bindsTab:CreateDivider()

local bindMisc = bindsTab:CreateSection("Misc Binds - ")

local bindSelfHolyHeal = bindsTab:CreateKeybind({
   Name = "Self Heal - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindSelfHeal", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   Rayfield:Notify({
            Title = "Self Heal - ",
            Content = "How- Giving or Greedy-?",
            Duration = 6.5,
            Image = "flame",
        })

   
      -- Remote
      local HellFire = ReplicatedStorage.HealFire2 -- RemoteEvent 

      -- Variables
      local HitPart = localPlayer.Character.HitPart

      HellFire:FireServer(
         HitPart
      )
    end,
})



local fffendygfDivider = bindsTab:CreateDivider()

--gjgjgjjjjjjjjjjjjjjjjjjjjjjjjjj

local immunityMisc = miscTab:CreateButton({
   Name = "Immune Mortal - ",
   Callback = function()
         local collour = BrickColor.new("Mid gray")
         local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 
         a9oiw:FireServer(collour)
      
   end,
})

--gjjggjjgjgjgjgjgjgjgjjg

local fffendygfDgfdsivider = bindsTab:CreateDivider()

local spawnPointer = miscTab:CreateSection("SpawnPoint -")

local spawnDropdown = miscTab:CreateDropdown({
   Name = "SpawnPoint Selector - ",
   Options = {"Village", "Circle", "CON", "Caves", "Potion Tower", "Fairy Pond", "The Void", "Fusion", "Banished Realm", "Royal Bed", "Celestial Tower"},
   CurrentOption = "Village",
   MultipleOptions = false,
   Callback = function(Options)
      local convertor = {
        ["Village"] = "village",
        ["Circle"] = "circle",
        ["CON"] = "con",
        ["Caves"] = "caves",
        ["Potion Tower"] = "tower",
        ["Fairy Pond"] = "lake",
        ["The Void"] = "void",
        ["Fusion"] = "fusion",
        ["Banished Realm"] = "banish",
        ["Royal Bed"] = "bed",
        ["Celestial Tower"] = "heaven"
      }

      local selectedOption = Options[1]
      local convertedOption = convertor[selectedOption]
      local teleportDestination = teleportLocations[convertedOption]

      if teleportDestination then
         spawnLocationDependancy.Value = selectedOption
         Rayfield:Notify({
            Title = "Location Set - ",
            Content = "Your Spawn Location is " .. selectedOption .. "!",
            Duration = 6.5,
            Image = "sparkles",
        })
      end
   end,
})

local spawnToggler = miscTab:CreateToggle({
   Name = "Custom SpawnPoint - ",
   CurrentValue = false,
   Callback = function(Value)
		if Value == true then
			spawnDependancy.Value = true
         Rayfield:Notify({
            Title = "Custom Spawn (ON) - ",
            Content = "Custom SpawnPoint is ON!",
            Duration = 6.5,
            Image = "power",
        })
		else
			spawnDependancy.Value = false
          Rayfield:Notify({
            Title = "Custom Spawn (OFF) - ",
            Content = "Custom SpawnPoint is OFF!",
            Duration = 6.5,
            Image = "power",
        })
		end
	end,
})

localPlayer.CharacterAdded:Connect(function(character)
      if spawnDependancy.Value == true then
      print("bob")
    
      print("bobby")
        -- Wait for HumanoidRootPart to exist
        local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
        
        local spawnPlace = spawnLocationDependancy.Value
        local teleportDestination = teleportLocations[spawnPlace]
        
        Rayfield:Notify({
            Title = "Spawned - ",
            Content = "You've spawned in " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "star",
        })
        
        HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
    end
end)

local fffffffendydjf3fDivider = miscTab:CreateDivider()

local shopSection = miscTab:CreateSection("Shops n' Coins -")

local coinGiver = miscTab:CreateButton({
   Name = "4000 Coins - ",
   Callback = function()
    local currencyRemote = ReplicatedStorage.Remotes.GiveCurrency
    local GuiPlayer = localPlayer.PlayerGui.Coins
    local coinAmountRAW = GuiPlayer.Frame.Coins.Text
    -- Extract the number using pattern matching
    local numberString = string.match(coinAmountRAW, "%d+")

    -- Convert to a number
    local coinValue = tonumber(numberString)

    local num = 4000

    local prediction = num + coinValue

    if num and num < 5000 then
        
        if prediction > 1000000 then
            Rayfield:Notify({
                Title = "Max Coins - ",
                Content = "You've reached the Max amount of Coins!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        else
            currencyRemote:FireServer(num)
            Rayfield:Notify({
                Title = "Coins Given - ",
                Content = "You've been given " .. num ..  " coins!",
                Duration = 6.5,
                Image = "coins",
            })
        end
    elseif num > 5000 then
        Rayfield:Notify({
            Title = "Max Coins - ",
            Content = "Less than 5000 Coins at once!",
            Duration = 6.5,
            Image = "octagon-alert",
        })
    else
        Rayfield:Notify({
            Title = "Bad Input - ",
            Content = "Please Enter a Number!",
            Duration = 6.5,
            Image = "octagon-alert",
        })
    end
    
   end,
})

local sellShop = miscTab:CreateButton({
   Name = "Sell Shop - ",
   Callback = function()
    -- Remote
    local OpenShop3 = ReplicatedStorage.Remotes.OpenShop3 -- RemoteEvent 

    -- This data was received from the server
    firesignal(OpenShop3.OnClientEvent)

   end,
})

local buyShop = miscTab:CreateButton({
   Name = "Buy Shop - ",
   Callback = function()
    -- Remote
    local OpenShop = ReplicatedStorage.Remotes.OpenShop -- RemoteEvent 

    -- This data was received from the server
    firesignal(OpenShop.OnClientEvent)

   end,
})

local gypsy = miscTab:CreateButton({
   Name = "Gypsy Merchant - ",
   Callback = function()
    local TravelMerchant = ReplicatedStorage.Remotes.TravelMerchant -- RemoteEvent 

    -- This data was received from the server
    firesignal(TravelMerchant.OnClientEvent)


   end,
})

local fffffffejfndyDivider = miscTab:CreateDivider()

local ffjspawnPointer = miscTab:CreateSection("Badge Giver -")

local badgeurn = miscTab:CreateButton({
   Name = "Get all Badges - ",
   Callback = function()
   local remoteWing = ReplicatedStorage.SpiritFused
   remoteWing:FireServer()
   local shard = ReplicatedStorage.ShardBadge
   shard:FireServer()
   local nature = ReplicatedStorage.NatureScrollBadge
   nature:FireServer()
   local magic = ReplicatedStorage.MagicScrollBadge
   magic:FireServer()
   local angelic = ReplicatedStorage.AngelicScrollBadge
   angelic:FireServer()
   local MCandle = ReplicatedStorage.MCandleBadge
   MCandle:FireServer()
   local forgive = ReplicatedStorage.ForgiveBadge
   forgive:FireServer()
   local haveSigned = ReplicatedStorage.HaveSigned
   haveSigned:FireServer()
   end,
})

local spawnPfffoifffnter = miscTab:CreateSection("Moon Change -")

local moonChange = miscTab:CreateButton({
   Name = "Change the Moon! - ",
   Callback = function()
    local remoteWing = ReplicatedStorage.MoonChange
    remoteWing:FireServer()

    Rayfield:Notify({
                Title = "Moon Change - ",
                Content = localPlayer.Name .. " tonight we steal za moon!!",
                Duration = 6.5,
                Image = "moon",
            })
   end,
})

local spawnPfffointer = miscTab:CreateSection("Burning Wings -")

local angelWingBurn = miscTab:CreateButton({
   Name = "Burn your Wings (Angel) - ",
   Callback = function()
    local remoteWing = ReplicatedStorage.BurnAngelWing
    remoteWing:FireServer()

    Rayfield:Notify({
                Title = "Burning Wings - ",
                Content = "Burn baby burn!",
                Duration = 6.5,
                Image = "flame",
            })
   end,
})

local spawnPfdfffoifffnter = miscTab:CreateSection("Inf Self-Heal -")

local infSelfHeal = miscTab:CreateToggle({
   Name = "Infinite Self-Heal - ",
   CurrentValue = false,
   Callback = function(Value)
		if Value == true then

            Rayfield:Notify({
                Title = "Infinite Self-Heal - ",
                Content = "Damn you greedy biatch!",
                Duration = 6.5,
                Image = "flame",
            })

			healdependantYZ.Value = true

		else
			Rayfield:Notify({
                Title = "Infinite Self-Heal - ",
                Content = "It's turned off now Hoe..",
                Duration = 6.5,
                Image = "flame",
            })

            healdependantYZ.Value = false

		end
	end,
})
local humanoid = localPlayer.Character.Humanoid

healdependantYZ.Changed:Connect(function(value)
    if healdependantYZ.Value == true then
        while healdependantYZ.Value == true do
            print("josh")
            task.wait(1)
            -- Remote
            local HellFire = ReplicatedStorage.HealFire2 -- RemoteEvent 

            -- Variables
            local HitPart = localPlayer.Character.HitPart

            HellFire:FireServer(
                HitPart
            )
        end
    end
end)

local ffspawnPointer = miscTab:CreateSection("Magic Boost -")

local fusionPunchh = miscTab:CreateButton({
   Name = "Spirit Fusion - ",
   Callback = function()
   local remoteWing = ReplicatedStorage.SpiritFused
   remoteWing:FireServer()
   end,
})

local fffffffendyDivider = miscTab:CreateDivider()

local ffgggspawnPointer = miscTab:CreateSection("Dev Tools -")

local infiniteYield = miscTab:CreateButton({
   Name = "Infinite Yield - ",
   Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source'))()
   end,
})

local systemBroken = miscTab:CreateButton({
   Name = "Fly Script - ",
   Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script'))()
   end,
})

local dexExplore = miscTab:CreateButton({
   Name = "Dex Explorer (Moon) - ",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
   end,
})

local sigmaSpy = miscTab:CreateButton({
   Name = "Remote Spy - ",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua"))()
   end,
})

local fffffffendydjfffff3fDivider = miscTab:CreateDivider()

Rayfield:LoadConfiguration()
