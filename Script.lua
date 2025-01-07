-- Criando a interface do usuário (GUI)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local ActionFrame = Instance.new("Frame")
local JumpCheckbox = Instance.new("TextButton")
local ClickCheckbox = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")
local ActionLabel = Instance.new("TextLabel")

-- Propriedades da interface
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)  -- Cor de fundo
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Visible = false
MainFrame.BorderRadius = UDim.new(0, 12)  -- Bordas arredondadas

-- Botão para abrir/fechar o menu
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Size = UDim2.new(0, 60, 0, 30)
ToggleButton.Text = "Abrir"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.GothamBold

-- Título do Hub
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0.5, -75, 0, 10)
TitleLabel.Size = UDim2.new(0, 150, 0, 30)
TitleLabel.Text = "Blox Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.TextStrokeTransparency = 0.5
TitleLabel.Font = Enum.Font.GothamBold

-- Ações do painel
ActionFrame.Name = "ActionFrame"
ActionFrame.Parent = MainFrame
ActionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ActionFrame.Position = UDim2.new(0, 10, 0, 50)
ActionFrame.Size = UDim2.new(0, 280, 0, 340)
ActionFrame.BorderRadius = UDim.new(0, 8)

-- Título da seção de ações
ActionLabel.Name = "ActionLabel"
ActionLabel.Parent = ActionFrame
ActionLabel.BackgroundTransparency = 1
ActionLabel.Position = UDim2.new(0, 10, 0, 10)
ActionLabel.Size = UDim2.new(0, 260, 0, 20)
ActionLabel.Text = "Ações"
ActionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionLabel.TextSize = 16
ActionLabel.Font = Enum.Font.Gotham

-- Botão de Pular Automático
JumpCheckbox.Name = "JumpCheckbox"
JumpCheckbox.Parent = ActionFrame
JumpCheckbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
JumpCheckbox.Position = UDim2.new(0, 10, 0, 50)
JumpCheckbox.Size = UDim2.new(0, 260, 0, 30)
JumpCheckbox.Text = "Pular Automaticamente"
JumpCheckbox.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpCheckbox.TextSize = 14
JumpCheckbox.Font = Enum.Font.Gotham
JumpCheckbox.TextButtonMode = Enum.TextButtonMode.Button
JumpCheckbox.BorderRadius = UDim.new(0, 5)

-- Botão de Auto Click
ClickCheckbox.Name = "ClickCheckbox"
ClickCheckbox.Parent = ActionFrame
ClickCheckbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ClickCheckbox.Position = UDim2.new(0, 10, 0, 90)
ClickCheckbox.Size = UDim2.new(0, 260, 0, 30)
ClickCheckbox.Text = "Auto Click"
ClickCheckbox.TextColor3 = Color3.fromRGB(255, 255, 255)
ClickCheckbox.TextSize = 14
ClickCheckbox.Font = Enum.Font.Gotham
ClickCheckbox.TextButtonMode = Enum.TextButtonMode.Button
ClickCheckbox.BorderRadius = UDim.new(0, 5)

-- Variáveis de controle
local isMenuOpen = false
local isJumping = false
local isClicking = false

-- Função para abrir/fechar o menu
ToggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
    ToggleButton.Text = isMenuOpen and "Fechar" or "Abrir"
    print("Menu " .. (isMenuOpen and "aberto" or "fechado"))
end)

-- Função de pulo automático
JumpCheckbox.MouseButton1Click:Connect(function()
    isJumping = not isJumping
    JumpCheckbox.BackgroundColor3 = isJumping and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(60, 60, 60)
    print("Pulo automático " .. (isJumping and "ativado" or "desativado"))

    -- Faz o personagem pular enquanto o AutoFarm estiver ativo
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    while isJumping do
        wait(1)  -- Intervalo de tempo entre os pulos
        humanoid.Jump = true  -- Faz o personagem pular
        print("Pulo realizado!")
    end
end)

-- Função de Auto Click
ClickCheckbox.MouseButton1Click:Connect(function()
    isClicking = not isClicking
    ClickCheckbox.BackgroundColor3 = isClicking and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(60, 60, 60)
    print("Auto Click " .. (isClicking and "ativado" or "desativado"))

    -- Simula o auto click a cada 0.5 segundos
    local UserInputService = game:GetService("UserInputService")

    while isClicking do
        wait(0.5)  -- Intervalo de tempo entre os cliques
        UserInputService.InputBegan:Fire({
            UserInputType = Enum.UserInputType.MouseButton1,
            Position = Vector2.new(math.random(0, 1920), math.random(0, 1080)),  -- Posição aleatória na tela
            UserInputState = Enum.UserInputState.Begin
        })
        print("Clicando na tela...")
    end
end)

-- Tornando o botão de abrir o menu móvel
local dragging = false
local dragInput, dragStart, startPos

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
