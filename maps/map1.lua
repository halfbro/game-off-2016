local Units = require "units"

local function load()
  Map1Data = {}

  Map1Data.map = {}
  for i=1,14 do
    Map1Data.map[i] = {}
    for j=1,10 do
      Map1Data.map[i][j] = {basetile=0}
    end
  end

  Map1Data.units = List:new()

  Map1Data.units:insert_back(Units.ayylmao:new(9,4))
  Map1Data.units:insert_back(Units.ayylmao:new(8,6))
  Map1Data.units:insert_back(Units.ayylmao:new(9,7))

  Map1Data.entrypoints = {
    {x=5, y=4},
    {x=5, y=7},
  }

  return Map1Data
end

return {
  load = load
}

