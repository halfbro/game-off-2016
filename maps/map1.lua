local Units = require "units"

local function load()
  Map1Data = {}

  Map1Data.map = {}
  for i=3,12 do
    Map1Data.map[i] = {}
    for j=2,9 do
      Map1Data.map[i][j] = {basetile=0}
    end
  end

  Map1Data.units = List:new()

  Map1Data.units:insert_back(Units.ayylmao:new(5,4))
  Map1Data.units:insert_back(Units.ayylmao:new(6,6))
  Map1Data.units:insert_back(Units.ayylmao:new(5,7))

  return Map1Data
end

return {
  load = load
}

