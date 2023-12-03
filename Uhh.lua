-- Use Function
NeedAttacking = true 

getgenv().Settings = {
    NoAttackAnimation = true,
    NewFastAttack = true,
    FastAttack = true,
    DamageAura = true,
}

local kkii = require(game.ReplicatedStorage.Util.CameraShaker)
kkii:Stop()

Utilities = {
    Priority = isfile("File/LocalPriority") and base64.dec(readfile("File/LocalPriority")) or game:HttpGet('https://raw.githubusercontent.com/xZcAtliftz/Api/main/Priority.lua'),
    Network = isfile("File/LocalNetwork") and base64.dec(readfile("File/LocalNetwork")) or game:HttpGet('https://raw.githubusercontent.com/xZcAtliftz/Api/main/Network.lua'),
}

for i, v in pairs(Utilities) do
    Utilities[i] = loadstring(v)()
end

Players = game.Players

local Root = game.Players.LocalPlayer.Character.HumanoidRootPart

do
    -- Instance
    Locations = workspace._WorldOrigin.Locations
    CurrentAllMob = {}
    recentlySpawn = 0
    canHits = {}

    -- Services
    CollectionService = game:GetService("CollectionService")

    -- Module Requiring
    Util = require(game:GetService("ReplicatedStorage").Util)
    -- CameraShaker = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker.CameraShakeInstance)
    PC = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle)
    RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
    DMG = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle.Damage)
    RigC = getupvalue(require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.RigController), 2)
    Combat = getupvalue(require(game.Players.LocalPlayer.PlayerScripts.CombatFramework), 2)
end

dist = function(a, b, noHeight)
    if not b then
        b = Root.Position
    end
    return (Vector3.new(a.X, not noHeight and a.Y, a.Z) - Vector3.new(b.X, not noHeight and b.Y, b.Z)).magnitude
end

