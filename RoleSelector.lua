local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local a9oiw = ReplicatedStorage.Remotes.a9oiw

local teamColors = {
    ["Mortal"] = BrickColor.new("Fossil"),
    ["Pagan Witch"] = BrickColor.new("Bright bluish green"),
    ["Weak Witch"] = BrickColor.new("Lapis"),
    ["Advanced Witch"] = BrickColor.new("Royal purple"),
    ["Hex Witch"] = BrickColor.new("Persimmon"),
    ["Fairy"] = BrickColor.new("Sea green"),
    ["Angel"] = BrickColor.new("Cool yellow"),
    ["Fallen Angel"] = BrickColor.new("Black"),
    ["Royal Bloodline"] = BrickColor.new("Crimson"),
    ["Pagan God"] = nil --BrickColor.new("Steel blue"),
    ["Egyptian Queen"] = nil --BrickColor.new("Really red"),
    ["Archangel"] = nil --BrickColor.new("Mid gray"),
    ["Hecate"] = nil --BrickColor.new("Dark indigo")
}

local function sendNotification(title, text)
  if typeof(title) ~= "string" then
    return
  end

  if typeof(text) ~= "string" then
    return
  end
  
  pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

local function roleChange(team, noNotifs)
  local selectedOption = team
  local colour = teamColors[selectedOption]

  if colour then
    a9oiw:FireServer(colour)
  elseif noNotifs and not colour then
    local text = tostring(team) .. " is not valid."
    sendNotification("Role Changer", )
  end
end

return {
    roleChange = roleChange,
    teamColors = teamColors,
    sendNotification = sendNotification
}
