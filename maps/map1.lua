local Map1 = {}

for i=1,14 do
  Map1[i] = {}
  for j=1,10 do
    Map1[i][j] = {basetile=0}
  end
end

local function load()
  t = {}
  setmetatable(t,Map1)
  Map1.__index = Map1
  return t
end

return {
  load = load
}

