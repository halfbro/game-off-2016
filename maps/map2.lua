local Map2Data = {}

Map2Data.map = {}
Map2Data.units = List:new()

for i=1,14 do
  Map2Data.map[i] = {}
  for j=1,10 do
    Map2Data.map[i][j] = {basetile=1}
  end
end

local function load()
  t = {}
  setmetatable(t,Map2Data)
  Map2Data.__index = Map2Data
  return t
end

return {
  load = load,
}
