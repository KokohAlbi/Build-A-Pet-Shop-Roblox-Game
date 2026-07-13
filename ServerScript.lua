-- SCRIPT SERVER GABUNGAN: CASH + DATA INVENTORY UTUK PLAYER BARU
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DapatkanItemEvent = ReplicatedStorage:WaitForChild("DapatkanItemEvent")

local listPetContoh = {
	{Nama = "Doggy", Kategori = "Pets"},
	{Nama = "Cat", Kategori = "Pets"},
	{Nama = "Dragon", Kategori = "Pets"},
	{Nama = "Choco Chair", Kategori = "Furniture"}
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

	print("Mengirim data item contoh ke inventory: " .. player.Name)

	for _, dataItem in pairs(listPetContoh) do
		DapatkanItemEvent:FireClient(player, dataItem.Nama, dataItem.Kategori)
		task.wait(0.1) 
	end
end)
