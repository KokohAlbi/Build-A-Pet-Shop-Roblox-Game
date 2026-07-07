--Inventory system with 3 categorie
local mainUI = script.Parent
local inventoryButton = mainUI:WaitForChild("InventoryButton")
local inventoryMenu = mainUI:WaitForChild("InventoryMenu")

local TweenService = game:GetService("TweenService")
local UKURAN_ASLI_TOMBOL_INV = inventoryButton.Size 
local UKURAN_ASLI_MENU_INV = inventoryMenu.Size 

local TWEEN_FAST = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_NORMAL = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_POP = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local warnaAktif = Color3.fromRGB(255, 240, 210)  -- Vanilla Terang
local warnaMati  = Color3.fromRGB(150, 110, 95)   -- Cokelat Redup
local teksAktif  = Color3.fromRGB(80, 50, 30)      -- Cokelat Gelap
local teksMati   = Color3.fromRGB(240, 240, 240)    -- Putih Abu-abu

local function animasiKlikTombol(tombol, ukuranNormal)
	tombol.Size = ukuranNormal
	local membesar = TweenService:Create(tombol, TWEEN_FAST, {
		Size = UDim2.new(ukuranNormal.X.Scale, ukuranNormal.X.Offset + 6, ukuranNormal.Y.Scale, ukuranNormal.Y.Offset + 4)
	})
	local normalLagi = TweenService:Create(tombol, TWEEN_NORMAL, {Size = ukuranNormal})
	membesar:Play()
	membesar.Completed:Connect(function() normalLagi:Play() end)
end

local function aturFadeGrid(gridObj, targetTransparansi)
	if not gridObj then return end
	if gridObj:IsA("CanvasGroup") then
		TweenService:Create(gridObj, TWEEN_NORMAL, {GroupTransparency = targetTransparansi}):Play()
	end
end

local function bukaTab(namaTab)
	local tabsContainer = inventoryMenu:FindFirstChild("TabsContainer")
	local contentScroll = inventoryMenu:FindFirstChild("ContentScroll")
	if not tabsContainer or not contentScroll then return end

	local petsTab = tabsContainer:FindFirstChild("PetsTab")
	local furnitureTab = tabsContainer:FindFirstChild("FurnitureTab")
	local accessoriesTab = tabsContainer:FindFirstChild("AccesoriesTab")

	local grids = {
		Pets = contentScroll:FindFirstChild("PetsGrid"),
		Furniture = contentScroll:FindFirstChild("FurnitureGrid"),
		Accessories = contentScroll:FindFirstChild("AccesoriesGrid")
	}

	for _, gridObj in pairs(grids) do
		if gridObj then 
			gridObj.Visible = false
			if gridObj:IsA("CanvasGroup") then gridObj.GroupTransparency = 1 end
		end
	end

	if petsTab then TweenService:Create(petsTab, TWEEN_NORMAL, {BackgroundColor3 = warnaMati, TextColor3 = teksMati}):Play() end
	if furnitureTab then TweenService:Create(furnitureTab, TWEEN_NORMAL, {BackgroundColor3 = warnaMati, TextColor3 = teksMati}):Play() end
	if accessoriesTab then TweenService:Create(accessoriesTab, TWEEN_NORMAL, {BackgroundColor3 = warnaMati, TextColor3 = teksMati}):Play() end

	local targetGrid = grids[namaTab]
	local targetTab = (namaTab == "Pets" and petsTab) or (namaTab == "Furniture" and furnitureTab) or (namaTab == "Accessories" and accessoriesTab)

	if targetGrid then
		targetGrid.Visible = true
		aturFadeGrid(targetGrid, 0) 
	end

	if targetTab then
		TweenService:Create(targetTab, TWEEN_NORMAL, {BackgroundColor3 = warnaAktif, TextColor3 = teksAktif}):Play()
	end
end

inventoryMenu.Visible = false

inventoryButton.MouseButton1Click:Connect(function()
	animasiKlikTombol(inventoryButton, UKURAN_ASLI_TOMBOL_INV)

	if not inventoryMenu.Visible then
		inventoryMenu.Visible = true
		inventoryMenu.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(inventoryMenu, TWEEN_POP, {Size = UKURAN_ASLI_MENU_INV}):Play()
		bukaTab("Pets")
	else
		local mengecil = TweenService:Create(inventoryMenu, TWEEN_NORMAL, {Size = UDim2.new(0, 0, 0, 0)})
		mengecil:Play()
		mengecil.Completed:Connect(function() inventoryMenu.Visible = false end)
	end
end)

local closeButton = inventoryMenu:WaitForChild("CloseButton")
closeButton.MouseButton1Click:Connect(function()
	animasiKlikTombol(closeButton, closeButton.Size)
	local tutup = TweenService:Create(inventoryMenu, TWEEN_NORMAL, {Size = UDim2.new(0, 0, 0, 0)})
	tutup:Play()
	tutup.Completed:Connect(function() inventoryMenu.Visible = false end)
end)

task.spawn(function()
	local tabsContainer = inventoryMenu:WaitForChild("TabsContainer")
	local petsTab = tabsContainer:WaitForChild("PetsTab")
	local furnitureTab = tabsContainer:WaitForChild("FurnitureTab")
	local accessoriesTab = tabsContainer:WaitForChild("AccesoriesTab")

	petsTab.MouseButton1Click:Connect(function() animasiKlikTombol(petsTab, petsTab.Size); bukaTab("Pets") end)
	furnitureTab.MouseButton1Click:Connect(function() animasiKlikTombol(furnitureTab, furnitureTab.Size); bukaTab("Furniture") end)
	accessoriesTab.MouseButton1Click:Connect(function() animasiKlikTombol(accessoriesTab, accessoriesTab.Size); bukaTab("Accessories") end)
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DapatkanItemEvent = ReplicatedStorage:WaitForChild("DapatkanItemEvent")
local contentScroll = inventoryMenu:WaitForChild("ContentScroll")

DapatkanItemEvent.OnClientEvent:Connect(function(namaItem, kategori)
	local targetGrid = contentScroll:FindFirstChild(kategori .. "Grid")

	if targetGrid then
		local template = targetGrid:FindFirstChild("SlotTemplate")
		if template then
			local slotBaru = template:Clone()
			slotBaru.Name = namaItem
			slotBaru.Visible = true 
			slotBaru.Parent = targetGrid
			local textLabel = slotBaru:FindFirstChildOfClass("TextLabel")
			if textLabel then
				textLabel.Text = namaItem
			end
		end
	end
end)
