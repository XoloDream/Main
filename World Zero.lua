repeat wait(1) until game:IsLoaded()
repeat wait(1) until game.Players:FindFirstChild(game.Players.LocalPlayer.Name)

local Queue = syn and syn.queue_on_teleport or ScriptWare and queue_on_teleport
Queue("loadstring(game:HttpGet('https://raw.githubusercontent.com/XoloDream/Main/main/World%20Zero.lua'))()")

local UserIDs = {
    219, -- SkyePercival
    221, -- Tsuki
    1104, -- YaFemboiSkye
    305882, -- ZaVVaDa
    105904554, -- Xolo

    117630695, --Sai
    49109897,

    2644838750, --swiftyash
    2561152787, --roseshade
    2954211710, --
    2936228885, --TNSASHKO
    
    1565363247, --ItzYourFavoriteWhiteBoy

    10057146 --Citrum
}
if not table.find(UserIDs, game.Players.LocalPlayer.UserId) then
    while true do
        messagebox("Youre not allowed", "Astro's Whitelist System", 16)
        game.Players.LocalPlayer:Kick("Fuck off kid. Youre not allowed")
    end
else
    --Starter
    repeat task.wait() until game:IsLoaded()
    repeat task.wait() until game.Players:FindFirstChild(game.Players.LocalPlayer.Name)
    
    local Version = "1.3c"
    local Name = 'WorldZero (UID_'..game.Players.LocalPlayer.UserId..').json'
    local DefaultSettings = {
        FarmDailyQuest = false,
        FarmWorldQuest = false,
        RestartDungeon = false,
        RejoinDelay = 60,
        StartFarm = false,
        AutoSell = false,
        KillAura = false,
        NoBusy = true,
        PickUp = true,
        AutoEquip = false,
        SellCommon = true,
        SellUncommon = true,
        SellRare = true,
        SellEpic = true,
        SellEgg = true,
        IdDungeon = 1,
        IdDifficulty = 1,
        NameDungeon = 'Crabby Crusade',
        NameDifficulty = 'Normal',
        NextDungeonDelay = 2,
        SprintSpeed = 30,
        PlayerESP = false,
    }
    
    if not pcall(function() readfile(Name) end) then 
        writefile(Name, game:GetService('HttpService'):JSONEncode(DefaultSettings)) 
    end
    
    local Settings = game:GetService('HttpService'):JSONDecode(readfile(Name))
    
    function Save() 
        writefile(Name,game:GetService('HttpService'):JSONEncode(Settings)) 
    end
    
    game.CoreGui.RobloxPromptGui.promptOverlay.DescendantAdded:Connect(function()
        local GUI = game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild('ErrorPrompt')
        if GUI then
            local Reason = GUI.TitleFrame.ErrorTitle.Text
            if Reason == 'Disconnected' or Reason:find('Server Kick') or Reason:find('GameEnded') then
                game:GetService('TeleportService'):Teleport(2727067538)
                
                spawn(function()
                    while task.wait(5) do
                        game:GetService('TeleportService'):Teleport(2727067538)
                    end
                end)
            end
        end
    end)

    if game.PlaceId == 2727067538 then
        if Settings.StartFarm then
            repeat task.wait() until game.ReplicatedStorage.ProfileCollections:FindFirstChild(game.Players.LocalPlayer.Name)
            for i,v in next, game.ReplicatedStorage.ProfileCollections[game.Players.LocalPlayer.Name].Profiles:GetChildren() do
                if v:FindFirstChild('Selected') and v:FindFirstChild('GUID') and v.Selected.Value == true then
                    game.ReplicatedStorage.Shared.Teleport.JoinGame:FireServer(v.GUID.Value)
                end
            end
        end
    else
        repeat task.wait(1) until game.Players.LocalPlayer.Character
        repeat task.wait(1) until game.Players.LocalPlayer.Character:FindFirstChild('Collider')
    
        --Create UI
        local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/XoloDream/Main/main/Materials/UILib/UISource/PepsiLib.lua', true))()
        local Window = Lib:CreateWindow({
            Name = 'Astro Projekts - World Zero [v'..Version..']',
            Themeable = {
                --Image = 'rbxassetid://7483871523',
                Credit = false,
            }
        })
    
        local MainTab = Window:CreateTab({Name = 'Main Tab'})
        local MiscTab = Window:CreateTab({Name = 'Misc Tab'})
        local Sections = {
            ActionSettings = MainTab:CreateSection({Name = 'Action'}),
            AutofarmSettings = MainTab:CreateSection({Name = 'Farm Settings'}),
            FeaturesSettings = MainTab:CreateSection({Name = 'Feature'}),
            AutoSellSettings = MainTab:CreateSection({Name = 'Auto Sell', Side = "Right"}),
            MiscMenu = MainTab:CreateSection({Name = 'Misc', Side = "Right"}),
            MiscPet = MainTab:CreateSection({Name = 'Pet', Side = "Right"}),
            MiscDye = MainTab:CreateSection({Name = 'Dye', Side = "Right"}),

            MiscEvent = MiscTab:CreateSection({Name = 'Event', Side = "Right"}),
            MiscSettings = MiscTab:CreateSection({Name = 'Cooldowns'}),
        }
    
        local Client = game.Players.LocalPlayer
        Client.CameraMaxZoomDistance = 1000
    
        local Character = Client.Character or Client.Character:Wait()
        local ClientRoot = Character:WaitForChild('HumanoidRootPart')
        Client.CharacterAdded:Connect(function(Character)
            ClientRoot = Character:WaitForChild('HumanoidRootPart')
        end)
        
        local ClientProfile = game.ReplicatedStorage.Profiles:WaitForChild(Client.Name)
        local ClientLevel = ClientProfile:WaitForChild('Level') and ClientProfile.Level.Value
        local ClientClass = ClientProfile:WaitForChild('Class') and ClientProfile.Class.Value
        local InDungeon = require(game.ReplicatedStorage.Shared.Missions):IsMissionPlace()
    
        workspace.ChildAdded:Connect(function(v)
            if v:IsA('Part') and v.Name:find('Damage') then
                task.wait()
                v:Destroy()
            end
        end)
    
        local bossPos do
            if workspace:FindFirstChild('Mobs') then
                workspace.Mobs.ChildAdded:Connect(function(boss)
                    if game.PlaceId ~= 4050468028 and game.PlaceId ~= 4646473427 and not boss.Name:find('#') and require(game.ReplicatedStorage.Shared.Mobs.Mobs[boss.Name]).BossTag ~= false and boss:FindFirstChild('Collider') then
                        bossPos = boss.Collider.Position.Y
                    end
                end)
            end
        end
    
        spawn(function()
            while workspace:FindFirstChild('Mobs') and task.wait() do
                for i,v in next, workspace.Mobs:GetChildren() do
                    if v:FindFirstChild('HealthProperties') and v.HealthProperties.Health.Value <= 0 then
                        v:Destroy()
                    end
                end
            end
        end)
    
        --Semi-god
        local dangerTable = {} do
            for i,v in next, game.ReplicatedStorage.Shared.Mobs.Mobs:GetDescendants() do
                if v:IsA('RemoteEvent') then
                    table.insert(dangerTable, v)
                end
            end
        end
    
        local old_namecall
        old_namecall = hookmetamethod(game, '__namecall', function(self, ...)
            if getnamecallmethod() == 'FireServer' and table.find(dangerTable, self) then
                return
            end
            return old_namecall(self, ...)
        end)
    
        --Anti afk
        for i,v in next, getconnections(Client.Idled) do
            v:Disable()
        end
    
        function GetActiveMission()
            local Table = {}
            for i,v in next, require(game.ReplicatedStorage.Shared.Missions.MissionData) do
                if v.ShowOnProduction and v.ShowOnProduction == true then
                    if v.ID == 17 then
                        local ChildTable = {
                            ['ID'] = v.ID,
                            ['Name'] = 'Holiday Event'
                        }
                        table.insert(Table, ChildTable)
                    elseif v.ID == 22 then
                        local ChildTable = {
                            ['ID'] = v.ID,
                            ['Name'] = 'Halloween Event'
                        }
                        table.insert(Table, ChildTable)
                    else
                        local ChildTable = {
                            ['ID'] = v.ID,
                            ['Name'] = v.NameTag
                        }
                        table.insert(Table, ChildTable)
                    end
                end
            end
        
            table.sort(Table, function(current,next)
                return current.ID < next.ID
            end)
        
            return Table
        end
    
        function MissionList()
            local stringtable = {}
            for i,v in next, GetActiveMission() do
                table.insert(stringtable, v.Name)
            end
        
            return stringtable
        end

        local function DifficultyList(ID)
            local Diff = {}
            for i,v in next, require(game.ReplicatedStorage.Shared.Missions.MissionData) do
                if v.difficulties and v.ID == ID then
                    for i1,v1 in next, v.difficulties do
                        if v1.id == 1 then
                            Diff[1] = "Normal"
                        elseif v1.id == 2 then
                            Diff[2] = "Hard"
                        elseif v1.id == 3 then
                            Diff[3] = "Challenge"
                        elseif v1.id == 4 then
                            Diff[4] = "MASTER"
                        end
                    end
                end
            end

            return Diff
        end

        --Auto farm
        local CurrentStatus = Sections.ActionSettings:AddLabel({Name = 'Status: Idle'})
        local MiscLabel = Sections.ActionSettings:AddLabel({Name = 'Dungeon Timer: 00:00'})

        Sections.ActionSettings:AddToggle({
            Name = 'Enable Farm',
            Enabled = Settings.StartFarm,
            Callback = function(state)
                Settings.StartFarm = state
                Save()
            
                if not Settings.StartFarm then
                    if ClientRoot:FindFirstChild('BodyVelocity') and not InDungeon then
                        ClientRoot.CFrame = ClientRoot.CFrame + Vector3.new(0,50,0)
                    end
                    if ClientRoot:FindFirstChild('BodyVelocity') then
                        task.wait()
                        ClientRoot.BodyVelocity:Destroy()
                        ClientRoot.CanCollide = true
                    end
                    game.ReplicatedStorage.Remotes.SetSheathed:FireServer(false)
                    CurrentStatus.Set('Status: Idle')
                else
                    game.ReplicatedStorage.Remotes.SetSheathed:FireServer(true)
                
                    if not ClientRoot:FindFirstChild('BodyVelocity') then
                        local bv = Instance.new('BodyVelocity')
                        bv.Parent = ClientRoot
                        bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                        bv.Velocity = Vector3.new(0,0,0)
                    
                        ClientRoot.CanCollide = false
                    
                        if not InDungeon then
                            ClientRoot.CFrame = ClientRoot.CFrame + Vector3.new(0,-30,0)
                        end
                    end
                
                    function QuestFinished(missionID)
                        return require(game.ReplicatedStorage.Shared.Quests):QuestCompleted(game.Players.LocalPlayer, missionID)
                    end
                    
                    function QuestLeft(questType)
                        local count = 0
                        if questType == 'daily' then
                            local DailyQuests = ClientProfile.DailyQuests
                            local Slot1 = DailyQuests.Slot1Quest.Value
                            local Slot2 = DailyQuests.Slot2Quest.Value
                            local Slot3 = DailyQuests.Slot3Quest.Value
                            for i,v in next, require(game.ReplicatedStorage.Shared.Quests.QuestList) do
                                if v.DailyQuest == true and (v.ID == Slot1 or v.ID == Slot2 or v.ID == Slot3) and not QuestFinished(i) then
                                    count += 1
                                end
                            end
                        elseif questType == 'world' then
                            for i,v in next, require(game.ReplicatedStorage.Shared.Quests.QuestList) do
                                if v.WorldQuest == true and not v.Name:find('teleporter') and not QuestFinished(i) then
                                    count += 1
                                end
                            end
                        end
                        return count
                    end
                    
                    function GetDailyQuest()
                        local minWorld = math.huge
                        local data = nil
                        local DailyQuests = ClientProfile.DailyQuests
                        local Slot1 = DailyQuests.Slot1Quest.Value
                        local Slot2 = DailyQuests.Slot2Quest.Value
                        local Slot3 = DailyQuests.Slot3Quest.Value
                        for i,v in next, require(game.ReplicatedStorage.Shared.Quests.QuestList) do
                            if v.DailyQuest == true and (v.ID == Slot1 or v.ID == Slot2 or v.ID == Slot3) and not QuestFinished(i) then
                                if v.LinkedWorld < minWorld then
                                    minWorld = v.LinkedWorld
                                    data = v
                                end
                            end
                        end
                        return data
                    end
                    
                    function GetWorldQuest()
                        local minWorld = math.huge
                        local data = nil
                        for i,v in next, require(game.ReplicatedStorage.Shared.Quests.QuestList) do
                            if v.WorldQuest == true and not v.Name:find('teleporter') and not QuestFinished(i) then
                                if v.LinkedWorld < minWorld then
                                    minWorld = v.LinkedWorld
                                    data = v
                                end
                            end
                        end
                        return data
                    end
                    
                    function FarmLevel()
                        local Level = ClientProfile.Level.Value
                        if Level >= 1 and Level < 4 then
                            return 1 -- Crabby Crusade
                        elseif Level >= 4 and Level < 7 then
                            return 3 -- Scarecrow Defense
                        elseif Level >= 7 and Level < 10 then
                            return 2 -- Dire Problem
                        elseif Level >= 10 and Level < 12 then
                            return 4 -- Kingslayer
                        elseif Level >= 12 and Level < 15 then
                            return 6 -- Gravetower Dungeon
                        elseif Level >= 15 and Level < 18 then
                            return 11 -- Temple of Ruin
                        elseif Level >= 18 and Level < 22 then
                            return 12 -- Mama Trauma
                        elseif Level >= 22 and Level < 26 then
                            return 13 -- Volcano's Shadow
                        elseif Level >= 26 and Level < 30 then
                            return 7 -- Volcano Dungeon
                        elseif Level >= 30 and Level < 35 then
                            return 14 -- Mountain Pass
                        elseif Level >= 35 and Level < 40 then
                            return 15 -- Winter Cavern
                        elseif Level >= 40 and Level < 45 then
                            return 16 -- Winter Dungeon
                        elseif Level >= 45 and Level < 50 then
                            return 20 -- Scarp Canyon
                        elseif Level >= 50 and Level < 55 then
                            return 19 -- Deserted Burrowmine
                        elseif Level >= 55 and Level < 60 then
                            return 18 -- The Pyramid
                        elseif Level >= 60 and Level < 70 then
                            return 21 -- Prison Tower
                        elseif Level >= 70 and Level < 90 then
                            return 23 -- Atlantis Tower
                        elseif Level >= 90 then
                            return 27 -- Mezuvian Tower
                        end
                    end
                
                    function FarmDungeon()
                        function GetMob()
                            local closest, closestDistance = nil, math.huge
                            for i,v in next, workspace.Mobs:GetChildren() do
                                if not v.Name:find('#') and not v:FindFirstChild('NoHealthbar') and v:FindFirstChild('Collider') and v:FindFirstChild('HealthProperties') and v.HealthProperties.Health.Value > 0 then
                                    local currentDistance = (ClientRoot.Position - v.Collider.Position).magnitude
                                    if currentDistance < closestDistance then
                                        closest = v
                                        closestDistance = currentDistance
                                    end
                                end
                            end
                            return closest
                        end
                        
                        function TowerChestMob()
                            if workspace:FindFirstChild('Map') then
                                for i,v in next, workspace.Map:GetDescendants() do
                                    if v:IsA('Part') and v:FindFirstChild('MobName') and v.MobName.Value == 'Tower2ChestMob' then
                                        return v
                                    end
                                end
                            end
                        end 
                    
                        function FloorFinished()
                            if Client.PlayerGui.TowerVisual:FindFirstChild('TowerVisual') and Client.PlayerGui.TowerVisual.TowerVisual.Visible == true and Client.PlayerGui.TowerVisual.TowerVisual.KeyImage.TextLabel.Text:find('/') then
                                local str = (Client.PlayerGui.TowerVisual.TowerVisual.KeyImage.TextLabel.Text):split('/')
                                local current = tonumber(string.match(str[1] , '%d+'))
                                local max = tonumber(string.match(str[2] , '%d+'))
                                if current == max then
                                    return true
                                end
                            end
                        end
                    
                        function AvoidPart(part)
                            local avoidPart = {'teleport','hearttele','a0','e0','s0','reset','push','temple','mushroom','water','lava','damage','fall','slider','part0','kill'}
                            for i,v in next, avoidPart do
                                if part.Name:lower():find(v) then
                                    return true
                                end
                            end
                        end
                    
                        function Trigger()
                            if workspace:FindFirstChild('MissionObjects') then
                                for i,v in next, workspace.MissionObjects:GetDescendants() do
                                    if v.Name == 'Cutscenes' or v.Name == 'WaterKillPart' or v.Name == 'CliffsideFallTriggers' then 
                                        v:Destroy()
                                    end
                                    if v:IsA('Part') and tostring(v.Parent) ~= 'Geyser' and v:FindFirstChild('TouchInterest') and not AvoidPart(v) then
                                        firetouchinterest(ClientRoot, v, 0)
                                        firetouchinterest(ClientRoot, v, 1)
                                        task.wait()
                                    end
                                end
                                
                                for i,v in next, workspace:GetChildren() do
                                    if (v.Name:find('Cage') or v.Name:find('Treasure')) and v:FindFirstChild('Collider') and v.Collider:FindFirstChild('TouchInterest') then
                                        firetouchinterest(ClientRoot, v.Collider, 0)
                                        firetouchinterest(ClientRoot, v.Collider, 1)
                                        task.wait()
                                    end
                                end
                            end
                        
                            if workspace:FindFirstChild('Map') and Client.PlayerGui.TowerVisual:FindFirstChild('TowerVisual') and Client.PlayerGui.TowerVisual.TowerVisual.Visible == true then
                                if FloorFinished() and workspace:FindFirstChild('Map') then
                                    CurrentStatus.Set('Moving to exit...')
                                    ClientRoot.CFrame = workspace.Map.Exit.BoundingBox.CFrame
                                    firetouchinterest(ClientRoot, workspace.Map.Exit.BoundingBox, 0)
                                    firetouchinterest(ClientRoot, workspace.Map.Exit.BoundingBox, 1)
                                elseif not FloorFinished() and workspace:FindFirstChild('Map') then
                                    local chestMob = TowerChestMob()
                                    if chestMob  then
                                        ClientRoot.CFrame = chestMob.CFrame + Vector3.new(0,25,0)
                                    else
                                        if Client.PlayerGui.TowerVisual.TowerVisual.KeyImage.TextLabel.Text:find('/') then
                                            local str = (Client.PlayerGui.TowerVisual.TowerVisual.KeyImage.TextLabel.Text):split('/')
                                            local current = tonumber(string.match(str[1] , '%d+'))
                                            local max = tonumber(string.match(str[2] , '%d+'))
                                            local lastPoint = max - current
                                            for i,v in next, workspace.Map:GetChildren() do
                                                if v:FindFirstChild('MobSpawns') then
                                                    for a,b in next, v.MobSpawns:GetChildren() do
                                                        if b:FindFirstChild('Spawns') and #b.Spawns:GetChildren() > 0 and #b.Spawns:GetChildren() <= lastPoint then
                                                            if GetMob() or FloorFinished() or not Settings.StartFarm then break end
                                                            CurrentStatus.Set('Finding mobs...')
                                                            ClientRoot.CFrame = v.BoundingBox.CFrame + Vector3.new(0,25,0)
                                                            firetouchinterest(ClientRoot, v.BoundingBox, 0)
                                                            firetouchinterest(ClientRoot, v.BoundingBox, 1)
                                                            task.wait(1)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    
                        function SubObject()
                            if workspace:FindFirstChild('MissionObjects') then
                                if workspace.MissionObjects:FindFirstChild('Shields') then
                                    for i,v in next, workspace.MissionObjects.Shields:GetChildren() do
                                        if v:FindFirstChild('Ring') and v:FindFirstChild('Glow') and v.Glow:IsA('MeshPart') and tostring(v.Glow.BrickColor) ~= 'Dirt brown' then
                                            return {true, v.Ring}
                                        end
                                    end
                                else
                                    for i,v in next, workspace:GetChildren() do
                                        if (v.Name:find('Pillar') or v.Name == 'Gate') and v:FindFirstChild('HealthProperties') and v.PrimaryPart and v.HealthProperties.Health.Value > 0 then
                                            return {true, v.PrimaryPart}
                                        elseif v.Name == 'IceWall' and v:FindFirstChild('Ring') then
                                            return {true, workspace.IceWall.Ring}
                                        elseif v:IsA("Folder") and v.Name == "FearNukes" then
                                            for i1,v1 in next, v:GetChildren() do
                                                if v:FindFirstChild('HealthProperties') and v.PrimaryPart and v.HealthProperties.Health.Value > 0 then
                                                    return {true, v.PrimaryPart}
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            return {false, nil}
                        end
                    
                        local mob = GetMob()
                        if mob then
                            CurrentStatus.Set('Attacking: '..require(game.ReplicatedStorage.Shared.Mobs.Mobs[mob.Name]).NameTag)
                            if require(game.ReplicatedStorage.Shared.Mobs.Mobs[mob.Name]).BossTag == false then --mob
                                repeat task.wait()
                                    if not mob:FindFirstChild('Collider') then break end
                                    if ClientClass == 'Demon' then
                                        ClientRoot.CFrame = mob.Collider.CFrame - mob.Collider.CFrame.lookVector*5
                                    else
                                        ClientRoot.CFrame = mob.Collider.CFrame + Vector3.new(0,25,0)
                                    end
                                until not mob or not Settings.StartFarm or (QuestLeft('daily') > 0 and Settings.FarmDailyQuest)
                            else --boss
                                repeat task.wait()
                                    if SubObject()[1] == true or not mob:FindFirstChild('Collider') or not mob.Parent or (bossPos ~= nil and mob.Collider.Position.Y <= bossPos - 20) or (mob:FindFirstChild('FromSpawnPart') and mob.FromSpawnPart.Value ~= nil and mob.FromSpawnPart.Value:FindFirstChild('Invincible') ~= nil) then break end
                                    if mob.Name:find('Kraken') then
                                        ClientRoot.CanCollide = true
                                        ClientRoot.CFrame = mob.Collider.CFrame - mob.Collider.CFrame.lookVector*1 + Vector3.new(-10,-15,0)
                                    else
                                        if SubObject()[1] == true and SubObject()[2] ~= nil then
                                            ClientRoot.CFrame = SubObject()[2].CFrame + Vector3.new(0,5,0)
                                        elseif tostring(mob.MobProperties.CurrentAttack.Value) == 'IceBeam' then
                                            ClientRoot.CFrame = ClientRoot.CFrame - ClientRoot.CFrame.lookVector*500
                                            repeat task.wait() until tostring(mob.MobProperties.CurrentAttack.Value) ~= 'IceBeam'
                                        elseif tostring(mob.MobProperties.CurrentAttack.Value) == 'Thunderstorm' then
                                            ClientRoot.CFrame = mob.Collider.CFrame + Vector3.new(0,40,0)
                                            repeat task.wait() until tostring(mob.MobProperties.CurrentAttack.Value) ~= 'Thunderstorm'
                                        else
                                            if ClientClass == 'Demon' then
                                                ClientRoot.CFrame = mob.Collider.CFrame
                                            else
                                                ClientRoot.CFrame = mob.Collider.CFrame + Vector3.new(0,40,0)
                                            end
                                        end
                                    end
                                    mob.Collider.CanCollide = false
                                until not mob or not Settings.StartFarm or (QuestLeft('daily') > 0 and Settings.FarmDailyQuest)
                            end
                        end
                        Trigger()
                    end
                    
                    local OldYPos = ClientRoot.CFrame.Y
                    function FarmOpenWorld(target)
                        function GetMob()
                            local closest
                            local closestDistance = math.huge
                            for i,v in next, workspace.Mobs:GetChildren() do
                                if type(target) == 'table' and table.find(target, v.Name) and v:FindFirstChild('Collider') and v:FindFirstChild('HealthProperties') and v.HealthProperties.Health.Value > 0 then
                                    local currentDistance = (ClientRoot.Position - v.Collider.Position).magnitude
                                    if currentDistance < closestDistance then
                                        closest = v
                                        closestDistance = currentDistance
                                    end
                                end
                            end
                            return closest
                        end
                        
                        function GetWorldBoss()
                            for i,v in next, workspace.Mobs:GetChildren() do
                                if target == nil and v:FindFirstChild('HealthProperties') and v:FindFirstChild('Collider') and v:FindFirstChild('BossTag') and v.HealthProperties.Health.Value > 0 then
                                    return v
                                end
                            end
                        end
                    
                        function GetSpawn()
                            if workspace:FindFirstChild('MobAreas') then
                                for i,v in next, workspace.MobAreas:GetChildren() do
                                    if type(target) == 'table' and v:IsA('Part') and v:FindFirstChild('MobName') and table.find(target, v.MobName.Value) then
                                        return v
                                    end
                                end
                            end
                        end
                    
                        function Tween(target)
                            if target then
                                local Speed = 1
                                if not ClientRoot:FindFirstChild('BodyVelocity') then
                                    local bv = Instance.new('BodyVelocity')
                                    bv.Parent = ClientRoot
                                    bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                                    bv.Velocity = Vector3.new(0,0,0)
                                end
                            
                                ClientRoot.CanCollide = false
                            
                                if (ClientRoot.Position - (target.Position + Vector3.new(0,-30,0))).magnitude > 25 then
                                    ClientRoot.CFrame = CFrame.new(ClientRoot.Position + ((target.Position + Vector3.new(0,-30,0)) - ClientRoot.Position).unit * Speed)
                                else
                                    ClientRoot.CFrame = target.CFrame + Vector3.new(0,-30,0)
                                end
                            end
                        end
                        
                        if workspace:FindFirstChild('Waystones') then
                            for i,v in next, workspace.Waystones:GetChildren() do
                                if v:FindFirstChild('SpawnZone') and v.SpawnZone:FindFirstChild('TouchInterest') then
                                    firetouchinterest(ClientRoot, v.SpawnZone, 0)
                                    firetouchinterest(ClientRoot, v.SpawnZone, 1)
                                end
                            end
                        end
                    
                        local mobSpawn = GetSpawn()
                        local worldBoss = GetWorldBoss()
                        local mob = GetMob()
                    
                        if worldBoss then
                            repeat task.wait()
                                if not worldBoss:FindFirstChild('Collider') then break end
                                CurrentStatus.Set('Moving to: '..require(game.ReplicatedStorage.Shared.Mobs.Mobs[worldBoss.Name]).NameTag)
                                Tween(worldBoss.Collider)
                            until not worldBoss or not Settings.StartFarm
                        elseif not worldBoss and mob then
                            repeat task.wait()
                            if not mob:FindFirstChild('Collider') then break end
                                CurrentStatus.Set('Moving to: '..require(game.ReplicatedStorage.Shared.Mobs.Mobs[mob.Name]).NameTag)
                                Tween(mob.Collider)
                            until not mob or not Settings.StartFarm
                        elseif not (worldBoss and mob) and mobSpawn then
                            repeat task.wait()
                                if GetMob() then break end
                                CurrentStatus.Set('Moving to: '..mobSpawn.Name..' Spawn')
                                Tween(mobSpawn)
                            until GetMob() or not Settings.StartFarm
                        else
                            CurrentStatus.Set('Chilling...')
                            for i=1,#workspace.Waystones:GetChildren() do
                                if not Settings.StartFarm then break end
                                game.ReplicatedStorage.Shared.Teleport.WaystoneTeleport:FireServer(i, 1)
                                task.wait(1)
                            end
                        end
                    end
                    
                    local WorldIDs = {
                        [1] = 13,
                        [2] = 19,
                        [3] = 20,
                        [4] = 29,
                        [5] = 31,
                        [6] = 36,
                        [7] = 40,
                    }
                
                    local TowerTargets = {
                        ['MagmaGigaBlob'] = 21,
                        ['Nautilus'] = 23,
                        ['BOSSZeus'] = 27,
                    }
                
                    function DoQuest(questMode)
                        local questType = questMode.Objective[1]
                        local targetTable = questMode.Objective[3]
                        local linkedWorld = questMode.LinkedWorld
                        local notCorrectWorld = tonumber(string.match(Client.PlayerGui.QuestList.QuestList.ListFrame.Title.Text, '%d+')) ~= linkedWorld
                        if questType == 'KillMob' then
                            if not TowerTargets[targetTable[1]] then
                                if notCorrectWorld or InDungeon then
                                    CurrentStatus.Set('Moving to: World '..tostring(linkedWorld))
                                    game.ReplicatedStorage.Shared.Teleport.TeleportToHub:FireServer(WorldIDs[linkedWorld])
                                    task.wait(100)
                                else
                                    CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                    FarmOpenWorld(targetTable)
                                end
                            else
                                if not InDungeon then
                                    local towerId = TowerTargets[targetTable[1]]
                                    if ClientLevel >= require(game.ReplicatedStorage.Shared.Missions):GetMissionData()[towerId].LevelRequirement then
                                        CurrentStatus.Set('Moving to tower has: '..tostring(targetTable[1]))
                                        game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(towerId)
                                        task.wait(100)
                                    else
                                        CurrentStatus.Set('Farming level...')
                                        game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(FarmLevel())
                                        task.wait(100)
                                    end
                                else
                                    FarmDungeon()
                                end
                            end
                        elseif questType == 'DoDungeon' then
                            if not InDungeon then
                                local LevelRequirement = require(game.ReplicatedStorage.Shared.Missions):GetMissionData()[questMode.Objective[3][1]].LevelRequirement
                                if ClientLevel >= LevelRequirement then
                                    CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                    game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(targetTable[1])
                                    task.wait(100)
                                else
                                    CurrentStatus.Set('Farming level...')
                                    game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(FarmLevel())
                                    task.wait(100)
                                end
                            else
                                FarmDungeon()
                            end
                        elseif questType == 'CompleteWorldEvent' then
                            if notCorrectWorld then
                                CurrentStatus.Set('Moving to: World '..tostring(linkedWorld))
                                game.ReplicatedStorage.Shared.Teleport.TeleportToHub:FireServer(WorldIDs[linkedWorld])
                                task.wait(100)
                            else
                                CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                FarmOpenWorld(nil)
                            end
                        elseif questType == 'DoDungeonInWorld' then
                            if questMode.Name:find('World 1') and not InDungeon then
                                CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(1)
                                task.wait(100)
                            elseif questMode.Name:find('World 2') and not InDungeon then
                                CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(11)
                                task.wait(100)
                            elseif questMode.Name:find('World 3') and not InDungeon then 
                                CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(14)
                                task.wait(100)
                            elseif questMode.Name:find('World 4') and not InDungeon then
                                CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(19)
                                task.wait(100)
                            elseif InDungeon then
                                FarmDungeon()
                            end
                        elseif questType == 'LevelUp' then
                            if not InDungeon then
                                CurrentStatus.Set('Farming level...')
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(FarmLevel())
                                task.wait(100)
                            else
                                FarmDungeon()
                            end
                        end
                    end
                
                    function RepeatMission(questMode)
                        local questType = questMode.Objective[1]
                        local targetTable = questMode.Objective[3]
                        local linkedWorld = questMode.LinkedWorld
                        if questType == 'KillMob' then
                            if not TowerTargets[targetTable[1]] then
                                CurrentStatus.Set('Moving to: World '..tostring(linkedWorld))
                                game.ReplicatedStorage.Shared.Teleport.TeleportToHub:FireServer(WorldIDs[linkedWorld])
                            else
                                local towerId = TowerTargets[targetTable[1]]
                                if ClientLevel >= require(game.ReplicatedStorage.Shared.Missions):GetMissionData()[towerId].LevelRequirement then
                                    CurrentStatus.Set('Moving to tower has: '..tostring(targetTable[1]))
                                    game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(towerId)
                                else
                                    CurrentStatus.Set('Farming level...')
                                    game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(FarmLevel())
                                end
                            end
                        elseif questType == 'DoDungeon' then
                            local LevelRequirement = require(game.ReplicatedStorage.Shared.Missions):GetMissionData()[questMode.Objective[3][1]].LevelRequirement
                            if ClientLevel >= LevelRequirement then
                                CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(targetTable[1])
                            else
                                CurrentStatus.Set('Farming level...')
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(FarmLevel())
                            end
                        elseif questType == 'CompleteWorldEvent' then
                            if notCorrectWorld then
                                CurrentStatus.Set('Moving to: World '..tostring(linkedWorld))
                                game.ReplicatedStorage.Shared.Teleport.TeleportToHub:FireServer(WorldIDs[linkedWorld])
                            end
                        elseif questType == 'DoDungeonInWorld' then
                            CurrentStatus.Set('Doing quest: '..tostring(questMode.Name))
                            if questMode.Name:find('World 1') then
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(1)
                            elseif questMode.Name:find('World 2') then
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(11)
                            elseif questMode.Name:find('World 3') then 
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(14)
                            elseif questMode.Name:find('World 4') then 
                                game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(19)
                            end
                        elseif questType == 'LevelUp' then
                            CurrentStatus.Set('Farming level...')
                            game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(FarmLevel())
                        end
                    end
                
                    local ItemCount = 0
                    if game.ReplicatedStorage:FindFirstChild('FloorCounter') then
                        game.ReplicatedStorage.FloorCounter.Changed:Connect(function(floor)
                            if floor == 10 then
                                ClientProfile.Inventory.Items.ChildAdded:Connect(function(item)
                                    local type = require(game.ReplicatedStorage.Shared.Items)[item.Name].Type
                                    if type == 'Weapon' then
                                        ItemCount += 1
                                    elseif type == 'Armor' then
                                        ItemCount += 1
                                    end
                                end)
                                ClientProfile.Inventory.Cosmetics.ChildAdded:Connect(function(item)
                                    ItemCount += 1
                                end)
                            end
                        end)
                    end
                
                    local MinRec, SecRec
                    local function displayTime(diff)
                        local seconds = math.floor(diff % 60)
                        local minutes = math.floor(diff / 60) % 60
                        if seconds < 10 then
                            seconds = "0" .. tostring(seconds)
                        end
                        if minutes < 10 then
                            minutes = "0" .. tostring(minutes)
                        end
                        MiscLabel:Set("Dungeon Timer: " ..minutes.. ":" .. seconds)
                        SecRec = seconds; MinRec = minutes
                    end
                    local function FinishedTime(diff)
                        MiscLabel:Set("Dungeon Finished in " ..MinRec.. ":" .. SecRec)
                    end

                    local t = tick()

                    local WaitTimer = Settings.NextDungeonDelay 
                    
                    spawn(function() -- mainfarm
                        while Settings.StartFarm  and task.wait(0.01) do
                            if Client.PlayerGui.QuestList.QuestList.DailyQuests.Frame.Complete.Select.ImageColor3 ~= Color3.fromRGB(129,129,129) then
                                game.ReplicatedStorage.Shared.Quests.ClaimCrystals:FireServer()
                            end
                        
                            if QuestLeft('daily') > 0 and Settings.FarmDailyQuest then
                                DoQuest(GetDailyQuest())
                            elseif (QuestLeft('daily') <= 0 or not Settings.FarmDailyQuest) and (QuestLeft('world') > 0 and Settings.FarmWorldQuest) then
                                DoQuest(GetWorldQuest())
                            elseif (QuestLeft('daily') <= 0 or not Settings.FarmDailyQuest) and (QuestLeft('world') <= 0 or not Settings.FarmWorldQuest) then
                                if InDungeon then
                                    FarmDungeon()
                                else
                                    CurrentStatus.Set('Moving to: '..Settings.NameDungeon)
                                    game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(Settings.IdDungeon)
                                end
                            end
                        
                            if InDungeon and Settings.RestartDungeon and Client.PlayerGui.MissionRewards.MissionRewards.Visible == false then
                                displayTime(tick() - t)
                            elseif InDungeon and Settings.RestartDungeon and (ItemCount >= 4 or Client.PlayerGui.MissionRewards.MissionRewards.Visible == true) then -- end mission
                                FinishedTime(tick() - t)
                                game.ReplicatedStorage.Shared.Missions.GetMissionPrize:InvokeServer()
                                game.ReplicatedStorage.Shared.Missions.GetMissionPrize:InvokeServer()
                                repeat wait(1) 
                                    CurrentStatus.Set('Waiting '.. WaitTimer ..' Seconds')
                                    WaitTimer = WaitTimer - 1
                                until WaitTimer == 0 
                                if QuestLeft('daily') > 0 and Settings.FarmDailyQuest then
                                    RepeatMission(GetDailyQuest())
                                elseif (QuestLeft('daily') <= 0 or not Settings.FarmDailyQuest) and (QuestLeft('world') > 0 and Settings.FarmWorldQuest) then
                                    RepeatMission(GetWorldQuest())
                                elseif (QuestLeft('daily') <= 0 or not Settings.FarmDailyQuest) and (QuestLeft('world') <= 0 or not Settings.FarmWorldQuest) then
                                    CurrentStatus.Set('Moving to: '..Settings.NameDungeon)
                                    game.ReplicatedStorage.Shared.Teleport.StartRaid:FireServer(Settings.IdDungeon)
                                    wait(5)
                                end
                            end
                        end
                    end)
                end
            end
        })

        SelectDungeonAfterMission = Sections.AutofarmSettings:AddSearchBox({
            Name = 'Quests List',
            List = MissionList(),
            Value = tostring(Settings.NameDungeon),
            Callback = function(value)
                for i,v in next, GetActiveMission() do
                    if value == v.Name then
                        SelectDifficulty:UpdateList(DifficultyList(v.ID))
                        Settings.IdDungeon = v.ID
                        Settings.NameDungeon = v.Name
                        Save()
                    end
                end
            end
        })

        SelectDifficulty = Sections.AutofarmSettings:AddSearchBox({
            Name = 'Difficulty List',
            List = DifficultyList(Settings.IdDungeon),
            Value = tostring(Settings.NameDifficulty),
            Callback = function(value)
                if value == "Normal" then
                    Settings.NameDifficulty = value
                    Settings.IdDifficulty = 1
                elseif value == "Hard" then
                    Settings.NameDifficulty = value
                    Settings.IdDifficulty = 2
                elseif value == "Challenge" then
                    Settings.NameDifficulty = value
                    Settings.IdDifficulty = 3
                elseif value == "MASTER" then
                    Settings.NameDifficulty = value
                    Settings.IdDifficulty = 4
                end
                Save()
            end
        })

        ClientProfile.Level.Changed:Connect(function()
            SelectDungeonAfterMission:UpdateList(MissionList())
        end)
    
        Sections.AutofarmSettings:AddToggle({
            Name = 'Farm Daily Quests',
            Enabled = Settings.FarmDailyQuest,
            Callback = function(state)
                Settings.FarmDailyQuest = state
                Save()
            end
        })
    
        Sections.AutofarmSettings:AddToggle({
            Name = 'Farm World Quests',
            Enabled = Settings.FarmWorldQuest,
            Callback = function(state)
                Settings.FarmWorldQuest = state
                Save()
            end
        })
    
        Sections.AutofarmSettings:AddToggle({
            Name = 'Restart Dungeon',
            Enabled = Settings.RestartDungeon,
            Callback = function(state)
                Settings.RestartDungeon = state
                Save()
            end
        })
    
        Sections.AutofarmSettings:AddSlider({
            Name = 'Next Dungeon Delay (Sec)',
            Min = 2,
            Max = 300,
            Value = Settings.NextDungeonDelay,
            Textbox = true,
            Callback = function(value)
                Settings.NextDungeonDelay = value
                Save()
            end
        })

        Sections.AutofarmSettings:AddSlider({
            Name = 'Rejoin Game Delay (Min)',
            Min = 3,
            Max = 60,
            Value = Settings.RejoinDelay,
            Textbox = true,
            Callback = function(value)
                Settings.RejoinDelay = value
                Save()
            end
        })
        
        --Features
        Sections.FeaturesSettings:AddToggle({
            Name = 'Kill Aura',
            Enabled = Settings.KillAura,
            Callback = function(state)
                Settings.KillAura = state
                Save()
            
                function Attackable()
                    local pos = {}
                    local mobs = {}
                
                    for i,v in next, workspace.Mobs:GetChildren() do
                        if v:IsA("Model") and not v:FindFirstChild('NoHealthbar') and v:FindFirstChild('Collider') and v:FindFirstChild('HealthProperties') and v.HealthProperties:FindFirstChild('Health') and v.HealthProperties.Health.Value > 0 then
                            table.insert(mobs, v)
                            table.insert(pos, ClientRoot.Position)
                        end
                    end
                
                    if game.ReplicatedStorage.Shared.Combat.InDuel:FindFirstChild(Client.Name) then
                        for i,v in next, game.Players:GetPlayers() do
                            if v.Name ~= Client.Name and table.find(game.ReplicatedStorage.Shared.Combat.InDuel:GetChildren(), v.Name) and v.Character and v.Character:FindFirstChild('Collider') and v.Character:FindFirstChild('HealthProperties') and v.Character.HealthProperties:FindFirstChild('Health') and v.Character.HealthProperties.Health.Value > 0 then
                                table.insert(mobs, v.Character)
                                table.insert(pos, ClientRoot.Position)
                            end
                        end
                    end
                
                    local AttackableObjects = {3383444582, 4465989351, 4465989998, 4646473427, 4646475570, 6386112652}
                    if table.find(AttackableObjects, game.PlaceId) and workspace:FindFirstChild('MissionObjects') then
                        for i,v in next, workspace.MissionObjects:GetDescendants() do
                            if not v:FindFirstChild("IgnorePlayerHits") and v:FindFirstChild("HealthProperties") and v.PrimaryPart and v.HealthProperties:FindFirstChild("Health") and v.HealthProperties.Health.Value > 0 then
                                table.insert(mobs, v)
                                table.insert(pos, ClientRoot.Position)
                            end
                        end
                    
                        for i,v in next, workspace:GetChildren() do
                            if (v.Name:find("Pillar") or v.Name == "Gate") and v:FindFirstChild("HealthProperties") and v.PrimaryPart and v.HealthProperties:FindFirstChild("Health") and v.HealthProperties.Health.Value > 0 then
                                table.insert(mobs, v)
                                table.insert(pos, ClientRoot.Position)
                            elseif v:IsA('Folder') and v.Name == 'FearNukes' then
                                for i1,v1 in next, v:GetChildren() do
                                    if v1:FindFirstChild("HealthProperties") and v1.PrimaryPart and v1.HealthProperties:FindFirstChild("Health") and v1.HealthProperties.Health.Value > 0 then
                                        table.insert(mobs, v1)
                                        table.insert(pos, ClientRoot.Position)
                                    end
                                end
                            end
                        end
                    end
                
                    return {['mobs'] = mobs, ['pos'] = pos}
                end
            
                local keys = getupvalues(getfenv(require(game.ReplicatedStorage.Shared.Combat).AttackTargets).SpendKey)[1]
            
                local timestamps = {} do
                    for i,v in next, getgc(true) do
                        if type(v) == 'table' and rawget(v, 'timestamps') then
                            table.insert(timestamps, v.timestamps)
                        end
                    end
                end
            
                function AddTime(time)
                    for i,v in next, timestamps do
                        table.insert(v, time)
                    end
                end
            
                function GetKey()
                    if #keys <= 10 then --refill
                        local lastkey = table.remove(keys,#keys)
                        local refillTable = game.ReplicatedStorage.Remotes.GetKeys:InvokeServer(lastkey)
                        if type(refillTable) == 'table' then
                            for i,v in next, refillTable do
                                table.insert(keys, v)
                            end
                        end
                    end
                    return table.remove(keys, #keys)
                end
            
                local classleft = {
                    Swordmaster = {'Swordmaster1','Swordmaster2','Swordmaster3','Swordmaster4','Swordmaster5','Swordmaster6','CrescentStrike1','CrescentStrike2','Leap'},
                    Defender = {'Defender1','Defender2','Defender3','Defender4','Defender5','Groundbreaker','Spin1','Spin2','Spin3','Spin4','Spin5'},
                    
                    IcefireMage = {'IcefireMage1','IcySpikes1','IcySpikes2','IcySpikes3','IcySpikes4','IcefireMageFireballBlast','IcefireMageFireball','LightningStrike1','LightningStrike2','LightningStrike3','LightningStrike4','LightningStrike5','IcefireMageUltimateFrost','IcefireMageUltimateMeteor1'},
                    Guardian = {'Guardian1','Guardian2','Guardian3','Guardian4','RockSpikes1','RockSpikes2','RockSpikes3','RockSpikes4','RockSpikes5','SlashFury1','SlashFury2','SlashFury3','SlashFury4','SlashFury5','SlashFury6','SlashFury7','SlashFury8','SlashFury9','SlashFury10','SlashFury11','SlashFury12','SwordPrison1','SwordPrison2','SwordPrison3','SwordPrison4','SwordPrison5','SwordPrison6','SwordPrison7','SwordPrison8','SwordPrison9','SwordPrison10','SwordPrison11','SwordPrison12'},
                    
                    Berserker = {'Berserker1','Berserker2','Berserker3','Berserker4','Berserker5','Berserker6','GigaSpin1','GigaSpin2','GigaSpin3','GigaSpin4','GigaSpin5','GigaSpin6','GigaSpin7','GigaSpin8','Fissure1','Fissure2'},
                    MageOfLight = {'MageOfLight','MageOfLightCharged','MageOfLightBlast','MageOfLightBlastCharged'},
                }
            
                local AttackTypes = {
                    ['Primary'] 	= {},
                    ['Skill1'] 		= {},
                    ['Skill2'] 		= {},
                    ['Skill3'] 		= {},
                    ['Ultimate'] 	= {},
                }
            
                local Pause = {
                    Mage = {Atk = 0.3},
                
                    DualWielder = {Atk = 0.6, Ult = 6},
                    Guardian = {Atk = 0.6, Ult = 6},
                
                    Paladin = {Atk = 0.6},
                
                    Dragoon = {Atk = 0.3, Ult = 3},
                    Demon = {Atk = 1},
                    Archer = {Atk = 0.4, Ult = 4},
                }
            
                if ClientClass == 'Mage' then
                    table.insert(AttackTypes.Primary, 'Mage1')
                    table.insert(AttackTypes.Skill1, 'ArcaneBlastAOE')
                    table.insert(AttackTypes.Skill1, 'ArcaneBlast')
                    for i=1,12 do
                        table.insert(AttackTypes.Skill2, 'ArcaneWave'..i)
                    end
                elseif ClientClass == 'DualWielder' then
                    for i=1,10 do
                        table.insert(AttackTypes.Primary, 'DualWield'..i)
                    end
                    table.insert(AttackTypes.Skill2, 'DashStrike')
                    for i=1,4 do
                        table.insert(AttackTypes.Skill3, 'CrossSlash'..i)
                    end
                    for i=1,12 do
                        table.insert(AttackTypes.Ultimate, 'DualWieldUltimateSword'..i)
                        table.insert(AttackTypes.Ultimate, 'DualWieldUltimateHit'..i)
                    end
                    table.insert(AttackTypes.Ultimate, 'DualWieldUltimateSlam')
                    for i=1,3 do
                        table.insert(AttackTypes.Ultimate, 'DualWieldUltimateSlam'..i)
                    end
                elseif ClientClass == 'Guardian' then
                    for i=1,4 do
                        table.insert(AttackTypes.Primary, 'Guardian'..i)
                    end
                    for i=1,5 do
                        table.insert(AttackTypes.Skill2, 'RockSpikes'..i)
                    end
                    for i=1,15 do
                        table.insert(AttackTypes.Skill3, 'SlashFury'..i)
                    end
                    for i=1,12 do
                        table.insert(AttackTypes.Ultimate, 'SwordPrison'..i)
                    end
                elseif ClientClass == 'Paladin' then
                    for i=1,4 do
                        table.insert(AttackTypes.Primary, 'Paladin'..i)
                        table.insert(AttackTypes.Primary, 'LightPaladin'..i)
                    end
                    table.insert(AttackTypes.Skill1, 'Block')
                    for i=1,2 do
                        table.insert(AttackTypes.Skill3, 'LightThrust'..i)
                    end
                elseif ClientClass == 'Demon' then
                    for i=1,25 do
                        table.insert(AttackTypes.Primary, 'Demon'..i)
                    end
                    for i=1,9 do
                        table.insert(AttackTypes.Primary, 'DemonDPS'..i)
                    end
                    for i=1,3 do
                        table.insert(AttackTypes.Skill2, 'ScytheThrowDPS'..i)
                        table.insert(AttackTypes.Skill2, 'ScytheThrow'..i)
                    end
                    table.insert(AttackTypes.Skill3, 'DemonLifeStealAOE')
                    table.insert(AttackTypes.Skill3, 'DemonLifeStealDPS')
                elseif ClientClass == 'Dragoon' then
                    for i=1,6 do
                        table.insert(AttackTypes.Primary, 'Dragoon'..i)
                    end
                    for i=1,10 do
                        table.insert(AttackTypes.Skill1, 'DragoonCross'..i)
                    end
                    for i=1,5 do
                        table.insert(AttackTypes.Skill2, 'MultiStrike'..i)
                    end
                    table.insert(AttackTypes.Skill3, 'DragoonSlam')
                    table.insert(AttackTypes.Ultimate, 'DragoonUltimate')
                    for i=1,7 do
                        table.insert(AttackTypes.Ultimate, 'UltimateDragon'..i)
                    end
                elseif ClientClass == 'Archer' then
                    table.insert(AttackTypes.Primary, 'Archer')
                    for i=1,9 do
                        table.insert(AttackTypes.Skill1, 'PiercingArrow'..i)
                    end
                    table.insert(AttackTypes.Skill2, 'SpiritBomb')
                    for i=1,5 do
                        table.insert(AttackTypes.Skill3, 'MortarStrike'..i)
                    end
                    for i=1,6 do
                        table.insert(AttackTypes.Ultimate, 'HeavenlySword'..i)
                    end
                end
                
                spawn(function()
                    while Settings.KillAura and task.wait(0.01) do
                        if #Attackable()['mobs'] > 0 and not require(game.ReplicatedStorage.Client.Actions):IsMounted() then
                            for i,v in next, AttackTypes do
                                if #v > 0  and i ~= 'Ultimate' then
                                    if #Attackable()['mobs'] <= 0 then break end
                                    if i == 'Primary' then
                                        require(game.ReplicatedStorage.Client.Actions):FireSkillUsedSignal(i)
                                        for i1,v1 in next, v do
                                            if #Attackable()['mobs'] <= 0 then break end
                                            local time = time()
                                            AddTime(time)
                                            game.ReplicatedStorage.Shared.Combat.AttackTarget:FireServer(Attackable()['mobs'], Attackable()['pos'], v1, GetKey(), time)
                                            task.wait()
                                        end
                                        task.wait(Pause[ClientClass].Atk)
                                    else
                                        if not require(game.ReplicatedStorage.Client.Actions):IsOnCooldown(i) then
                                            require(game.ReplicatedStorage.Client.Actions):FireSkillUsedSignal(i)
                                            require(game.ReplicatedStorage.Client.Actions):FireCooldown(i)
                                            for i1,v1 in next, v do
                                                if #Attackable()['mobs'] <= 0 then break end
                                                local time = time()
                                                AddTime(time)
                                                game.ReplicatedStorage.Shared.Combat.AttackTarget:FireServer(Attackable()['mobs'], Attackable()['pos'], v1, GetKey(), time)
                                                task.wait()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                
                function MobIsClose()
                    if #Attackable()['mobs'] > 0 then
                        for i,v in next, Attackable()['mobs'] do
                            if v.PrimaryPart.Parent and (ClientRoot.Position - v.PrimaryPart.Position).magnitude <= 30 then
                                return true
                            end
                        end
                    end
                end
            
                spawn(function()
                    while Settings.KillAura and task.wait(0.01) do
                        if #Attackable()['mobs'] > 0 and not require(game.ReplicatedStorage.Client.Actions):IsMounted() then
                            if ClientClass ~= 'Demon' then
                                if #AttackTypes['Ultimate'] > 0 then
                                    require(game.ReplicatedStorage.Client.Actions):FireSkillUsedSignal('Ultimate')
                                    require(game.ReplicatedStorage.Shared.Combat.Skillsets[ClientClass]):CleanupCharacter(Character)
                                    for i,v in next, AttackTypes['Ultimate'] do
                                        if #Attackable()['mobs'] <= 0 then break end
                                        local time = time()
                                        AddTime(time)
                                        game.ReplicatedStorage.Shared.Combat.AttackTarget:FireServer(Attackable()['mobs'], Attackable()['pos'], v, GetKey(), time)
                                        task.wait()
                                    end
                                    task.wait(Pause[ClientClass].Ult)
                                end
                            else
                                if InDungeon then
                                    if Character:FindFirstChild("HealthProperties") and Character.HealthProperties.Health.Value < Character.HealthProperties.MaxHealth.Value then
                                        game.ReplicatedStorage.Shared.Combat.Skillsets.Demon.LifeSteal:FireServer(Attackable()['mobs'])
                                    end
                                    if MobIsClose() then
                                        for i=1,26 do
                                            game.ReplicatedStorage.Shared.Combat.Skillsets.Demon.Demonic:FireServer()
                                        end
                                        game.ReplicatedStorage.Shared.Combat.Skillsets.Demon.Ultimate:FireServer()
                                        for i,v in next, game.Players:GetPlayers() do
                                            if v.Character then
                                                require(game.ReplicatedStorage.Shared.Combat.Skillsets[ClientClass]):CleanupCharacter(v.Character)
                                            end
                                        end
                                        task.wait()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        })
    
        Sections.FeaturesSettings:AddToggle({
            Name = 'Pick Up',
            Enabled = Settings.PickUp,
            Callback = function(state)
                Settings.PickUp = state
                Save()
            
                spawn(function()
                    while Settings.PickUp and task.wait(1) do
                        for i,v in next, getupvalues(require(game.ReplicatedStorage.Shared.Chests).Start)[7] do
                            if v.Parent and game.ReplicatedStorage.Shared.Chests.CheckCondition:InvokeServer(i) == true then
                                game.ReplicatedStorage.Shared.Chests.OpenChest:FireServer(i)
                                v:Destroy()
                            end
                        end
                    
                        for i,v in next, getupvalues(require(game.ReplicatedStorage.Shared.Drops).RedeemCoin)[1] do
                            if type(v) == 'table' and v.spawnTime > 0 and v.model.Parent then
                                game.ReplicatedStorage.Shared.Drops.CoinEvent:FireServer(v.id)
                                v.spawnTime = 0
                                v.model:Destroy()
                            end
                        end
                    end
                end)
            end
        })
    
        Sections.FeaturesSettings:AddToggle({
            Name = 'Upgrade Equipped Gears',
            Enabled = false,
            Callback = function(state)
                spawn(function()
                    while state and task.wait(0.1) do
                        for i,v in next, ClientProfile.Equip:GetDescendants() do 
                            if v.Parent == ClientProfile.Equip['Primary'] or v.Parent == ClientProfile.Equip['Offhand'] or v.Parent == ClientProfile.Equip['Armor'] or v.Parent == ClientProfile.Equip['Rune1'] or v.Parent == ClientProfile.Equip['Rune2'] or v.Parent == ClientProfile.Equip['Rune3'] then
                                if v:FindFirstChild('Upgrade') and v:FindFirstChild('UpgradeLimit') and v.Upgrade.Value < v.UpgradeLimit.Value then
                                    repeat task.wait()
                                        game.ReplicatedStorage.Shared.ItemUpgrade.Upgrade:FireServer(v)
                                    until v.Upgrade.Value == v.UpgradeLimit.Value or not state1
                                elseif not v:FindFirstChild('Upgrade') and v:FindFirstChild('UpgradeLimit') then
                                    game.ReplicatedStorage.Shared.ItemUpgrade.Upgrade:FireServer(v)
                                end
                            end
                        end
                    end
                end)
            end
        })
        
        Sections.FeaturesSettings:AddSlider({
            Name = 'Sprint Speed',
            Min = 30,
            Max = 100,
            Value = Settings.SprintSpeed,
            Textbox = true,
            Callback = function(value)
                Settings.SprintSpeed = value
                Save()
            
                getupvalues(require(game.ReplicatedStorage.Client.Actions)['Sprint'])[4]['SPRINT_WALKSPEED'] = Settings.SprintSpeed
            end
        })
    
        local NameList = {}
        local DistanceList = {}
        local EspLoop
        Sections.FeaturesSettings:AddToggle({
            Name = 'Players ESP',
            Enabled = Settings.PlayerESP,
            Callback = function(state)
                Settings.PlayerESP = state
                Save()
                if Settings.PlayerESP then
                    EspLoop = game:GetService('RunService').RenderStepped:Connect(function()
                        for i,v in next, NameList do if v then v:Remove() end end
                        for i,v in next, DistanceList do if v then v:Remove() end end
                        
                        NameList = {}
                        DistanceList = {}
                    
                        for i,v in next, game.Players:GetPlayers() do
                            if v.Name ~= game.Players.LocalPlayer.Name and v.Character and v.Character.PrimaryPart ~= nil then
                                local pos = v.Character.PrimaryPart.Position
                                local ScreenSpacePos, IsOnScreen = workspace.CurrentCamera:WorldToViewportPoint(pos)
                                
                                if IsOnScreen then
                                    local NAME = Drawing.new('Text')
                                    NAME.Text = v.Name
                                    NAME.Size = 16
                                    NAME.Color = Color3.fromRGB(255, 248, 145)
                                    NAME.Center = true
                                    NAME.Visible = true
                                    NAME.Transparency = 1
                                    NAME.Position = Vector2.new(0, 0)
                                    NAME.Outline = true
                                    NAME.OutlineColor = Color3.fromRGB(10, 10, 10)
                                    NAME.Font = 3
                                    
                                    local DISTANCE = Drawing.new('Text')
                                    DISTANCE.Text = '[]'
                                    DISTANCE.Size = 14
                                    DISTANCE.Color = Color3.fromRGB(255, 255, 255)
                                    DISTANCE.Center = true
                                    DISTANCE.Visible = true
                                    DISTANCE.Transparency = 1
                                    DISTANCE.Position = Vector2.new(0, 0)
                                    DISTANCE.Outline = true
                                    DISTANCE.OutlineColor = Color3.fromRGB(10, 10, 10)
                                    DISTANCE.Font = 3
                                    
                                    NAME.Position = Vector2.new(ScreenSpacePos.X, ScreenSpacePos.Y)
                                    DISTANCE.Position = NAME.Position + Vector2.new(0, NAME.TextBounds.Y/1.2)
                                    DISTANCE.Text = '['..math.round((game.Players.LocalPlayer.Character.PrimaryPart.Position - pos).magnitude)..'m]'
                                
                                    NameList[#NameList+1] = NAME
                                    DistanceList[#DistanceList+1] = DISTANCE
                                end
                            end
                        end
                    end)
                else
                    EspLoop:Disconnect()
                
                    for i,v in next, NameList do v:Remove() end
                    for i,v in next, DistanceList do v:Remove() end
                    
                    NameList = {}
                    DistanceList = {}
                end
            end
        })
    
        -- Misc Settings
        Sections.MiscSettings:AddToggle({
            Name = 'RapidFire',
            Enabled = Settings.NoBusy,
            Callback = function(state)
                Settings.NoBusy = state
                Save()

                spawn(function()
                    while state and wait(0.01) do
                        for i,v in next, require(game.ReplicatedStorage.Client.Actions) do
                            if typeof(v) ~= 'function' then continue end
                            if i == 'IsBusy' then
                                for i1,v1 in next, getupvalues(v) do
                                    if typeof(v1) == 'boolean' and v1 == true then
                                        setupvalue(v, i1, false)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        })

        --Inventory
        Sections.AutoSellSettings:AddToggle({
            Name = 'Tier 1',
            Enabled = Settings.SellCommon,
            Callback = function(state)
                Settings.SellCommon = state
                Save()
            end
        })
    
        Sections.AutoSellSettings:AddToggle({
            Name = 'Tier 2',
            Enabled = Settings.SellUncommon,
            Callback = function(state)
                Settings.SellUncommon = state
                Save()
            end
        })
    
        Sections.AutoSellSettings:AddToggle({
            Name = 'Tier 3',
            Enabled = Settings.SellRare,
            Callback = function(state)
                Settings.SellRare = state
                Save()
            end
        })
    
        Sections.AutoSellSettings:AddToggle({
            Name = 'Tier 4',
            Enabled = Settings.SellEpic,
            Callback = function(state)
                Settings.SellEpic = state
                Save()
            end
        })
    
        Sections.AutoSellSettings:AddToggle({
            Name = 'Eggs',
            Enabled = Settings.SellEgg,
            Callback = function(state)
                Settings.SellEgg = state
                Save()
            end
        })
    
        Sections.AutoSellSettings:AddButton({
            Name = 'Instant Sell',
            Callback = function()
                local sellTable = {}
                for i,v in next, ClientProfile.Inventory.Items:GetChildren() do
                    if v:IsA('Folder') then
                        local rarity = require(game.ReplicatedStorage.Shared.Inventory):GetItemTier(v)
                        local type = require(game.ReplicatedStorage.Shared.Items)[v.Name].Type
                        if type == 'Weapon' or type == 'Armor' then
                            if Settings.SellCommon and rarity == 1 then
                                table.insert(sellTable, v)
                            elseif Settings.SellUncommon and rarity == 2 then
                                table.insert(sellTable, v)
                            elseif Settings.SellRare and rarity == 3 then
                                table.insert(sellTable, v)
                            elseif Settings.SellEpic and rarity == 4 then
                                table.insert(sellTable, v)
                            end
                        elseif type == 'Egg' and Settings.SellEgg then
                            table.insert(sellTable, v)
                        end
                    end
                end
                game.ReplicatedStorage.Shared.Drops.SellItems:InvokeServer(sellTable)
            end
        })
    
        Sections.AutoSellSettings:AddToggle({
            Name = 'Auto Equip',
            Enabled = Settings.AutoEquip,
            Callback = function(state)
                Settings.AutoEquip = state
                Save()
            end
        })
    
        Sections.AutoSellSettings:AddToggle({
            Name = 'Auto Sell',
            Enabled = Settings.AutoSell,
            Callback = function(state)
                Settings.AutoSell = state
                Save()
            end
        })
    
        ClientProfile.Inventory.Items.ChildAdded:Connect(function(v)     
            spawn(function()
                while Settings.AutoEquip and task.wait(0.01) do
                    local type = require(game.ReplicatedStorage.Shared.Items)[v.Name].Type
                    if type == 'Weapon' then
                        local currentWeapon = ClientProfile.Equip.Primary:FindFirstChildWhichIsA('Folder')
                        if currentWeapon then
                            local currentDmg = require(game.ReplicatedStorage.Shared.Combat):GetItemStats(currentWeapon).Attack
                            local newDmg = require(game.ReplicatedStorage.Shared.Combat):GetItemStats(v).Attack
                            if newDmg > currentDmg then
                                game.ReplicatedStorage.Shared.Inventory.EquipItem:FireServer(v, ClientProfile.Equip['Primary'])
                            end
                        end
                    elseif type == 'Armor' then
                        local currentArmor = ClientProfile.Equip.Armor:FindFirstChildWhichIsA('Folder')
                        if currentArmor then
                            local currentHealth = require(game.ReplicatedStorage.Shared.Combat):GetItemStats(currentArmor).Defense
                            local newHealth = require(game.ReplicatedStorage.Shared.Combat):GetItemStats(v).Defense
                            if newHealth > currentHealth then
                                game.ReplicatedStorage.Shared.Inventory.EquipItem:FireServer(v, ClientProfile.Equip['Armor'])
                            end
                        end
                    end
                end
            end)
            
            task.wait(1)
            
            if v.Parent ~= ClientProfile.Inventory.Items then 
                return 
            end
        
            if Settings.AutoSell then
                local rarity = require(game.ReplicatedStorage.Shared.Inventory):GetItemTier(v)
                local type = require(game.ReplicatedStorage.Shared.Items)[v.Name].Type
                if type == 'Weapon' or type == 'Armor' then
                    if Settings.SellCommon and rarity == 1 then
                        game.ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({v})
                    elseif Settings.SellUncommon and rarity == 2 then
                        game.ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({v})
                    elseif Settings.SellRare and rarity == 3 then
                        game.ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({v})
                    elseif Settings.SellEpic and rarity == 4 then
                        game.ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({v})
                    end
                elseif type == 'Egg' and Settings.SellEgg then
                    game.ReplicatedStorage.Shared.Drops.SellItems:InvokeServer({v})
                end
            end
        end)
    
        --Misc
        Sections.MiscMenu:AddButton({
            Name = 'Open Bank Menu',
            Callback = function()
                require(game.ReplicatedStorage.Client.Gui.GuiScripts.Bank):Open()
            end
        })
    
        Sections.MiscMenu:AddButton({
            Name = 'Open Dungeons Menu',
            Callback = function()
                require(game.ReplicatedStorage.Client.Gui.GuiScripts.MissionSelect):Open()
            end
        })
    
        Sections.MiscMenu:AddButton({
            Name = 'Open Worlds Menu',
            Callback = function()
                require(game.ReplicatedStorage.Client.Gui.GuiScripts.WorldTeleport):Open()
            end
        })
    
        local BuyEgg = 'StarEgg'
        Sections.MiscPet:AddSearchBox({
            Name = "Egg Info",
            List = {'StarEgg','JungleEgg','CrystalEgg','DesertEgg','ChristmasEgg','MoltenEgg','OceanEgg','SkyEgg','CatEgg',},
            Value = BuyEgg,
            Callback = function(value)
                BuyEgg = value
                require(game.ReplicatedStorage.Client.Gui.GuiScripts.PetShop):Open(value)
            end
        })
    
        Sections.MiscPet:AddButton({
            Name = 'Buy Egg',
            Callback = function()
                game.ReplicatedStorage.Shared.Pets.BuyEgg:FireServer(BuyEgg, 'Gold')
            end
        })
    
        Sections.MiscPet:AddToggle({
            Name = 'Feed Pet',
            Enabled = false,
            Callback = function(state)
                spawn(function()
                    while state and task.wait(0.1) do
                        for i,v in next, ClientProfile.Inventory.Items:GetChildren() do
                            if v:FindFirstChild('Count') and v.Count.Value > 0 then
                                game.ReplicatedStorage.Shared.Pets.FeedPet:FireServer(v, true)
                            end
                        end
                    end
                end)
            end
        })
    
        function GetDyeList()
            local DyeList = {}
                for i,v in next, ClientProfile.Inventory.Items:GetChildren() do
                    if v.Name:find('Dye') then
                        table.insert(DyeList, v.Name)
                    end
                end
            return DyeList
        end
    
        local DyePath
        local DyeList = Sections.MiscDye:AddSearchBox({
            Name = 'Select Dye',
            List = GetDyeList(),
            Value = GetDyeList()[1],
            Callback = function(value)
                print(value)
                for i,v in next, ClientProfile.Inventory.Items:GetChildren() do
                    if v.Name:find(value) then
                        DyePath = v
                        require(game.ReplicatedStorage.Client.Gui.GuiScripts.DyeConfirm):SetArmorModel(require(game.ReplicatedStorage.Shared.Profile):GetEquipmentPiece(ClientProfile, 'Costume').Name, require(game.ReplicatedStorage.Shared.Items)[v.Name].DyeColor)
                        Client.PlayerGui.DyeConfirm.DyeConfirm.Counter.Text = 'Just Preview'
                        Client.PlayerGui.DyeConfirm.DyeConfirm.Decline.TextLabel.Text = 'Close'
                        Client.PlayerGui.DyeConfirm.DyeConfirm.UIScale.Scale = 1
                        Client.PlayerGui.DyeConfirm.DyeConfirm.Visible = true
                    end
                end
            end
        })
    
        ClientProfile.Inventory.Items.ChildAdded:Connect(function(v)
            if v.Name:find('Dye') then
                DyeList:UpdateList(GetDyeList())
            end
        end)
    
        ClientProfile.Inventory.Items.ChildRemoved:Connect(function(v)
            if v.Name:find('Dye') then
                DyeList:UpdateList(GetDyeList())
            end
        end)
    
        Sections.MiscDye:AddButton({
            Name = 'Apply Dye',
            Callback = function()
                game.ReplicatedStorage.Shared.Inventory.DyeItem:FireServer(DyePath, ClientProfile.Equip['Costume']:FindFirstChildWhichIsA('Folder'))
            end
        })
    
        Sections.MiscEvent:AddButton({
            Name = 'Collect Battlepass',
            Callback = function()
                for i=1,40 do
                    game.ReplicatedStorage.Shared.Battlepass.RedeemItem:FireServer(i)
                    game.ReplicatedStorage.Shared.Battlepass.RedeemItem:FireServer(i, true)
                end
            end
        })

        spawn(function()
            while wait(Settings.RejoinDelay * 60) do
                if InDungeon and Settings.StartFarm then
                    game:GetService('TeleportService'):Teleport(2727067538)
                end
            end
        end)
    end
end
