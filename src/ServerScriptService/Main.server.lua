local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Config=require(ReplicatedStorage.Shared.Config)
local Data=require(script.Parent.DataService)
local Progress=require(script.Parent.ProgressionService)
local Pets=require(script.Parent.PetService)
local Trading=require(script.Parent.TradingService)
local Monetization=require(script.Parent.MonetizationService)
local R=ReplicatedStorage.Remotes; local Action=R.Action; local Notify=R.Notify; local Trade=R.TradeEvent
local function msg(p,t) Notify:FireClient(p,t) end
local function state(p) local d=Data.Get(p); return {Gems=d.Gems,Rebirths=d.Rebirths,Upgrades={Power=d.Power,Capacity=d.Capacity,Luck=d.Luck,Speed=d.Speed},Pets=d.Pets,Equipped=d.Equipped,Zones=d.Zones,Daily=d.Daily,Codes=d.Codes,Settings=d.Settings} end
R.GetState.OnServerInvoke=function(p) return state(p) end
local function collect(p,c)
 local d=Data.Get(p); local amount=math.floor((10+d.Power*4)*Pets.Multiplier(p)); if p:GetAttribute("VIP") then amount*=2 end; Data.Add(p,amount); msg(p,"+"..amount.." Gems") end
local function setup(p)
 local d=Data.Load(p); local ls=Instance.new("Folder",p); ls.Name="leaderstats"; local g=Instance.new("IntValue",ls); g.Name="Gems"; local r=Instance.new("IntValue",ls); r.Name="Rebirths"; Data.Sync(p); p.CharacterAdded:Connect(function(c) local h=c:WaitForChild("Humanoid"); h.WalkSpeed=16+(d.Speed*2) end) end
Action.OnServerEvent:Connect(function(p,a) if type(a)~="table" then return end; local ok,text
 if a.Type=="Collect" then collect(p) elseif a.Type=="Upgrade" then ok,text=Progress.Buy(p,a.Name); msg(p,text) elseif a.Type=="Rebirth" then ok,text=Progress.Rebirth(p); msg(p,text); Data.Sync(p) elseif a.Type=="Hatch" then ok,text=Pets.Hatch(p,a.Name); msg(p,text) elseif a.Type=="Equip" then ok,text=Pets.Equip(p,a.Id); msg(p,text) elseif a.Type=="Unequip" then ok,text=Pets.Unequip(p,a.Id); msg(p,text) elseif a.Type=="Redeem" then local d=Data.Get(p); local code=string.upper(tostring(a.Code or "")); if Config.Codes[code] and not d.Codes[code] then d.Codes[code]=true; Data.Add(p,Config.Codes[code]); msg(p,"Code redeemed!") else msg(p,"Invalid or used code") end elseif a.Type=="Daily" then local d=Data.Get(p); local day=os.date("%Y-%j"); if d.Daily.Day~=day then d.Daily.Day=day; d.Daily.Streak+=1; Data.Add(p,250+d.Daily.Streak*50); msg(p,"Daily reward claimed!") else msg(p,"Already claimed today") end elseif a.Type=="Zone" then local d=Data.Get(p); for _,z in ipairs(Config.Zones) do if z.Id==a.Name then if d.Zones[z.Id] then p.Character:PivotTo(CFrame.new(z.Position+Vector3.new(0,5,0))) elseif Data.Spend(p,z.Price) then d.Zones[z.Id]=true; msg(p,"Zone unlocked!") else msg(p,"Not enough Gems") end end end elseif a.Type=="TradeRequest" then ok,text=Trading.Request(p,Players:FindFirstChild(a.Target)); msg(p,text) elseif a.Type=="TradeAccept" then ok,text=Trading.Accept(p); msg(p,text) elseif a.Type=="TradeExchange" then ok,text=Trading.Exchange(p,Players:FindFirstChild(a.Target),a.Gems,a.PetId); msg(p,text) elseif a.Type=="Prompt" then ok,text=Monetization.Prompt(p,a.Kind,a.Key); msg(p,text) end end)
for _,p in ipairs(Players:GetPlayers()) do task.spawn(setup,p) end; Players.PlayerAdded:Connect(setup)
