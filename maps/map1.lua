local Units = require "units"

local function load()
  local Map1Data = {}

  Map1Data.map = {}
  for i=1,14 do
    Map1Data.map[i] = {}
    for j=1,10 do
      Map1Data.map[i][j] = {basetile=0}
    end
  end

  Map1Data.units = List:new()

  Map1Data.entrypoints = {
    {x=5, y=4},
    {x=5, y=5},
    {x=5, y=6},
    {x=5, y=7},
    {x=10, y=4},
    {x=10, y=5},
    {x=10, y=6},
    {x=10, y=7},
  }

  return Map1Data
end

return {
  load = load
}

