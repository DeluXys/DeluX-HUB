-- Script para enviar "Olá a todos" 3 vezes no chat

local player = game.Players.LocalPlayer
local Chat = game:GetService("Chat")

for i = 1, 3 do
    -- Enviar a mensagem para o chat
    Chat:Chat(player.Character.Head, "Olá a todos", Enum.ChatColor.Blue)
    wait(1)  -- Aguardar 1 segundo entre cada mensagem
end
