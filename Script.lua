local player = game.Players.LocalPlayer
local Chat = game:GetService("Chat")

for i = 1, 3 do
    -- Envia a mensagem no chat global, como se fosse um jogador
    Chat:Chat(player.Character, "Olá a todos", Enum.ChatColor.Blue)
    wait(1) -- Aguarda 1 segundo entre as mensagens
end

