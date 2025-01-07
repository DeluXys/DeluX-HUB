-- Criando a Interface Gráfica Principal
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local FarmLabel = Instance.new("TextLabel")
local AutoFarmCheckbox = Instance.new("TextButton")

-- Configurando a Interface Gráfica
ScreenGui.Parent = game.CoreGui

-- Botão de abrir/fechar
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "Abrir Menu"

-- Frame Principal
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 70)
MainFrame.Visible = false -- Começa invisível

-- Rótulo para a classe "Farm"
FarmLabel.Parent = MainFrame
FarmLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FarmLabel.Size = UDim2.new(0, 280, 0, 30)
FarmLabel.Position = UDim2.new(0, 10, 0, 10)
FarmLabel.Text = "Farm"
FarmLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
FarmLabel.TextScaled = true

-- Botão de checkbox para Auto Farm
AutoFarmCheckbox.Parent = MainFrame
AutoFarmCheckbox.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
AutoFarmCheckbox.Size = UDim2.new(0, 30, 0, 30)
AutoFarmCheckbox.Position = UDim2.new(0, 10, 0, 50)
AutoFarmCheckbox.Text = ""
local AutoFarmEnabled = false -- Estado inicial do Auto Farm

-- Adicionando texto ao lado da caixa de seleção
local AutoFarmLabel = Instance.new("TextLabel")
AutoFarmLabel.Parent = MainFrame
AutoFarmLabel.BackgroundTransparency = 1
AutoFarmLabel.Size = UDim2.new(0, 240, 0, 30)
AutoFarmLabel.Position = UDim2.new(0, 50, 0, 50)
AutoFarmLabel.Text = "Auto Farm Level"
AutoFarmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmLabel.TextScaled = true

-- Função para abrir/fechar o menu
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleButton.Text = MainFrame.Visible and "Fechar Menu" or "Abrir Menu"
end)

-- Função para o Auto Farm
function autoFarm()
    while AutoFarmEnabled do
        local enemy = getClosestEnemy()
        if enemy then
            -- Mover-se até o inimigo
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)

            -- Atacar o inimigo
            if enemy:FindFirstChild("Humanoid") then
                repeat
                    game.VirtualInputManager:SendKeyEvent(true, "E", false, game)
                    wait(0.1)
                until enemy.Humanoid.Health <= 0 or not enemy:IsDescendantOf(game.Workspace)
            end
        else
            wait(1)
        end
    end
end

-- Função para encontrar o inimigo mais próximo
function getClosestEnemy()
    local closestEnemy = nil
    local closestDistance = math.huge

    for _, npc in pairs(game.Workspace.Enemies:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            local distance = (npc.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestEnemy = npc
            end
        end
    end
    return closestEnemy
end

-- Evento para ativar/desativar o Auto Farm com a caixa de seleção
AutoFarmCheckbox.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    AutoFarmCheckbox.BackgroundColor3 = AutoFarmEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if AutoFarmEnabled then
        autoFarm()
    end
end)
