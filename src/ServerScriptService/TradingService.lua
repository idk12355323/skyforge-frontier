local Players=game:GetService("Players")
local Data=require(script.Parent.DataService)
local S={Pending={}}
function S.Request(p,target) if target==p then return false,"Invalid target" end; if not Players:FindFirstChild(target.Name) then return false,"Player left" end; S.Pending[target.UserId]={From=p,To=target,Offer={},Expires=os.clock()+30}; return true,"Trade request sent" end
function S.Accept(p)
 local t=S.Pending[p.UserId]; if not t or t.Expires<os.clock() then return false,"No active trade" end; S.Pending[p.UserId]=nil; t.From:SetAttribute("TradingWith",p.Name); p:SetAttribute("TradingWith",t.From.Name); return true,"Trade opened" end
function S.Exchange(p,target,gems,petId)
 if p:GetAttribute("TradingWith")~=target.Name or target:GetAttribute("TradingWith")~=p.Name then return false,"Trade not open" end; gems=math.max(0,math.floor(tonumber(gems) or 0)); local a,b=Data.Get(p),Data.Get(target); if a.Gems<gems then return false,"Insufficient Gems" end; if petId and not a.Pets[petId] then return false,"Pet not owned" end; a.Gems-=gems; b.Gems+=gems; if petId then a.Pets[petId],b.Pets[petId]=nil,a.Pets[petId] end; p:SetAttribute("TradingWith",nil); target:SetAttribute("TradingWith",nil); Data.Sync(p); Data.Sync(target); return true,"Trade completed" end
return S
