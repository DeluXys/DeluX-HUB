-- Adicionando um print para verificar se o script foi carregado
print("Script carregado com sucesso!")

-- Configuração da Interface
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local ActionFrame = Instance.new("Frame")
local JumpCheckbox = Instance.new("TextButton")
local ClickCheckbox = Instance.new("TextButton")
local ActionLabel = Instance.new("TextLabel")

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
ToggleButton.Size = UDim2.new(0, 50, 0, 25)  -- Diminuímos o tamanho
ToggleButton.Text = "Menu"
ToggleButton.TextSize = 14

ActionFrame.Name = "ActionFrame"
ActionFrame.Parent = MainFrame
ActionFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ActionFrame.Position = UDim2.new(0, 10, 0, 40)
ActionFrame.Size = UDim2.new(0, 180, 0, 100)

ActionLabel.Name = "ActionLabel"
ActionLabel.Parent = ActionFrame
ActionLabel.BackgroundTransparency = 1
ActionLabel.Position = UDim2.new(0, 10, 0, 10)
ActionLabel.Size = UDim2.new(0, 160, 0, 20)
ActionLabel.Text = "Ações"
ActionLabel.TextColor3 = Color3.new(1, 1, 1)
ActionLabel.TextSize = 16

JumpCheckbox.Name = "JumpCheckbox"
JumpCheckbox.Parent = ActionFrame
JumpCheckbox.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
JumpCheckbox.Position = UDim2.new(0, 10, 0, 40)
JumpCheckbox.Size = UDim2.new(0, 20, 0, 20)
JumpCheckbox.Text = "Pular"

ClickCheckbox.Name = "ClickCheckbox"
ClickCheckbox.Parent = ActionFrame
ClickCheckbox.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
ClickCheckbox.Position = UDim2.new(0, 10, 0, 70)
ClickCheckbox.Size = UDim2.new(0, 20, 0, 20)
ClickCheckbox.Text = "Auto Click"

-- Variáveis para verificar o status
local isMenuOpen = false
local isJumping = false
local isClicking = false

-- Lógica do botão de toggle
ToggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
    print("Menu " .. (isMenuOpen and "aberto" or "fechado"))
end)

-- Lógica do JumpCheckbox (Fazer o personagem pular)
JumpCheckbox.MouseButton1Click:Connect(function()
    isJumping = not isJumping
    JumpCheckbox.BackgroundColor3 = isJumping and Color3.new(0, 1, 0) or Color3.new(0.5, 0.5, 0.5)

    print("Pular " .. (isJumping and "ativado!" or "desativado!"))

    -- Faz o personagem pular enquanto o AutoFarm estiver ativo
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    while isJumping do
        wait(1) -- Intervalo de tempo entre os pulos
        humanoid.Jump = true -- Faz o personagem pular
        print("Pulo realizado!")
    end
end)

-- Lógica do ClickCheckbox (Fazer o personagem clicar na tela)
ClickCheckbox.MouseButton1Click:Connect(function()
    isClicking = not isClicking
    ClickCheckbox.BackgroundColor3 = isClicking and Color3.new(0, 1, 0) or Color3.new(0.5, 0.5, 0.5)

    print("Auto Click " .. (isClicking and "ativado!" or "desativado!"))

    -- Simula um clique na tela
    local UserInputService = game:GetService("UserInputService")

    while isClicking do
        wait(0.5) -- Intervalo de tempo entre os cliques
        UserInputService.InputBegan:Fire({
            UserInputType = Enum.UserInputType.MouseButton1,
            Position = Vector2.new(math.random(0, 1920), math.random(0, 1080)),  -- posição aleatória na tela
            UserInputState = Enum.UserInputState.Begin
        })
        print("Clicando na tela...")
    end
end)

-- Tornando o botão de abrir menu móvel
local dragging = false
local dragInput, dragStart, startPos

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
