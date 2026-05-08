local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpgradeRemote = Remotes:WaitForChild("Upgrade")
local ResetRemote = Remotes:WaitForChild("Reset")

---------------------------------------------------
-- WINDOW
---------------------------------------------------
local Window = Rayfield:CreateWindow({
	Name = "Developer Studio Hub",
	LoadingTitle = "Loading Systems...",
	LoadingSubtitle = "Full Test Build",
	ConfigurationSaving = { Enabled = false }
})

---------------------------------------------------
-- TABS
---------------------------------------------------
local UpgradesTab = Window:CreateTab("Upgrades", 4483362458)
local RunesTab = Window:CreateTab("Runes", 4483362458)
local AutoTab = Window:CreateTab("Auto", 4483362458)

---------------------------------------------------
-- UPGRADES SECTION
---------------------------------------------------

UpgradesTab:CreateSection("Crystallize")

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

local timeUpgrades = {
	{"Time Gain","Max","Time","Time"},
	{"Turbo Time","Max","Time","Time"},
	{"Rune Luck II","Max","Time","Time"},
	{"Rune Bulk II","Max","Time","Time"},
	{"Rune Speed II","Max","Time","Time"},
}

UpgradesTab:CreateButton({
	Name = "Max Time Machine Upgrades",
	Callback = function()
		for _,v in ipairs(timeUpgrades) do
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
-- ASCENSION (AP)
---------------------------------------------------
UpgradesTab:CreateSection("Ascension (AP)")

UpgradesTab:CreateButton({
	Name = "Ascension Reset",
	Callback = function()
		ResetRemote:FireServer("Ascension")
	end
})

local apUpgrades = {
	{"Coin Multi III","Max","AP","Ascension Points"},
	{"PP Multi","Max","AP","Ascension Points"},
	{"XP Multi","Max","AP","Ascension Points"},
	{"Max Roll III","Max","AP","Ascension Points"},
	{"Min Roll II","Max","AP","Ascension Points"},
	{"Extra Dice II","Max","AP","Ascension Points"},
}

UpgradesTab:CreateButton({
	Name = "Max Ascension Upgrades",
	Callback = function()
		for _,v in ipairs(apUpgrades) do
			UpgradeRemote:FireServer(v[1],v[2],v[3],v[4])
		end
	end
})

---------------------------------------------------
-- PRESTIGE (PP)
---------------------------------------------------
UpgradesTab:CreateSection("Prestige (PP)")

UpgradesTab:CreateButton({
	Name = "Prestige Reset",
	Callback = function()
		ResetRemote:FireServer("Prestige")
	end
})

local ppUpgrades = {
	{"Coin Multi II","Max","PP","Prestige Points"},
	{"PP XP Multi","Max","PP","Prestige Points"},
	{"Max Roll II","Max","PP","Prestige Points"},
	{"Min Roll","Max","PP","Prestige Points"},
	{"Extra Dice","Max","PP","Prestige Points"},
	{"Walkspeed","Max","PP","Prestige Points"},
}

UpgradesTab:CreateButton({
	Name = "Max Prestige Upgrades",
	Callback = function()
		for _,v in ipairs(ppUpgrades) do
			UpgradeRemote:FireServer(v[1],v[2],v[3],v[4])
		end
	end
})

---------------------------------------------------
-- SMALL UPGRADES
---------------------------------------------------
UpgradesTab:CreateSection("Small Upgrades (Coins)")

local smallUpgrades = {
	{"Coin Gain","Max","Coins","Coins"},
	{"Coin Multi","Max","Coins","Coins"},
	{"Max Roll","Max","Coins","Coins"},
}

UpgradesTab:CreateButton({
	Name = "Max Small Upgrades",
	Callback = function()
		for _,v in ipairs(smallUpgrades) do
			UpgradeRemote:FireServer(v[1],v[2],v[3],v[4])
		end
	end
})

---------------------------------------------------
-- RUNES SYSTEM
---------------------------------------------------
local function createRune(name, getHitbox)
	local enabled = false

	RunesTab:CreateToggle({
		Name = name,
		CurrentValue = false,
		Callback = function(v)
			enabled = v

			if enabled then
				task.spawn(function()
					while enabled do
						local char = player.Character or player.CharacterAdded:Wait()
						local hrp = char:WaitForChild("HumanoidRootPart")

						local hitbox = getHitbox()
						if hitbox then
							firetouchinterest(hrp, hitbox, 0)
							firetouchinterest(hrp, hitbox, 1)
						end

						task.wait(0.2)
					end
				end)
			end
		end
	})
end

RunesTab:CreateSection("Main Runes")

createRune("Basic Rune", function()
	local r = workspace.Runes:FindFirstChild("Basic")
	return r and r:FindFirstChild("Hitbox")
end)

createRune("Roller Rune", function()
	local r = workspace.Runes:FindFirstChild("Roller")
	return r and r:FindFirstChild("Hitbox")
end)

createRune("Qualities Rune", function()
	local r = workspace.Runes:FindFirstChild("Qualities")
	return r and r:FindFirstChild("Hitbox")
end)

createRune("Ancient Rune", function()
	local r = workspace.Runes:FindFirstChild("Ancient")
	return r and r:FindFirstChild("Hitbox")
end)

RunesTab:CreateSection("Event Runes")

createRune("Celebration Rune", function()
	local r = workspace.Runes:FindFirstChild("Celebration")
	return r and r:FindFirstChild("Hitbox")
end)

createRune("250K Rune", function()
	local r = workspace.Runes:FindFirstChild("250K")
	return r and r:FindFirstChild("Hitbox")
end)

---------------------------------------------------
-- AUTO SYSTEM
---------------------------------------------------
AutoTab:CreateSection("Auto Systems")

AutoTab:CreateToggle({
	Name = "Auto Roll Dice",
	CurrentValue = false,
	Callback = function(v)
		task.spawn(function()
			local remote = Remotes:WaitForChild("Roll")

			while v do
				pcall(function()
					remote:FireServer()
				end)
				task.wait(2)
			end
		end)
	end
})

AutoTab:CreateToggle({
	Name = "Auto Glyph Roll",
	CurrentValue = false,
	Callback = function(v)
		task.spawn(function()
			local remote = Remotes:WaitForChild("RollGlyph")

			while v do
				pcall(function()
					remote:InvokeServer()
				end)
				task.wait(2)
			end
		end)
	end
})
