local mainUI = script.Parent
local inventoryButton = mainUI:WaitForChild("InventoryButton")
local inventoryMenu = mainUI:WaitForChild("InventoryMenu")

local TweenService = game:GetService("TweenService")

inventoryMenu.Visible = false

local warnaAktif = Color3.fromRGB(255, 240, 210)  
local warnaMati  = Color3.fromRGB(150, 110, 95)   

local teksAktif  = Color3.fromRGB(80, 50, 30)      
local teksMati   = Color3.fromRGB(240, 240, 240)    

local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) --Animation script

local function animasiKlik(tombol)
	local ukuranAsli = tombol.Size

	local membesar = TweenService:Create(tombol, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(ukuranAsli.X.Scale, ukuranAsli.X.Offset + 6, ukuranAsli.Y.Scale, ukuranAsli.Y.Offset + 4)
	})

	local normal Lagi = TweenService:Create(tombol, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = ukuranAsli
	})

	membesar:Play()
	membesar.Completed:Connect(function()
		normalLagi:Play()
	end)
end

local function bukaTab(namaTab)
	local tabsContainer = inventoryMenu:FindFirstChild("TabsContainer")
	local contentScroll = inventoryMenu:FindFirstChild("ContentScroll")
	if not tabsContainer then return end

	local petsTab = tabsContainer:FindFirstChild("PetsTab")
	local furnitureTab = tabsContainer:FindFirstChild("FurnitureTab")
	local accessoriesTab = tabsContainer:FindFirstChild("AccesoriesTab")

	local petsGrid = contentScroll and contentScroll:FindFirstChild("PetsGrid")
	local accessoriesGrid = contentScroll and contentScroll:FindFirstChild("AccesoriesGrid")

	if petsGrid then petsGrid.Visible = false end
	if accessoriesGrid then accessoriesGrid.Visible = false end

	if petsTab then TweenService:Create(petsTab, tweenInfo, {BackgroundColor3 = warnaMati, TextColor3 = teksMati}):Play() end
	if furnitureTab then TweenService:Create(furnitureTab, tweenInfo, {BackgroundColor3 = warnaMati, TextColor3 = teksMati}):Play() end
	if accessoriesTab then TweenService:Create(accessoriesTab, tweenInfo, {BackgroundColor3 = warnaMati, TextColor3 = teksMati}):Play() end

	if namaTab == "Pets" then
		if petsGrid then petsGrid.Visible = true end
		if petsTab then TweenService:Create(petsTab, tweenInfo, {BackgroundColor3 = warnaAktif, TextColor3 = teksAktif}):Play() end
	elseif namaTab == "Furniture" then
		if furnitureTab then TweenService:Create(furnitureTab, tweenInfo, {BackgroundColor3 = warnaAktif, TextColor3 = teksAktif}):Play() end
	elseif namaTab == "Accessories" then
		if accessoriesGrid then accessoriesGrid.Visible = true end
		if accessoriesTab then TweenService:Create(accessoriesTab, tweenInfo, {BackgroundColor3 = warnaAktif, TextColor3 = teksAktif}):Play() end
	end
end

inventoryButton.MouseButton1Click:Connect(function()
	animasiKlik(inventoryButton) 
	inventoryMenu.Visible = not inventoryMenu.Visible
	if inventoryMenu.Visible == true then
		bukaTab("Pets")
	end
end)

local closeButton = inventoryMenu:WaitForChild("CloseButton")
closeButton.MouseButton1Click:Connect(function()
	animasiKlik(closeButton) 
	task.wait(0.1) 
	inventoryMenu.Visible = false
end)

task.spawn(function()
	local tabsContainer = inventoryMenu:WaitForChild("TabsContainer")
	local petsTab = tabsContainer:WaitForChild("PetsTab")
	local furnitureTab = tabsContainer:WaitForChild("FurnitureTab")
	local accessoriesTab = tabsContainer:WaitForChild("AccesoriesTab")

	petsTab.MouseButton1Click:Connect(function() 
		animasiKlik(petsTab)
		bukaTab("Pets") 
	end)

	furnitureTab.MouseButton1Click:Connect(function() 
		animasiKlik(furnitureTab)
		bukaTab("Furniture") 
	end)

	accessoriesTab.MouseButton1Click:Connect(function() 
		animasiKlik(accessoriesTab)
		bukaTab("Accessories") 
	end)
end)
