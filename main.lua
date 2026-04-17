local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Sploink hub",
    LoadingTitle = "Sploink hub",
    LoadingSubtitle = "by Emilio",
    ConfigurationSaving = {
        Enabled = false
    }
})

local player = game.Players.LocalPlayer

-- Tabs
local RunesTab = Window:CreateTab("Runes", 4483362458)
local WorldsTab = Window:CreateTab("Worlds", 4483362458)
local DiceTab = Window:CreateTab("Dice", 4483362458)
local GlyphsTab = Window:CreateTab("Glyphs", 4483362458)

-- =====================
-- RUNES SYSTEM
-- =====================
local function createRuneToggle(name, getHitbox)
    local enabled = false

    RunesTab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Callback = function(Value)
            enabled = Value

            if enabled then
                task.spawn(function()
                    while enabled do
                        local character = player.Character or player.CharacterAdded:Wait()
                        local hrp = character:WaitForChild("HumanoidRootPart")

                        local h = getHitbox()
                        if h then
                            firetouchinterest(hrp, h, 0)
                            firetouchinterest(hrp, h, 1)
                        end

                        task.wait()
                    end
                end)
            end
        end
    })
end

-- Runes
createRuneToggle("Qualities Rune", function()
    return workspace.Runes.Qualities:FindFirstChild("Hitbox")
end)

createRuneToggle("Basic Rune", function()
    return workspace.Runes:FindFirstChild("Basic") and workspace.Runes["Basic"]:FindFirstChild("Hitbox")
end)

createRuneToggle("250K Rune", function()
    return workspace.Runes:FindFirstChild("250K") and workspace.Runes["250K"]:FindFirstChild("Hitbox")
end)

createRuneToggle("Roller Rune", function()
    return workspace.Runes:FindFirstChild("Roller") and workspace.Runes["Roller"]:FindFirstChild("Hitbox")
end)

-- =====================
-- GLYPHS (MOVED HERE)
-- =====================
local glyphEnabled = false

GlyphsTab:CreateToggle({
    Name = "Auto Roll Glyph",
    CurrentValue = false,
    Callback = function(Value)
        glyphEnabled = Value

        if glyphEnabled then
            task.spawn(function()
                local remote = game:GetService("ReplicatedStorage")
                    :WaitForChild("Remotes")
                    :WaitForChild("RollGlyph")

                while glyphEnabled do
                    pcall(function()
                        remote:InvokeServer()
                    end)

                    task.wait(0.05)
                end
            end)
        end
    end
})

-- =====================
-- TELEPORT SYSTEM
-- =====================
local function teleportTo(cf)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    hrp.CFrame = cf
end

local worlds = {
    ["World 1"] = CFrame.new(-1.5, 0.0897500217, -80.4996796, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["World 2"] = CFrame.new(-257.60437, 0.589749992, -86.4996796, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    ["World 3"] = CFrame.new(-524, 0.589749992, -75.0002899, -1, 0, 0, 0, 1, 0, 0, 0, -1)
}

for name, cf in pairs(worlds) do
    WorldsTab:CreateButton({
        Name = "Teleport to " .. name,
        Callback = function()
            teleportTo(cf)
        end
    })
end

-- =====================
-- DICE SYSTEM
-- =====================
local diceRemote = game:GetService("ReplicatedStorage")
    :WaitForChild("Remotes")
    :WaitForChild("Roll")

DiceTab:CreateButton({
    Name = "Roll Dice",
    Callback = function()
        pcall(function()
            diceRemote:FireServer()
        end)
    end
})

local diceAuto = false
local diceCooldown = 0.2

DiceTab:CreateToggle({
    Name = "Auto Roll Dice",
    CurrentValue = false,
    Callback = function(Value)
        diceAuto = Value

        if diceAuto then
            task.spawn(function()
                while diceAuto do
                    pcall(function()
                        diceRemote:FireServer()
                    end)

                    task.wait(diceCooldown)
                end
            end)
        end
    end
})
