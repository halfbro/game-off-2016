MapLoader = require 'maploader'
Sprites = require 'spritesheets'
TestGameunit = require 'gameunit'

function love.load()
  love.keyboard.setKeyRepeat(false)
  print('hello world :)')
  
  test = TestGameunit:new()
  test.name = "Meme"
  test.desc = "Some kind of sick joke"
  test.powerlevel = 1
  test.alignment = 0
  test.maxmoves = 3
  test.movesleft = test.maxmoves
  test.defense = 0
  test.maxsize=4
  test.abilities = {ayy=0} -- {ayy=Abilities.ayy}
  test.selectedability=nil
  test.mapx=2
  test.mapy=2
  test.selected = true
  test.hasmoved = false
  test.nodes:insert_front({x=2,y=2,connections={right=false,down=false}})
  test.sprite = Sprites.ayy
  test.tileset = Sprites.bluetile
end

function love.draw()
  --Map.firstmap:draw()
  test:draw()
end

function love.update(dt)
end
