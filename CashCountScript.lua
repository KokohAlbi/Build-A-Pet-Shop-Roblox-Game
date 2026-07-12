--Server script for player's cash
--Showing how many cash player had in server leaderboard
game.Players.PlayerAdded:Connect(function(player)
local leaderstats = Instance.new("Folder")
leaderstats.Name = "leaderstats"
leaderstats.Parent = player
local cash = Instance.new("IntValue")
cash.Name = "Cash"
cash.Value = 1000
cash.Parent = leaderstats
end)
