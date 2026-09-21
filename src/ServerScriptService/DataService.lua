local Players=game:GetService("Players")
local DataStoreService=game:GetService("DataStoreService")
local Config=require(game.ReplicatedStorage.Shared.Config)
local Store=DataStoreService:GetDataStore(Config.DataStoreName)
local Service={Cache={}}
local function defaults()
 return {Gems=0,Rebirths=0,XP=0,Level=1,Power=0,Capacity=0,Luck=0,Speed=0,Pets={},Equipped={},Zones={Spawn=true},Codes={},Daily={Day=0,Streak=0},Settings={Music=true,SFX=true}}
end
local function merge(dst,src) for k,v in pairs(src or {}) do if type(v)=="table" and type(dst[k])=="table" then merge(dst[k],v) else dst[k]=v end end end
function Service.Load(p)
 local d=defaults(); local ok,s=pcall(function() return Store:GetAsync("p_"..p.UserId) end); if ok and s then merge(d,s) end; Service.Cache[p]=d; return d
end
function Service.Get(p) return Service.Cache[p] end
function Service.Save(p)
 local d=Service.Cache[p]; if not d then return end
 local ok,e=pcall(function() Store:UpdateAsync("p_"..p.UserId,function() return d end) end); if not ok then warn("Save failed",p,e) end
end
function Service.Add(p,n) local d=Service.Get(p); d.Gems=math.max(0,d.Gems+n); Service.Sync(p); return d.Gems end
function Service.Spend(p,n) local d=Service.Get(p); if d.Gems<n then return false end; d.Gems-=n; Service.Sync(p); return true end
function Service.Sync(p)
 local d=Service.Get(p); p:SetAttribute("Gems",d.Gems); p:SetAttribute("Rebirths",d.Rebirths); local ls=p:FindFirstChild("leaderstats"); if ls then ls.Gems.Value=d.Gems; ls.Rebirths.Value=d.Rebirths end
end
Players.PlayerRemoving:Connect(function(p) Service.Save(p); Service.Cache[p]=nil end)
task.spawn(function() while task.wait(120) do for p in pairs(Service.Cache) do Service.Save(p) end end end)
return Service
