local InputHandler = require 'input'
local SceneLoader = require 'scene'
local Sprites = require 'spritesheets'
local TestGameunit = require 'gameunit'

local fps = 0

function love.load()
  print('')
  print('Start loading main game')
  love.keyboard.setKeyRepeat(false)

  SceneLoader.loadscene("map1")
  print('hello world :)')
end

function love.draw()
  SceneLoader.draw()

  love.graphics.print(fps, 0, 0)
end

function love.update(dt)
  SceneLoader.update(dt)
  fps = 1/dt
end
