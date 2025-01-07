-- Adicionando um print para debug
print("Script carregado com sucesso!")

-- Configuração da Interface
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local FarmFrame = Instance.new("Frame")
local AutoFarmCheckbox = Instance.new("TextButton")
local FarmLabel = Instance.new("TextLabel")

-- Propriedades básicas
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Visible = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Text = "Abrir Menu"

FarmFrame.Name = "FarmFrame"
FarmFrame.Parent = MainFrame
FarmFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmFrame.Position = UDim2.new(0, 10, 0, 40)
FarmFrame.Size = UDim2.new(0, 180, 0, 100)

FarmLabel.Name = "FarmLabel"
FarmLabel.Parent = FarmFrame
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0, 10, 0, 10)
FarmLabel.Size = UDim2.new(0, 160, 0, 20)
FarmLabel.Text = "Farm Options"
FarmLabel.TextColor3 = Color3.new(1, 1, 1)
FarmLabel.TextSize = 16

AutoFarmCheckbox.Name = "AutoFarmCheckbox"
AutoFarmCheckbox.Parent = FarmFrame
AutoFarmCheckbox.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
AutoFarmCheckbox.Position = UDim2.new(0, 10, 0, 40)
AutoFarmCheckbox.Size = UDim2.new(0, 20, 0, 20)
AutoFarmCheckbox.Text = ""

-- Lógica do botão de toggle
local isMenuOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
end)

-- Lógica do Auto Farm Checkbox
local isAutoFarmActive = false
AutoFarmCheckbox.MouseButton1Click:Connect(function()
    isAutoFarmActive = not isAutoFarmActive
    AutoFarmCheckbox.BackgroundColor3 = isAutoFarmActive and Color3.new(0, 1, 0) or Color3.new(0.5, 0.5, 0.5)

    if isAutoFarmActive then
        print("Auto Farm iniciado!")
        -- Lógica de Auto Farm
        while isAutoFarmActive do
            -- Exemplo de função (você pode implementar seu Auto Farm aqui)
            wait(1)
            print("Farmando níveis...")
        end
    else
        print("Auto Farm desativado!")
    end
end)
