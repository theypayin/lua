local Players = game:GetService'Players'

function PlayerAdded(Player)
   if Player == Players.LocalPlayer then return end

   local Connection, Warned
   local function CharacterAdded(Character)
       if Connection then Connection:Disconnect() end
       Warned = false
       Connection = Character.DescendantRemoving:Connect(function(w)
           if w:isA'Motor6D' and w.Part0.Parent == Character and w.Part1.Parent == Character and Character:FindFirstChildWhichIsA("WrapLayer", true) then
               Player:ClearCharacterAppearance()
               if not Warned then
                   warn(Player, "tried to crash and FAILED!")
                   Warned = true
               end
           end
       end)
   end
   if Player.Character then task.spawn(CharacterAdded, Player.Character) end

   Player.CharacterAdded:Connect(CharacterAdded)
end

for _, Player in pairs(Players:GetPlayers()) do
   task.spawn(PlayerAdded, Player)
end

Players.PlayerAdded:Connect(PlayerAdded)