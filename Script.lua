-- AutoClick e AutoJump para Mobile
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Função de AutoJump
local function autoJump()
    while true do
        wait(0.1) -- Intervalo para o pulo não ficar tão rápido
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        humanoid:Move(Vector3.new(0, 50, 0)) -- Faz o personagem pular
    end
end

-- Função de AutoClick
local function autoClick()
    while true do
        wait(0.1) -- Intervalo de tempo entre os cliques
        local mouse = player:GetMouse()
        mouse1click = Instance.new("RemoteEvent") -- Fazendo um clique do mouse
        mouse1click:FireServer()
    end
end

-- Executando as funções
autoJump()
autoClick()
