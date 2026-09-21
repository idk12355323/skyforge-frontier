local Config = {}
Config.DataStoreName = "SkyforgeFrontier_v3"
Config.Currency = "Gems"
Config.AdminUserIds = { 123456789 } -- replace with your UserId
Config.Gamepasses = { VIP = 0, Lucky = 0, AutoCollect = 0 }
Config.Products = { GemsSmall = 0, GemsLarge = 0, VIPBundle = 0, RebirthToken = 0 }
Config.Codes = { SKYFORGE = 500, FRIENDSHIP = 750, LAUNCH = 1000 }
Config.Upgrades = {
  Power = {Base=100, Growth=1.45, Max=25}, Capacity = {Base=150, Growth=1.5, Max=25}, Luck = {Base=250, Growth=1.65, Max=20}, Speed = {Base=180, Growth=1.45, Max=15}
}
Config.Eggs = {
  Meadow = {Price=250, Pets={{Id="Sprout",Weight=60,Power=1.2},{Id="Fox",Weight=30,Power=2.1},{Id="Aurora",Weight=9,Power=4},{Id="Dragon",Weight=1,Power=12}}},
  Crystal = {Price=1500, Pets={{Id="Moth",Weight=55,Power=3},{Id="Golem",Weight=32,Power=6},{Id="Phoenix",Weight=11,Power=12},{Id="Voidling",Weight=2,Power=30}}},
  Mythic = {Price=7500, Pets={{Id="Starwhale",Weight=60,Power=15},{Id="Celestial",Weight=30,Power=30},{Id="Eclipse",Weight=9,Power=60},{Id="Cosmos",Weight=1,Power=150}}}
}
Config.Zones = {
  {Id="Spawn",Name="Skyport Plaza",Price=0,Position=Vector3.new(0,3,0),Color=Color3.fromRGB(80,150,255)},
  {Id="Meadow",Name="Glow Meadow",Price=500,Position=Vector3.new(0,3,-70),Color=Color3.fromRGB(90,220,130)},
  {Id="Crystal",Name="Crystal Cavern",Price=2500,Position=Vector3.new(75,3,25),Color=Color3.fromRGB(100,225,255)},
  {Id="Ember",Name="Ember Ridge",Price=7500,Position=Vector3.new(-75,3,25),Color=Color3.fromRGB(255,105,75)},
  {Id="Mythic",Name="Mythic Overlook",Price=20000,Position=Vector3.new(0,3,90),Color=Color3.fromRGB(210,120,255)}
}
return Config