task.spawn(function()
    local stacking = 0
    local printCooldown = 0
    local OldPriority = Priority.Recently
    while wait(.075) do
        -- Attackable NPC Finder
        nearbymon = false
        table.clear(CurrentAllMob)
        table.clear(canHits)
        local mobs = CollectionService:GetTagged("ActiveRig")
        for i = 1, #mobs do
            local v = mobs[i]
            local Human = v:FindFirstChildOfClass("Humanoid")
            if Human and Human.Health > 0 and Human.RootPart and v ~= Char then
                local IsPlayer = game.Players:GetPlayerFromCharacter(v)
                local IsAlly = IsPlayer and CollectionService:HasTag(IsPlayer, "Ally" .. game.Players.LocalPlayer.Name)
                if not IsAlly then
                    CurrentAllMob[#CurrentAllMob + 1] = v
                    if not nearbymon and dist(Human.RootPart.Position) < 65 then
                        nearbymon = true
                    end
                end
            end
        end

        if nearbymon then
            local Enemies = workspace.Enemies:GetChildren()
            local Players = Players:GetPlayers()
            for i = 1, #Enemies do
                local v = Enemies[i]
                local Human = v:FindFirstChildOfClass("Humanoid")
                if Human and Human.RootPart and Human.Health > 0 and dist(Human.RootPart.Position) < 65 then
                    canHits[#canHits + 1] = Human.RootPart
                end
            end
            for i = 1, #Players do
                local v = Players[i].Character
                if not Players[i]:GetAttribute("PvpDisabled") and v and v ~= game.Players.LocalPlayer.Character then
                    local Human = v:FindFirstChildOfClass("Humanoid")
                    if Human and Human.RootPart and Human.Health > 0 and dist(Human.RootPart.Position) < 65 then
                        canHits[#canHits + 1] = Human.RootPart
                    end
                end
            end
        end

        -- Priority Debugging
        if OldPriority ~= Priority.Recently then
            OldPriority = Priority.Recently
            stacking = tick()
        end
        if tick() - stacking > 60 and OldPriority and OldPriority.Class == Priority.Class then
            Priority:clear()
        elseif tick() - printCooldown > 5 then
            printCooldown = tick()
        end
    end
end)

getHits = function(Size)
    local Hits = {}
    if nearbymon then
        local Enemies = workspace.Enemies:GetChildren()
        local Characters = workspace.Characters:GetChildren()
        for i = 1, #Enemies do
            local v = Enemies[i]
            local Human = v:FindFirstChildOfClass("Humanoid")
            if Human and Human.RootPart and Human.Health > 0 and dist(Human.RootPart.Position) < Size + 5 then
                table.insert(Hits, Human.RootPart)
            end
        end
        for i = 1, #Characters do
            local v = Characters[i]
            if v ~= game.Players.LocalPlayer.Character then
                local Human = v:FindFirstChildOfClass("Humanoid")
                if Human and Human.RootPart and Human.Health > 0 and dist(Human.RootPart.Position) < Size + 5 then
                    table.insert(Hits, Human.RootPart)
                end
            end
        end
    end
    return Hits
end

-- Initialize Fast Attack.
task.spawn(function()
    local Data = Combat
    local Blank = function()
    end
    local RigEvent = game:GetService("ReplicatedStorage").RigControllerEvent
    local Animation = Instance.new("Animation")
    local RecentlyFired = 0
    local AttackCD = 0
    local Controller
    local lastFireValid = 0
    local MaxLag = 920
    fucker = 0.07
    TryLag = 0

    local resetCD = function()
        local WeaponName = Controller.currentWeaponModel.Name
        local Cooldown = {
            combat = 0.07
        }
        AttackCD = tick() + (fucker and Cooldown[WeaponName:lower()] or fucker or 0.285) + ((TryLag / MaxLag) * 0.3)
        RigEvent.FireServer(RigEvent, "weaponChange", WeaponName)
        TryLag += 1
        task.delay((fucker or 0.285) + (TryLag + 0.5 / MaxLag) * 0.3, function()
            TryLag -= 1
        end)
    end

    if not shared.orl then
        shared.orl = RL.wrapAttackAnimationAsync
    end
    if not shared.cpc then
        shared.cpc = PC.play
    end
    if not shared.dnew then
        shared.dnew = DMG.new
    end
    if not shared.attack then
        shared.attack = RigC.attack
    end

    RL.wrapAttackAnimationAsync = function(a, b, c, d, func)
        if not getgenv().Settings.NoAttackAnimation and not NeedAttacking then
            PC.play = shared.cpc
            return shared.orl(a, b, c, 65, func)
        end
        local Radius = (getgenv().Settings.DamageAura and getgenv().Settings.DamageAuraRadius) or 65
        if canHits and #canHits > 0 then
            PC.play = function()
            end
            a:Play(0.00075, 0.01, 0.01)
            func(canHits)
            wait(a.length * 0.5)
            a:Stop()
        end
    end

    while game:GetService("RunService").Stepped:Wait() do
        if #canHits > 0 then
            Controller = Data.activeController
            if NormalClick then
                pcall(task.spawn, Controller.attack, Controller)
                continue
            end
            if Controller and Controller.equipped and (not game.Players.LocalPlayer.Character.Busy.Value or game.Players.LocalPlayer.PlayerGui.Main.Dialogue.Visible) and game.Players.LocalPlayer.Character.Stun.Value < 1 and Controller.currentWeaponModel then
                if (NeedAttacking or getgenv().Settings.DamageAura) then
                    if getgenv().Settings.NewFastAttack and tick() > AttackCD and not NeedAttacking then
                        resetCD()
                    end
                    if tick() - lastFireValid > 0.5 or not getgenv().Settings.FastAttack then
                        Controller.timeToNextAttack = 0
                        Controller.hitboxMagnitude = 65
                        pcall(task.spawn, Controller.attack, Controller)
                        lastFireValid = tick()
                        continue
                    end
                    local AID3 = Controller.anims.basic[3]
                    local AID2 = Controller.anims.basic[2]
                    local ID = AID3 or AID2
                    Animation.AnimationId = ID
                    local Playing = Controller.humanoid:LoadAnimation(Animation)
                    Playing:Play(0.00075, 0.01, 0.01)
                    RigEvent.FireServer(RigEvent, "hit", canHits, AID3 and 3 or 2, "")
                    delay(.5, function()
                        Playing:Stop()
                    end)
                end
            end
        end
    end
end)

NoStun = true

function DestroyBusy(v)
    if v.Name:find("Body") and not v:IsA("BodyVelocity") and not v:IsA("BodyGyro") and NoStun then
        game.Debris:AddItem(v, 0)
    end
    if v.Name == "KenDisabled" then
        wait()
        game.Debris:AddItem(v, 0)
    end
    if v.Name == "GeppoCount" then
        wait()
        game.Debris:AddItem(v, 0)
    end
    if v.Name == "Cooldown" and gun_cd_obj ~= v then
        gun_cd_obj = v
        v.Value = 0.15
    end
end

local Char = game.Players.LocalPlayer.Character

function OnChar(Char)
    Root = Char:WaitForChild("HumanoidRootPart")
    Char:WaitForChild("Busy").Changed:Connect(function()
        if NoStun and game.Players.LocalPlayer.Character.Busy.Value then
            game.Players.LocalPlayer.Character.Busy.Value = false
        end
    end)
    Char:WaitForChild("Humanoid").HealthChanged:Connect(function()
        if NoBountyLoss then
            local MaxHealth = game.Players.LocalPlayer.Character.Humanoid.MaxHealth
            local OldChar = Char
            if game.Players.LocalPlayer.Character.Humanoid.Health > 0 and game.Players.LocalPlayer.Character.Humanoid.Health <= MaxHealth * (NoBountyLossHealth / 100) then
                if OldChar == Char then
                    if not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", game.Players.LocalPlayer.Team.Name) then
                        game.Players.LocalPlayer.Character.Head:Destroy()
                    end
                end
            end
        end
    end)
end

OnChar(Char)
Char.DescendantAdded:Connect(DestroyBusy)
Char.ChildAdded:Connect(DestroyBusy)
game.Players.LocalPlayer.CharacterAdded:Connect(function(Chr)
    Char = Chr
    recentlySpawn = tick()
    Chr.DescendantAdded:Connect(DestroyBusy)
    Chr.ChildAdded:Connect(DestroyBusy)
    OnChar(Chr)
end)
