local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local function remote(className,name)
  local r=Instance.new(className); r.Name=name; r.Parent=Remotes; return r
end
remote("RemoteFunction","GetState")
remote("RemoteEvent","Action")
remote("RemoteEvent","Notify")
remote("RemoteEvent","TradeEvent")
