local SceneLoader = require 'scene'
local Sprites = require 'spritesheets'
local TestGameunit = require 'gameunit'

local fps = 0

function love.load()
  love.keyboard.setKeyRepeat(true)
  print('hello world :)')

  scene = SceneLoader.loadscene("map1")
end

function love.draw()
  scene:draw()

  love.graphics.print(fps)
end

function love.update(dt)
  scene:update(dt)
  fps = 1/dt
end
