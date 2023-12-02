local function callback(Text)
end
 
local NotificationBindable = Instance.new("BindableFunction")
NotificationBindable.OnInvoke = callback
 
game.StarterGui:SetCore("SendNotification", {
    Title = "Luxury hub";
    Text = "Kaitan Mode Load";
    Duration = "10";
    Callback = NotificationBindable;
})
spawn(function()
    while wait(1) do
		pcall(function()
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
				else
					wait(3)
				end
		end)
    end
end)
if _G.Auto_Farm then -- true / false

function totarget(p)
    local Distance2 = (p.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local tween_s = game:service"TweenService"
    local info = TweenInfo.new(Distance2/385, Enum.EasingStyle.Linear)
    local tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = p})
    tween:Play()
    if Distance2 <= 75 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
    end
end

function checklevel()
    local lv = game:GetService("Players").LocalPlayer.Data.Level.Value
    if lv == 1 or lv <= 9 then
        Mon = "Bandit [Lv. 5]"
        Title = "Bandit"
        QuestName = "BanditQuest1"
        QuestNumber = 1
        CFrameQuest = CFrame.new(1061.15271, 16.7367725, 1548.93018, -0.836085379, -3.89774577e-08, 0.548599303, -1.17575967e-08, 1, 5.31300408e-08, -0.548599303, 3.79710414e-08, -0.836085379)
        CFrameMon = CFrame.new(1151.11829, 16.7761021, 1599.73499, -0.999999762, 0, -0.000701809535, 0, 1, 0, 0.000701809535, 0, -0.999999762)
        CFramePuk = CFrame.new(1101.75903, 67.6758957, 1617.50391, -0.399259984, -5.24373327e-08, -0.916837752, -1.74068084e-08, 1, -4.96134582e-08, 0.916837752, -3.84945009e-09, -0.399259984)
    elseif lv == 10 or lv <= 14 then
        Mon = "Monkey [Lv. 14]"
        Title = "Monkey"
        QuestName = "JungleQuest"
        QuestNumber = 1
        CFrameQuest = CFrame.new(-1599.23096, 37.8653831, 153.335953, -0.0493941903, 1.29583286e-08, 0.998779356, 3.21716165e-08, 1, -1.13831318e-08, -0.998779356, 3.15700852e-08, -0.0493941903)
        CFrameMon = CFrame.new(-1479.76099, 23.195364, 106.327942, 0.96289885, 5.22265786e-10, -0.269862473, 6.59528099e-10, 1, 4.28857172e-09, 0.269862473, -4.30744285e-09, 0.96289885)
        CFramePuk = CFrame.new(-1776.32959, 61.1782455, 66.8902054, -0.912609756, -2.38546143e-08, 0.408831745, -2.14773621e-08, 1, 1.04056577e-08, -0.408831745, 7.15677129e-10, -0.912609756)
        elseif lv == 15 or lv <= 29 then
        Mon = "Gorilla [Lv. 20]"
        Title = "Gorilla"
        QuestName = "JungleQuest"
        QuestNumber = 2
        CFrameQuest = CFrame.new(-1599.23096, 37.8653831, 153.335953, -0.0493941903, 1.29583286e-08, 0.998779356, 3.21716165e-08, 1, -1.13831318e-08, -0.998779356, 3.15700852e-08, -0.0493941903)
        CFrameMon = CFrame.new(-1242.46655, 6.62262297, -523.166382, -0.974416733, 9.23166681e-08, -0.224748924, 9.58993027e-08, 1, -5.02435071e-09, 0.224748924, -2.64490758e-08, -0.974416733)
        CFramePuk = CFrame.new(-1133.4574, 40.8067436, -526.086792, 0.647179008, -2.76535794e-10, 0.762338042, 3.26674865e-08, 1, -2.73699801e-08, -0.762338042, 4.26169464e-08, 0.647179008)
    elseif lv == 30 or lv <= 39 then
        Mon = "Pirate [Lv. 35]"
        Title = "Pirate"
        QuestName = "BuggyQuest1"
        QuestNumber = 1
        CFrameQuest = CFrame.new(-1138, 5, 3832)
        CFrameMon = CFrame.new(-1138, 5, 3832)
        CFramePuk = CFrame.new(-1151, 44, 3874)
    elseif lv == 40 or lv <= 59 then
        Mon = "Brute [Lv. 45]"
        Title = "Brute"
        QuestName = "BuggyQuest1"
        QuestNumber = 2
        CFrameQuest = CFrame.new(-1138, 5, 3832)
        CFrameMon = CFrame.new(-1126, 22, 4321)
        CFramePuk = CFrame.new(-1134, 99, 4314)
    elseif lv == 60 or lv <= 74 then
        Mon = "Desert Bandit [Lv. 60]"
        Title = "Desert Bandit"
        QuestName = "DesertQuest"
        QuestNumber = 1
        CFrameQuest = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
        CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
        CFramePuk = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
    elseif lv == 75 or lv <= 89 then
        Mon = "Desert Officer [Lv. 70]"
        Title = "Desert Officer"
        QuestName = "DesertQuest"
        QuestNumber = 2
        CFrameQuest = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
        CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
        CFramePuk = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
    elseif lv == 90 or lv <= 99 then
        Mon = "Snow Bandit [Lv. 90]"
        Title = "Snow Bandit"
        QuestName = "SnowQuest"
        QuestNumber = 1
        CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
        CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
        CFramePuk = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
    elseif lv == 100 or lv <= 129 then
        Mon = "Snowman [Lv. 100]"
        Title = "Snowman"
        QuestName = "SnowQuest"
        QuestNumber = 2
        CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
        CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
        CFramePuk = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)

    end
