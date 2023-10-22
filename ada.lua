local Player = game:GetService("Players").LocalPlayer
local Humanoid = Player.Character.Humanoid

local Blackout = workspace.Events.Blackout
local Power = workspace.Events.PowerOutage

local Touch
local TouchDis = 0

for _, v in workspace.Scripted.TransformBrick:GetChildren() do
	if v.Name == "SlimeHound" then
		local Dis = Player:DistanceFromCharacter(v.Position)
		if Dis > TouchDis then
			TouchDis = Dis
			Touch = v
		end
	end
end

function notify(text)
	game.StarterGui:SetCore("SendNotification", {
		Title = "Kaiju Paradise GUI";
		Text = text;
		Duration = 5;
    })
end

if Blackout.Value == true or Power.Value == true then
	notify("Blackout or Power Outage is ON!")
	--break
end

Player.Character.HumanoidRootPart.CFrame = Touch.CFrame

task.wait(.1)
repeat
	firetouchinterest(Player.Character.HumanoidRootPart, Touch, 0)
	firetouchinterest(Player.Character.HumanoidRootPart, Touch, 1)
	task.wait()
until Humanoid.WalkSpeed == 0

task.wait(.1)
repeat wait() until Humanoid.WalkSpeed ~= 0

local Part = Player.Character:FindFirstChild("Head")
if Part.BrickColor == BrickColor.new("Bright yellow") or Part:FindFirstChild("ShinyParticle") then
	notify("Congrats!")
	--break
else
	Player.Character.Humanoid.Health = 0
	Player.CharacterAdded:Wait()
end
notify("Done!")