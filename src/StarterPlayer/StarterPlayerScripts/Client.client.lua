local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local TweenService=game:GetService("TweenService")
local p=Players.LocalPlayer; local R=ReplicatedStorage:WaitForChild("Remotes"); local gui=Instance.new("ScreenGui",p:WaitForChild("PlayerGui")); gui.Name="SkyforgeUI"; gui.ResetOnSpawn=false
local panel=Instance.new("Frame",gui); panel.Size=UDim2.fromOffset(360,520); panel.Position=UDim2.new(0,18,.5,-260); panel.BackgroundColor3=Color3.fromRGB(20,28,45); Instance.new("UICorner",panel).CornerRadius=UDim.new(0,16)
local title=Instance.new("TextLabel",panel); title.Size=UDim2.new(1,0,0,48); title.Text="SKYFORGE FRONTIER"; title.TextColor3=Color3.fromRGB(255,220,90); title.TextScaled=true; title.Font=Enum.Font.GothamBlack; title.BackgroundTransparency=1
local gems=Instance.new("TextLabel",panel); gems.Position=UDim2.fromOffset(15,52); gems.Size=UDim2.new(1,-30,0,30); gems.TextColor3=Color3.new(1,1,1); gems.TextScaled=true; gems.BackgroundTransparency=1
local body=Instance.new("ScrollingFrame",panel); body.Position=UDim2.fromOffset(12,88); body.Size=UDim2.new(1,-24,1,-100); body.BackgroundTransparency=1; body.CanvasSize=UDim2.new(); body.AutomaticCanvasSize=Enum.AutomaticSize.Y; local list=Instance.new("UIListLayout",body); list.Padding=UDim.new(0,7)
local function button(text,callback) local b=Instance.new("TextButton",body); b.Size=UDim2.new(1,0,0,36); b.Text=text; b.TextColor3=Color3.new(1,1,1); b.TextSize=16; b.Font=Enum.Font.GothamBold; b.BackgroundColor3=Color3.fromRGB(47,67,100); Instance.new("UICorner",b).CornerRadius=UDim.new(0,9); b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(.12),{BackgroundColor3=Color3.fromRGB(70,105,160)}):Play() end); b.MouseButton1Click:Connect(callback); return b end
local function notify(t) local x=Instance.new("TextLabel",gui); x.Size=UDim2.fromOffset(300,45); x.Position=UDim2.new(.5,-150,0.08,0); x.Text=t; x.TextScaled=true; x.TextColor3=Color3.new(1,1,1); x.BackgroundColor3=Color3.fromRGB(36,150,110); Instance.new("UICorner",x).CornerRadius=UDim.new(0,10); task.delay(2,function() x:Destroy() end) end
local function input(placeholder) local x=Instance.new("TextBox",body); x.Size=UDim2.new(1,0,0,36); x.PlaceholderText=placeholder; x.Text=""; x.TextColor3=Color3.new(1,1,1); x.BackgroundColor3=Color3.fromRGB(35,45,65); Instance.new("UICorner",x).CornerRadius=UDim.new(0,8); return x end
local function refresh() local d=R.GetState:InvokeServer(); gems.Text="Gems: "..d.Gems.."   Rebirths: "..d.Rebirths end
local function act(t,x) R.Action:FireServer({Type=t,Name=x}) end
button("COLLECT CRYSTAL",function() act("Collect"); refresh() end)
button("DAILY REWARD",function() act("Daily"); refresh() end)
button("HATCH MEADOW EGG (250)",function() act("Hatch","Meadow"); refresh() end)
button("HATCH CRYSTAL EGG (1500)",function() act("Hatch","Crystal"); refresh() end)
button("HATCH MYTHIC EGG (7500)",function() act("Hatch","Mythic"); refresh() end)
for _,n in ipairs({"Power","Capacity","Luck","Speed"}) do button("UPGRADE "..n,function() act("Upgrade",n); refresh() end) end
button("REBIRTH",function() act("Rebirth"); refresh() end)
for _,z in ipairs({"Spawn","Meadow","Crystal","Ember","Mythic"}) do button("TRAVEL / UNLOCK "..z,function() act("Zone",z); refresh() end) end
for _,e in ipairs({"Sprout","Fox","Aurora","Dragon","Moth","Golem","Phoenix","Voidling"}) do end
local code=input("Code: SKYFORGE"); button("REDEEM CODE",function() R.Action:FireServer({Type="Redeem",Code=code.Text}); refresh() end)
button("VIP GAMEPASS",function() R.Action:FireServer({Type="Prompt",Kind="Gamepasses",Key="VIP"}) end)
button("LARGE GEM PRODUCT",function() R.Action:FireServer({Type="Prompt",Kind="Products",Key="GemsLarge"}) end)
local trade=input("Target player name"); button("TRADE REQUEST",function() R.Action:FireServer({Type="TradeRequest",Target=trade.Text}) end); button("ACCEPT TRADE",function() R.Action:FireServer({Type="TradeAccept"}) end)
R.Notify.OnClientEvent:Connect(notify); refresh()
