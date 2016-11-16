local Map2 = {}

for i=1,14 do
  Map2[i] = {}
  for j=1,10 do
    Map2[i][j] = {basetile=1}
  end
end

local function load()
  t = {}
  setmetatable(t,Map2)
  Map2.__index = Map2
  return t
end

return {
  load = load
}