end

spawn(function()
    while task.wait(.1) do
        pcall(function()
            if _G.Auto_Farm then
            checklevel()
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
totarget(CFrameQuest)
wait(.3)
local args = {
    [1] = "StartQuest",
    [2] = QuestName,
    [3] = QuestNumber
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == Mon and v2.Name == Mon then
            totarget(v.HumanoidRootPart.CFrame * CFrame.new(0,1,15))
            v.HumanoidRootPart.Size = Vector3.new(60,2.5,60)
            v.HumanoidRootPart.CFrame = CFrameMon
            game:GetService'VirtualUser':CaptureController()
            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
            v2.HumanoidRootPart.CanCollide = false
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
        end
        end
    end
                end
            end
        end)
    end
end)

spawn(function()
    while task.wait(.1) do
        pcall(function()
            if _G.Auto_Farm then
            checklevel()
    if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, Title) then
local args = {
    [1] = "AbandonQuest"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
            end
        end)
    end
end)

spawn(function()
    while task.wait(.1) do
        pcall(function()
            if _G.Auto_Farm then
            checklevel()
            if not game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                totarget(CFramePuk)
            end
            end
        end)
    end
end)

spawn(function()
    while task.wait(.1) do
        pcall(function()
            if _G.Auto_Farm then
            checklevel()
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == Mon then
            if v.Humanoid.Health == 0 then
            v:Destroy()
            end
            end
            end
            end
        end)
    end
end)
-- Function to rename enemies and replicated storage objects
local function renameObjectsInFolder(folder)
    for _, v in pairs(folder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name ~= v:FindFirstChild("Humanoid").DisplayName then
            v.Name = v:FindFirstChild("Humanoid").DisplayName
        end
    end
end

-- Main function using task.spawn
task.spawn(function()
    while task.wait() do
        pcall(function()
            renameObjectsInFolder(game.Workspace.Enemies)
            renameObjectsInFolder(game:GetService("ReplicatedStorage"))
        end)
    end
end)
end
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
    local AttackCD = 0.11
    local Controller
    local lastFireValid = 0
    local MaxLag = 950
    fucker = 0.07
    TryLag = 0

    local resetCD = function()
        local WeaponName = Controller.currentWeaponModel.Name
        local Cooldown = {
            combat = 0.01
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
                        Controller.hitboxMagnitude = 80
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
        v.Value = 0.01
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
_G.Melee = true;
while _G.Melee do wait()
local args = {
    [1] = "AddPoint",
    [2] = "Melee",
    [3] = 1

}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
end
_G.Melee1 = true;
while _G.Melee1 do wait()
local args = {
    [1] = "AddPoint",
    [2] = "Melee",
    [3] = 3
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
end


while true do wait(0)
function UseCode(Text)
    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
end
UseCode("Sub2Fer999")
UseCode("Enyu_is_Pro")
UseCode("Magicbus")
UseCode("JCWK")
UseCode("Starcodeheo")
UseCode("Bluxxy")
UseCode("THEGREATACE")
UseCode("SUB2GAMERROBOT_EXP1")
UseCode("StrawHatMaine")
UseCode("Sub2OfficialNoobie")
UseCode("SUB2NOOBMASTER123")
UseCode("Sub2Daigrock")
UseCode("Axiore")
UseCode("TantaiGaming")
UseCode("STRAWHATMAINE")
end


local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("DrRay", "Default")

local tab = DrRayLibrary.newTab("My Tab", "ImageIdHere")
tab.newToggle("Auto Farm [ออโต้]", "Toggle! (prints the state)", false, function(value)
 _G.Auto_Farm = value
end)
