-- SCRIPT SERVER GABUNGAN: CASH + DATA INVENTORY UTUK PLAYER BARU
--Test Item Script (Dog,Cat,Dragon) Test Pet
--(Choco Chair) Test Furniture 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DapatkanItemEvent = ReplicatedStorage:WaitForChild("DapatkanItemEvent")

-- Giving Rarity to pets
local listPetContoh = {
	{Nama = "Doggy", Kategori = "Pets", Rarity = "Common"},
	{Nama = "Cat", Kategori = "Pets", Rarity = "Uncommon"},
	{Nama = "Dragon", Kategori = "Pets", Rarity = "Legendary"},
	{Nama = "Choco Chair", Kategori = "Furniture", Rarity = "Common"}
}

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 1000
	cash.Parent = leaderstats

	task.wait(3)

	for _, dataItem in pairs(listPetContoh) do
		DapatkanItemEvent:FireClient(player, dataItem.Nama, dataItem.Kategori, dataItem.Rarity)
		task.wait(0.1)
	end
end)
