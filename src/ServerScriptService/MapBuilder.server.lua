local Workspace=game:GetService("Workspace")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Config=require(ReplicatedStorage.Shared.Config)
local root=Instance.new("Folder",Workspace); root.Name="SkyforgeMap"
local function part(name,size,pos,color,material)
 local x=Instance.new("Part"); x.Name=name; x.Size=size; x.Position=pos; x.Anchored=true; x.Color=color; x.Material=material or Enum.Material.SmoothPlastic; x.Parent=root; return x
end
part("Island",Vector3.new(240,4,240),Vector3.new(0,-2,20),Color3.fromRGB(55,110,75),Enum.Material.Grass)
for _,z in ipairs(Config.Zones) do
 local pad=part(z.Id.."Portal",Vector3.new(18,1,18),z.Position,z.Color,Enum.Material.Neon)
 local gui=Instance.new("BillboardGui",pad); gui.Size=UDim2.fromOffset(180,40); gui.StudsOffset=Vector3.new(0,5,0)
 local label=Instance.new("TextLabel",gui); label.Size=UDim2.fromScale(1,1); label.BackgroundTransparency=1; label.Text=z.Name; label.TextScaled=true; label.Font=Enum.Font.GothamBold; label.TextColor3=Color3.new(1,1,1)
end
part("Shop",Vector3.new(28,14,20),Vector3.new(-42,7,-20),Color3.fromRGB(255,170,80)); part("UpgradeHall",Vector3.new(28,14,20),Vector3.new(42,7,-20),Color3.fromRGB(90,180,255)); part("VIPLounge",Vector3.new(30,12,20),Vector3.new(-55,6,55),Color3.fromRGB(255,215,70)); part("LeaderboardTower",Vector3.new(18,24,18),Vector3.new(55,12,55),Color3.fromRGB(100,255,170))
for i=1,45 do local a=(i/45)*math.pi*2; local r=math.random(18,100); local c=part("Crystal",Vector3.new(2,4,2),Vector3.new(math.cos(a)*r,2,20+math.sin(a)*r),Color3.fromRGB(100,225,255),Enum.Material.Neon); c.Shape=Enum.PartType.Ball; c:SetAttribute("Crystal",true) end
