local MarketplaceService=game:GetService("MarketplaceService")
local Config=require(game.ReplicatedStorage.Shared.Config)
local Data=require(script.Parent.DataService)
local S={}
function S.Prompt(p,kind,key) local id=Config[kind][key]; if not id or id==0 then return false,"Configure the ID in Config.lua" end; if kind=="Gamepasses" then MarketplaceService:PromptGamePassPurchase(p,id) else MarketplaceService:PromptProductPurchase(p,id) end; return true,"Purchase prompt opened" end
function S.Process(info)
 local p=game.Players:GetPlayerByUserId(info.PlayerId); if not p then return Enum.ProductPurchaseDecision.NotProcessedYet end; for key,id in pairs(Config.Products) do if info.ProductId==id and id~=0 then if key=="GemsSmall" then Data.Add(p,1000) elseif key=="GemsLarge" then Data.Add(p,7500) elseif key=="VIPBundle" then Data.Add(p,5000); p:SetAttribute("VIP",true) elseif key=="RebirthToken" then Data.Get(p).Rebirths+=1 end; return Enum.ProductPurchaseDecision.PurchaseGranted end end; return Enum.ProductPurchaseDecision.NotProcessedYet end
MarketplaceService.ProcessReceipt=S.Process
return S
