local Units = require "units"

local function load()
  local Map2Data = {}

  Map2Data.map = {}
  for i=1,14 do
    Map2Data.map[i] = {}
    for j=1,10 do
      Map2Data.map[i][j] = {basetile=0}
      if math.abs(i-7.5)<=math.abs(j-5.5) then
        Map2Data.map[i][j] = {basetile=1}
      end
      if math.abs(i-7.5)+1<=math.abs(j-5.5) then
        Map2Data.map[i][j] = nil
      end
    end
  end

  Map2Data.units = List:new()

  Map2Data.entrypoints = {
    {x=4, y=4},
    {x=4, y=7},
    {x=11, y=4},
    {x=11, y=7},
  }

  return Map2Data
end

return {
  load = load
}

