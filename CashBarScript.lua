--Server script for player's cash
--not complete just for showing total cash player had
local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local cash = leaderstats:WaitForChild("Cash")
local cashText = script.Parent:WaitForChild("CashBar"):WaitForChild("CashText")
local function updateCashUI(newAmount)
	cashText.Text = "$" .. tostring(newAmount)
end

updateCashUI(cash.Value)
cash.Changed:Connect(updateCashUI)
