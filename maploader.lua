local MapLoader = {}

local loaded = {}

function MapLoader.load(filename)
  if not loaded[filename] then
    loaded[filename] = require("maps/"..filename)
  end

  return loaded[filename].load()
end

--[[
for i=1,14 do
  Map[i] = {}
  for j=1,10 do
    Map[i][j] = {basetile=0}
  end
end

function Map:new()
  m = {{}}
  setmetatable(m, self)
  self.__index = self
  return m
end

function Map:draw()
  for i=1,14 do
    for j=1,10 do
      if Map[i][j].basetile == 0 then
        love.graphics.draw(Sprites.tilespritesheet, Sprites.groundnormal, 320+(i-1)*64, 41+(j-1)*64)
      elseif Map[i][j].basetile == 1 then
        love.graphics.draw(Sprites.tilespritesheet, Sprites.grounddecor1, 320+(i-1)*64, 41+(j-1)*64)
      elseif Map[i][j].basetile == 2 then
        love.graphics.draw(Sprites.tilespritesheet, Sprites.grounddecor2, 320+(i-1)*64, 41+(j-1)*64)
      elseif Map[i][j].basetile == 3 then
        love.graphics.draw(Sprites.tilespritesheet, Sprites.grounddecor3, 320+(i-1)*64, 41+(j-1)*64)
      end
    end
  end
end
]]

return MapLoader
