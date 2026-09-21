local Config=require(game.ReplicatedStorage.Shared.Config)
local Data=require(script.Parent.DataService)
local S={}
function S.Hatch(p,eggName)
 local egg=Config.Eggs[eggName]; if not egg then return false,"Egg not found" end; if not Data.Spend(p,egg.Price) then return false,"Not enough Gems" end
 local total=0; for _,x in ipairs(egg.Pets) do total+=x.Weight end; local roll=math.random()*total; local chosen=egg.Pets[1]; for _,x in ipairs(egg.Pets) do roll-=x.Weight; if roll<=0 then chosen=x; break end end
 local d=Data.Get(p); local uid=chosen.Id.."_"..math.random(100000,999999); d.Pets[uid]={Id=chosen.Id,Power=chosen.Power}; return true,"Hatched "..chosen.Id,uid end
function S.Equip(p,uid)
 local d=Data.Get(p); if not d.Pets[uid] then return false,"Pet not found" end; for _,x in ipairs(d.Equipped) do if x==uid then return false,"Already equipped" end end; if #d.Equipped>=3 then return false,"Equip limit reached" end; table.insert(d.Equipped,uid); return true,"Pet equipped" end
function S.Unequip(p,uid) local d=Data.Get(p); for i,x in ipairs(d.Equipped) do if x==uid then table.remove(d.Equipped,i); return true,"Pet unequipped" end end return false,"Not equipped" end
function S.Multiplier(p) local d=Data.Get(p); local m=1+d.Rebirths*.25; for _,uid in ipairs(d.Equipped) do m+=d.Pets[uid].Power end; return m end
return S
