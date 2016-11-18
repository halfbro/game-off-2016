local Gameunit = require 'gameunit'
local Abilities = require 'abilities'
local Sprites = require 'spritesheets'
local List = require 'lib/linkedlist'

local AyyLmao = Gameunit:new()
AyyLmao.name = "AyyLmao"
AyyLmao.desc = "Drowns them in memes"
AyyLmao.powerlevel = 1
AyyLmao.alignment = 1
AyyLmao.abilities = {
  Abilities.Ayy,
  Abilities.Lmao
}
AyyLmao.sprite = Sprites.ayy
AyyLmao.tileset = Sprites.bluetile

function AyyLmao:new(mapx, mapy)
  local g = {}
  g.maxmoves = 2
  g.movesleft = 2
  g.defense = 0
  g.maxsize = 4

  g.selected = false
  g.hasacted = false

  g.mapx = mapx
  g.mapy = mapy
  g.nodes = List:new()
  g.nodes:insert_front({x=mapx, y=mapy, connections={}})
  setmetatable(g, self)
  self.__index = self
  return g
end

return {
  ayylmao = AyyLmao,
}
