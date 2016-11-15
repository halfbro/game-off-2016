local Sprites = require "spritesheets"
local TestGameunit = require "gameunit"
local TestNode = require "node"

local Map = {}

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

local map1 = Map:new()

function love.keypressed(_, sc, __)
  test:move(sc);
end

return {
  firstmap = map1,
}
