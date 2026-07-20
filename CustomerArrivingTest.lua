--tes customer arriving 10seconds after spawn to target location and stay still at target
local npc = script.Parent
local humanoid = npc:WaitForChild("Humanoid")
local target = game.Workspace:WaitForChild("NPC kasir")
task.wait(10)
humanoid:MoveTo(target.Position)
humanoid.MoveToFinished:Connect(function(reached)
	if reached then
		print("NPC telah sampai di tujuan.")
	else
		print("NPC gagal mencapai tujuan.")
	end
end)
