local Config=require(game.ReplicatedStorage.Shared.Config)
local Data=require(script.Parent.DataService)
local S={}
function S.Price(name,level) local c=Config.Upgrades[name]; return math.floor(c.Base*c.Growth^level) end
function S.Buy(p,name)
 local d=Data.Get(p); local c=Config.Upgrades[name]; if not c then return false,"Unknown upgrade" end; local l=d[name] or 0; if l>=c.Max then return false,"Max level" end; local price=S.Price(name,l); if not Data.Spend(p,price) then return false,"Not enough Gems" end; d[name]=l+1; return true,name.." upgraded" end
function S.Rebirth(p)
 local d=Data.Get(p); local need=math.floor(5000*(1.8^d.Rebirths)); if d.Gems<need then return false,"Need "..need.." Gems" end; d.Gems=0; d.Rebirths+=1; d.Power=0; d.Capacity=0; d.Luck=0; d.Speed=0; d.Zones={Spawn=true}; Data.Sync(p); return true,"Rebirth complete!" end
return S
