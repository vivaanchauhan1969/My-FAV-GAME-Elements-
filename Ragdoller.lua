print("Ragdoll script activated")
Gibs = game.Workspace

function getKillerOfHumanoidIfStillInGame(humanoid)
	local tag = humanoid:findFirstChild("creator")
	if tag ~= nil then
		local killer = tag.Value
		if killer.Parent ~= nil then
			return killer
		end
	end
	return nil
end

function OnDeath(Character)
	local svch = Character
	local hum = Character:findFirstChild("Humanoid")
	local getkiller = getKillerOfHumanoidIfStillInGame(hum)
	Character.Archivable = true
	local chrclone = Character:clone()
	Character.Archivable = false

	local ch = chrclone:GetChildren()
	local i
	for i = 1,#ch do
		if ch[i].Name == "THandle1" or ch[i].Name == "THandle2" or ch[i].ClassName == "Script" then
			ch[i]:remove()
		end
	end
	local function Scan(ch)
		local e
		for e = 1,#ch do
			Scan(ch[e]:GetChildren())
			if ch[e].ClassName == "Weld" or ch[e].ClassName == "Motor6D" then
				ch[e]:remove()
			end
		end
	end
	Scan(chrclone:GetChildren())
	local hum2 = chrclone:findFirstChild("Humanoid")


	if hum2 ~= nil then
		hum2.Name = "Humanoid2"
		hum2.PlatformStand = true
		hum2.Sit = true 
		hum2.MaxHealth = 0
		hum2.Health = 0
	end

	local ch = Character:GetChildren()
	local i
	for i = 1,#ch do
		if ch[i].Name == "THandle1" or ch[i].Name == "THandle2" then
			ch[i]:remove()
		end
	end

	wait(0.2)

	local ch = Character:GetChildren()
	local i
	for i = 1,#ch do
		if ch[i].ClassName == "Part" or ch[i].ClassName == "Hat" or ch[i].Name == "THandle1" or ch[i].Name == "THandle2" then
			ch[i]:remove()
		end
	end
	Character = chrclone
	local Torso = Character.Torso
	local movevector = Vector3.new()

	if Torso then
		if getkiller ~= nil then
			if getkiller.Character ~= nil then
				local killtors = getkiller.Character:findFirstChild("Torso")
				if killtors ~= nil then
					movevector = CFrame.new(killtors.Position,Torso.Position).lookVector
				end
			end
		end
		local Head = Character:FindFirstChild("Head")
		if Head then
			local Neck = Instance.new("Weld")
			Neck.Name = "Neck"
			Neck.Part0 = Torso
			Neck.Part1 = Head
			Neck.C0 = CFrame.new(0, 1.5, 0)
			Neck.C1 = CFrame.new()
			Neck.Parent = Torso

			local nsc = script.CamAttach:clone()
			nsc.CamPart.Value = hum2.Parent.Head
			nsc.Disabled = false
			nsc.Parent = svch
		end
		local Limb = Character:FindFirstChild("Right Arm")
