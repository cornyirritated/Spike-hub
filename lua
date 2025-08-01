local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Spikehub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by Spike",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "SpikeHub.txt"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Main")



local Toggle = Tab:CreateToggle({
   Name = "Auto Parry",
   CurrentValue = false,
   Flag = "getgenv().Auto Parry = false", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   local RunService = game:GetService("RunService") or game:FindFirstDescendant("RunService")
local Players = game:GetService("Players") or game:FindFirstDescendant("Players")
local VirtualInputManager = game:GetService("VirtualInputManager") or game:FindFirstDescendant("VirtualInputManager")

local Player = Players.LocalPlayer

local Cooldown = tick()
local IsParried = false
local Connection = nil

local function GetBall()
  for _, Ball in ipairs(workspace.Balls:GetChildren()) do
    if Ball:GetAttribute("realBall") then
      return Ball
    end
  end
end

local function ResetConnection()
    if Connection then
        Connection:Disconnect()
        Connection = nil
    end
end

workspace.Balls.ChildAdded:Connect(function()
    local Ball = GetBall()
    if not Ball then return end
    ResetConnection()
    Connection = Ball:GetAttributeChangedSignal("target"):Connect(function()
        Parried = false
    end)
end)

RunService.PreSimulation:Connect(function()
    local Ball, HRP = GetBall(), Player.Character.HumanoidRootPart
    if not Ball or not HRP then
      return
    end
    
    local Speed = Ball.zoomies.VectorVelocity.Magnitude
    local Distance = (HRP.Position - Ball.Position).Magnitude
    
    if Ball:GetAttribute("target") == Player.Name and not Parried and Distance / Speed <= 0.65 then
      VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
      Parried = true
      Cooldown = tick()
      
      if (tick() - Cooldown) >= 1 then
        Parried = false
      end
    end
end)
   end,
  })

local Section = Tab:CreateSection("Auto Spam")

local Toggle = Tab:CreateToggle({
   Name = "Auto Spam",
   CurrentValue = false,
   Flag = "getgenv().Auto Spam = false", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
-- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})
