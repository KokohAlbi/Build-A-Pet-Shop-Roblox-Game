--Server script for player's cash
--not complete just for showing total cash player had
game.Players.PlayerAdded:Connect(function(player)
local leaderstats = Instance.new("Folder")
leaderstats.Name = "leaderstats"
leaderstats.Parent = player
local cash = Instance.new("IntValue")
cash.Name = "Cash"
cash.Value = 1000
cash.Parent = leaderstats
end)
