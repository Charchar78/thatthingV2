local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local spawnLocationDependancy = ReplicatedStorage:FindFirstChild("spawnLocationDependancy") or Instance.new("StringValue")
spawnLocationDependancy.Parent = ReplicatedStorage
spawnLocationDependancy.Name = "spawnLocationDependancy"
spawnLocationDependancy.Value = "Village"

local spawnDependancy = ReplicatedStorage:FindFirstChild("spawnDependancy") or Instance.new("BoolValue")
spawnDependancy.Parent = ReplicatedStorage
spawnDependancy.Name = "spawnDependancy"
spawnDependancy.Value = false

local massflameZdependancy = ReplicatedStorage:FindFirstChild("massflameZdependancy") or Instance.new("BoolValue")
massflameZdependancy.Parent = ReplicatedStorage
massflameZdependancy.Name = "massflameZdependancy"
massflameZdependancy.Value = false

local massflameZ = massflameZdependancy.Value

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

local UserInputService = game:GetService("UserInputService")
local jumpConnection -- to store the event connection

local function getHumanoid(target)
    local character = target.Character or target.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local MainWindow = Rayfield:CreateWindow({
   Name = "WitchCraft V2 (Public) - Carolin",
   Icon = "sun-moon", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by Carolin",
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "n", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "WitchCraftV2P", -- Create a custom folder for your hub/game
      FileName = "ZaWindowVladdyP"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "You need a Key for this!",
      Subtitle = "Key System",
      Note = "All Keys are Secret and expected to stay that way.", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Quak35"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
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

local teleportLocationsSection = Home:CreateSection("Teleports - ")

local teleportVillage = Home:CreateButton({
   Name = "Village Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Village"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "moon-star",
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
            Image = "moon-star",
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
            Image = "moon-star",
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
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local cavesSefindyDivider = Home:CreateDivider()

local teleportVoid = Home:CreateButton({
   Name = "The Void Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["The Void"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "moon-star",
      })
      local HumanoidRootPart = localPlayer.Character.HumanoidRootPart
      HumanoidRootPart.CFrame = CFrame.new(teleportDestination, teleportDestination + HumanoidRootPart.CFrame.LookVector)
   end,
})

local teleportBed = Home:CreateButton({
   Name = "Royal-Bed Teleport - ",
   Callback = function()
      local teleportDestination = teleportLocations["Royal Bed"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
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
      local teleportDestination = teleportLocations["Celestial Tower"]
      Rayfield:Notify({
            Title = "Teleported - ",
            Content = "You've teleported to " .. getLocationNameFromVector(teleportDestination) .. "!",
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

local mortalRankButton = playerModTab:CreateButton({
   Name = "Mortal - ",
   Callback = function()
        local rankSet = "Mortal"
        local collour = teamColors[rankSet]
        local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

        a9oiw:FireServer(collour)
      
   end,
})

local hexRankButton = playerModTab:CreateButton({
   Name = "Hex Witch - ",
   Callback = function()
        local rankSet = "Hex Witch"
        local collour = teamColors[rankSet]
        local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

        a9oiw:FireServer(collour)
      
   end,
})

local angelRankButton = playerModTab:CreateButton({
   Name = "Angel - ",
   Callback = function()
        local rankSet = "Angel"
        local collour = teamColors[rankSet]
        local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

        a9oiw:FireServer(collour)
      
   end,
})

local fallenRankButton = playerModTab:CreateButton({
   Name = "Fallen Angel - ",
   Callback = function()
        local rankSet = "Fallen Angel"
        local collour = teamColors[rankSet]
        local a9oiw = ReplicatedStorage.Remotes.a9oiw -- RemoteEvent 

        a9oiw:FireServer(collour)
      
   end,
})

local fffendyDivider = playerModTab:CreateDivider()

local massFlamesKeySection = customSpellTab:CreateSection("Mass Key -")

local massKey = customSpellTab:CreateInput({
   Name = "PUT MASS KEY HERE - ",
   CurrentValue = "",
   PlaceholderText = "Passkey Here.",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        if Text == "Quak35" or Text == "JosH22" then

            massflameZ = true

            Rayfield:Notify({
                Title = "Key Accepted - ",
                Content = 'Your key is "' .. Text .. '"!',
                Duration = 6.5,
                Image = "key",
            })
        elseif Text ~= "Quak35" and Text ~= "JosH22" then
            massflameZ = false
            Rayfield:Notify({
                Title = "Key Denied - ",
                Content = '"' .. Text .. '" is not a valid Key!',
                Duration = 6.5,
                Image = "lock",
            })
        elseif Text == "WakeuP90" then
            massflameZ = false
            Rayfield:Notify({
                Title = "You Tried 😭 - ",
                Content = '"' .. Text .. '" is a banned Key!',
                Duration = 6.5,
                Image = "trash-2",
            })
        end
   end,
})

local fffendyDfffivider = customSpellTab:CreateDivider()

-- SPELLS SECTION!!!!!
local massFlamesSection = customSpellTab:CreateSection("Mass Flames -")

local massIgnis = customSpellTab:CreateButton({
    Name = "Mass Ignis -",
    Callback = function()
        if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
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
        if massflameZ == true then
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
            elseif localPlayer.Team.Name ~= "Fallen Angel" and localPlayer.Team.Name ~= "Royal Bloodline" then
                Rayfield:Notify({
                    Title = "Mass Denied - ",
                    Content = "You are not the right Rank!",
                    Duration = 6.5,
                    Image = "octagon-alert",
                })
            end
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massHolyFire = customSpellTab:CreateButton({
    Name = "Mass Holy-Fire (Angel Only!) -",
    Callback = function()
        if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massHolyHeal = customSpellTab:CreateButton({
    Name = "Mass Heal -",
    Callback = function()
        if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
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
        if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local massFreeze = customSpellTab:CreateButton({
    Name = "Mass Freeze -",
    Callback = function()
        if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
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

local massFlameBinds = bindsTab:CreateSection("Mass Flames -")

local bindMassHellFire = bindsTab:CreateKeybind({
   Name = "Mass HellFire - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindHellFire", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local bindMassHolyFire = bindsTab:CreateKeybind({
   Name = "Mass Holy-Fire - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindHolyFire", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local bindHolyHeal = bindsTab:CreateKeybind({
   Name = "Mass Heal - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindHeal", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
        if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
        end
    end,
})

local bindMassVines = bindsTab:CreateKeybind({
   Name = "Mass Freeze - ",
   CurrentKeybind = "KeypadOne",
   HoldToInteract = false,
   Flag = "bindFreeze", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
   if massflameZ == true then
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
        else
            Rayfield:Notify({
                Title = "Mass Denied - ",
                Content = "You do not have a Mass Key!",
                Duration = 6.5,
                Image = "octagon-alert",
            })
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



local fffendyDivider = bindsTab:CreateDivider()

local spawnPointer = miscTab:CreateSection("SpawnPoint -")

local spawnDropdown = miscTab:CreateDropdown({
   Name = "SpawnPoint Selector - ",
   Options = {"Village", "Magic Circle", "C.O.N", "Caves", "The Void", "Royal Bed", "Celestial Tower"},
   CurrentOption = "Village",
   MultipleOptions = false,
   Flag = "currentPoint", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
      local selectedOption = Options[1]
      local teleportDestination = teleportLocations[selectedOption]

      if teleportDestination then
         spawnLocationDependancy.Value = selectedOption
         Rayfield:Notify({
            Title = "Location Set - ",
            Content = "Your Spawn Location is " .. getLocationNameFromVector(teleportDestination) .. "!",
            Duration = 6.5,
            Image = "sparkles",
        })
      end
   end,
})

local spawnToggler = miscTab:CreateToggle({
   Name = "Custom SpawnPoint - ",
   CurrentValue = false,
   Flag = "spawnyPointy", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
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
        
        if prediction > 100000 then
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
                Image = "circle-pound-sterling",
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

local fffffffejfndyDivider = miscTab:CreateDivider()

local ffjspawnPointer = miscTab:CreateSection("Badge Giver -")

local angelWingBurn = miscTab:CreateButton({
   Name = "Get Badges - ",
   Callback = function()
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
   end,
})

local spawnPointer = miscTab:CreateSection("Burning Wings -")

local angelWingBurn = miscTab:CreateButton({
   Name = "Burn your Wings (Angel) - ",
   Callback = function()
   local remoteWing = ReplicatedStorage.BurnAngelWing
   remoteWing:FireServer()
   end,
})

local fffffffendyDivider = miscTab:CreateDivider()

local ffspawnPointer = miscTab:CreateSection("Dev Tools -")

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
