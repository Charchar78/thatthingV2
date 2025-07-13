local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

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

local teleportLocations = {
    ["Village"] = Vector3.new(-419.82928466796875, 21.22026824951172, -305.716552734375),
    ["Magic Circle"] = Vector3.new(187.88427734375, 51.109397888183594, -295.9070739746094),
    ["C.O.N"] = Vector3.new(-61.974891662597656, 37.22483825683594, -317.0556335449219),
    ["Caves"] = Vector3.new(344.6943664550781, 44.49121856689453, 11.379171371459961),
    ["Potion Tower"] = Vector3.new(-500.42254638671875, 21.02484130859375, -221.71759033203125),
    ["Royal Bed"] = Vector3.new(-269.9762268066406, 6064.51318359375, -1439.7659912109375),
    ["Fusion"] = Vector3.new(-70.91943359375, 40073.75390625, 32.82231140136719),
    ["Fairy Pond"] = Vector3.new(-49.42745590209961, 37.12672424316406, -50.54151153564453),
    ["The Void"] = Vector3.new(-387.3877258300781, 24987.783203125, -701.6082763671875),
    ["Banished Realm"] = Vector3.new(136.04330444335938, 27993.23828125, -483.8507385253906),
    ["Celestial Tower"] = Vector3.new(-271.7498474121094, 5864.48046875, -1403.644775390625)
}

local function getLocationNameFromVector(vector)
    for name, vec in pairs(teleportLocations) do
        if vec == vector then
            return name
        end
    end
    return nil -- Not found
end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local jumpConnection -- to store the event connection

local function getHumanoid(target)
    local character = target.Character or target.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local Window = Rayfield:CreateWindow({
   Name = " ~Kathy's Occult~",
   Icon = "sparkles", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "~Kathy's Occult~",
   LoadingSubtitle = "Loading...",
   ShowText = "Occultism", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "N", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "KOccult"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "~Kathy's Occult~",
      Subtitle = "Key for Entry..",
      Note = "Mortals shouldn't mess with Gods.", -- Use this to tell the user how to get a key
      FileName = "OccultKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"BaddieHood76"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings
   }
})

local Home = Window:CreateTab("Home", "home") -- Title, Image

local playerModTab = Window:CreateTab("Home", "home") -- Title, Image

local welcomeParagraph = Home:CreateParagraph({Title = "Welcome -", Content = "Welcome Kathys<3. Hope you enjoy my script and do not abuse it ^3-*."})

local efindyDivider = Home:CreateDivider()

local teleportLocationsSection = Home:CreateSection("Teleports - ")

local teleportVillage = Home:CreateButton({
   Name = "Village Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Village"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportCircle = Home:CreateButton({
   Name = "Magic-Circle Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Magic Circle"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportChurch = Home:CreateButton({
   Name = "Church Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["C.O.N"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportCaves = Home:CreateButton({
   Name = "Caves Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Caves"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local cavesSefindyDivider = Home:CreateDivider()

local teleportPotion = Home:CreateButton({
   Name = "Potion-Tower Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Potion Tower"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportFairy = Home:CreateButton({
   Name = "Fairy-Pond Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Fairy Pond"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportVoid = Home:CreateButton({
   Name = "The Void Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["The Void"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportFusion = Home:CreateButton({
   Name = "Fusion-(Horns) Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Fusion"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportBanish = Home:CreateButton({
   Name = "Banished-Realm Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Banished Realm"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local bedsSefindyDivider = Home:CreateDivider()

local teleportBed = Home:CreateButton({
   Name = "Royal-Bed Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Royal Bed"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportCelestTower = Home:CreateButton({
   Name = "Celestial-Tower Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Celestial Tower"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkle",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportDividerr = Home:CreateDivider()

-- baddie piss on me

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
