local Units = require "units"


local function load()
  t = {}

  t.map = {}
  for i=3,12 do
    t.map[i] = {}
    for j=2,9 do
      t.map[i][j] = {basetile=0}
    end
  end

  t.units = List:new()

  t.units:insert_back(Units.ayylmao:new(5,4))
  t.units:insert_back(Units.ayylmao:new(6,6))
  t.units:insert_back(Units.ayylmao:new(5,7))

  return t
end

return {
  load = load
}

