local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

---------------------------------------------------
-- SERVICES
---------------------------------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local ResetRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Reset")
local UpgradeRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrade")

---------------------------------------------------
-- WINDOW (ONLY ONCE)
---------------------------------------------------
local Window = Rayfield:CreateWindow({
	Name = "Developer Studio",
	LoadingTitle = "Loading...",
	LoadingSubtitle = "All Systems Combined",
	ConfigurationSaving = { Enabled = false }
})

---------------------------------------------------
-- TABS
---------------------------------------------------
local UpgradesTab = Window:CreateTab("Upgrades", 4483362458)
local RunesTab = Window:CreateTab("Runes", 4483362458)
local AutoTab = Window:CreateTab("Auto", 4483362458)

---------------------------------------------------
-- UPGRADES
---------------------------------------------------

-- CRYSTALLIZE
UpgradesTab:CreateSection("Crystallize (HIGHEST)")

UpgradesTab:CreateButton({
	Name = "Crystallize Reset",
	Callback = function()
		ResetRemote:FireServer("Crystallize")
	end
})

local crystallizeUpgrades = {
	{"Coin Multi V","Max","Crystals","Crystals"},
	{"Time Gain II","Max","Crystals","Crystals"},
	{"Energy Gain II","Max","Crystals","Crystals"},
	{"Energy Multi II","Max","Crystals","Crystals"},
	{"Variant Luck","Max","Crystals","Crystals"},
	{"Rune Luck III","Max","Crystals","Crystals"},
}

UpgradesTab:CreateButton({
	Name = "Max Crystallize Upgrades",
	Callback = function()
		for _,v in ipairs(crystallizeUpgrades) do
			UpgradeRemote:FireServer(v[1],v[2],v[3],v[4])
		end
	end
})

---------------------------------------------------
-- ENERGY
---------------------------------------------------
UpgradesTab:CreateSection("Energy")

local energyUpgrades = {
	{"Energy Multi","Max","Energy","Energy"},
	{"Faster Energy","Max","Energy","Energy"},
}

UpgradesTab:CreateButton({
	Name = "Max Energy Upgrades",
	Callback = function()
		for _,v in ipairs(energyUpgrades) do
			UpgradeRemote:FireServer(v[1],v[2],v[3],v[4])
		end
	end
})

---------------------------------------------------
-- TIME MACHINE
---------------------------------------------------
UpgradesTab:CreateSection("Time Machine")

local timeMachineUpgrades = {
	{"Time Gain","Max","Time","Time"},
	{"Turbo Time","Max","Time","Time"},
	{"Rune Luck II","Max","Time","Time"},
	{"Rune Bulk II","Max","Time","Time"},
	{"Rune Speed II","Max","Time","Time"},
}

UpgradesTab:CreateButton({
	Name = "Max Time Machine Upgrades",
	Callback = function()
		for _,v in ipairs(timeMachineUpgrades) do
			UpgradeRemote:FireServer(v[1],v[2],v[3],v[4])
		end
	end
})

---------------------------------------------------
-- TRANSCENSION
---------------------------------------------------
UpgradesTab:CreateSection("Transcension (TP)")

UpgradesTab:CreateButton({
	Name = "Transcension Reset",
	Callback = function()
		ResetRemote:FireServer("Transcension")
	end
})

---------------------------------------------------
-- RUNES
---------------------------------------------------
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

						local hitbox = getHitbox()
						if hitbox then
							firetouchinterest(hrp, hitbox, 0)
							firetouchinterest(hrp, hitbox, 1)
						end

						task.wait()
					end
				end)
			end
		end
	})
end

-- MAIN RUNES
createRuneToggle("Basic Rune", function()
	local r = workspace.Runes:FindFirstChild("Basic")
	return r and r:FindFirstChild("Hitbox")
end)

createRuneToggle("Roller Rune", function()
	local r = workspace.Runes:FindFirstChild("Roller")
	return r and r:FindFirstChild("Hitbox")
end)

createRuneToggle("Qualities Rune", function()
	local r = workspace.Runes:FindFirstChild("Qualities")
	return r and r:FindFirstChild("Hitbox")
end)

createRuneToggle("Ancient Rune", function()
	local r = workspace.Runes:FindFirstChild("Ancient")
	return r and r:FindFirstChild("Hitbox")
end)

-- EVENT RUNES
RunesTab:CreateSection("Event Runes")

createRuneToggle("Celebration Rune", function()
	local r = workspace.Runes:FindFirstChild("Celebration")
	return r and r:FindFirstChild("Hitbox")
end)

createRuneToggle("250K Rune", function()
	local r = workspace.Runes:FindFirstChild("250K")
	return r and r:FindFirstChild("Hitbox")
end)

---------------------------------------------------
-- AUTO SYSTEM
---------------------------------------------------
AutoTab:CreateSection("Auto")

local glyphEnabled = false
local diceEnabled = false
local tempoEnabled = false

AutoTab:CreateToggle({
	Name = "Auto Roll Glyph",
	CurrentValue = false,
	Callback = function(Value)
		glyphEnabled = Value

		if glyphEnabled then
			task.spawn(function()
				local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RollGlyph")

				while glyphEnabled do
					pcall(function()
						remote:InvokeServer()
					end)
					task.wait(2)
				end
			end)
		end
	end
})

AutoTab:CreateToggle({
	Name = "Auto Roll Dice",
	CurrentValue = false,
	Callback = function(Value)
		diceEnabled = Value

		if diceEnabled then
			task.spawn(function()
				local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Roll")

				while diceEnabled do
					pcall(function()
						remote:FireServer()
					end)
					task.wait(2)
				end
			end)
		end
	end
})

AutoTab:CreateToggle({
	Name = "Auto Tempo Reset",
	CurrentValue = false,
	Callback = function(Value)
		tempoEnabled = Value

		if tempoEnabled then
			task.spawn(function()
				local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Reset")

				while tempoEnabled do
					pcall(function()
						remote:FireServer("Time Machine")
					end)
					task.wait(2)
				end
			end)
		end
	end
})
