local Auto_Farm_Bone = true
local AutoQuest = true
local Selected_Weapons = "" -- เปลี่ยนเป็นชื่ออาวุธของคุณ
local Fast_Attack = true
local Distance_Auto_Farm = 15 -- ตั้งค่าระยะทางสำหรับ Auto Farm

-- ฟังก์ชันสำหรับเริ่มการค้นหาเควสต์หรือการต่อสู้
local function handleQuestAndCombat()
    local GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
    local GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest

    if not string.find(GetQuestTitle.Text, "Living Zombie") and AutoQuest == true then
        _F("AbandonQuest") -- แทนที่ด้วยฟังก์ชันเฉพาะเกมของคุณ
    end

    if GetQuest.Visible == false and AutoQuest == true then
        local CFrameQuest = CFrame.new(-9482, 142, 5567)
        Questtween = toTarget(CFrameQuest)
        -- คำสั่งสำหรับเริ่มเควสต์
    elseif GetQuest.Visible == true or AutoQuest == false then
        -- จัดการกับศัตรูต่างๆ
        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            local enemyName = enemy.Name
            if enemyName == "Reborn Skeleton [Lv. 1975]" or enemyName == "Living Zombie [Lv. 2000]" or 
               enemyName == "Demonic Soul [Lv. 2025]" or enemyName == "Posessed Mummy [Lv. 2050]" then

                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    -- คำสั่งสำหรับการต่อสู้กับศัตรู
                    if (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
                        Farmtween = toTarget(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10))
                    elseif (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 150 then
                        if Farmtween then Farmtween:Stop() end
                        StartMagnet = true
                        NeedAttacking = true
                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                        end
                        if not game.Players.LocalPlayer.Character:FindFirstChild(Selected_Weapons) then
                            wait()
                            EquipWeapon(Selected_Weapons)
                        end
                        PosMon = enemy.HumanoidRootPart.CFrame
                        if not Fast_Attack then
                            game:GetService'VirtualUser':CaptureController()
                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                        end
                        toTarget(enemy.HumanoidRootPart.CFrame * CFrame.new(0,Distance_Auto_Farm,1))
                    end
                end
            end
        end
    else
        toTarget(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
    end
end

-- สร้าง task สำหรับการเรียกใช้งาน
task.spawn(function()
    while task.wait() do
        if Auto_Farm_Bone then
            pcall(handleQuestAndCombat)
        else
            break -- หยุดลูปหากไม่ใช้ Auto Farm
        end
    end
end)

local function moveToTarget(targetCFrame)
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    local humanoid = player.Character:WaitForChild("Humanoid")

    local speed = 22500 -- ความเร็วที่ต้องการ
    local timeInterval = 0.001 -- ช่วงเวลาสำหรับแต่ละการอัปเดต

    while humanoidRootPart and humanoid.Health > 0 and (humanoidRootPart.Position - targetCFrame.Position).Magnitude > 75 do
        local direction = (targetCFrame.Position - humanoidRootPart.Position).Unit
        local newPosition = humanoidRootPart.Position + direction * speed * timeInterval

        humanoidRootPart.CFrame = CFrame.new(newPosition, targetCFrame.Position)
        humanoid:ChangeState(11) -- อาจต้องปรับให้เหมาะสมกับเกมของคุณ

        wait(timeInterval)
    end

    if (humanoidRootPart.Position - targetCFrame.Position).Magnitude <= 100 then
        humanoidRootPart.CFrame = targetCFrame
    end
end

toTarget = LPH_JIT_MAX(function(...)
    local target = ...
    local RealTarget = target

    if typeof(target) == "Vector3" then
        RealTarget = CFrame.new(target)
    elseif typeof(target) == "userdata" and target:IsA("BasePart") then
        RealTarget = target.CFrame
    elseif typeof(target) == "table" and target.x and target.y and target.z then
        RealTarget = CFrame.new(target.x, target.y, target.z)
    end

    moveToTarget(RealTarget)

    local tweenfunc = {}
    function tweenfunc:Stop()
        -- ฟังก์ชันหยุดการเคลื่อนที่ หากจำเป็น
    end

    return tweenfunc
end)
