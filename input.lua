local InputHandler = {}

local SceneLoader = require 'scene'

local scenehandle = {}
local ctrl = false

function love.keypressed(key, sc, isrepeat)
  if key == "lctrl" or key == "rctrl" then
    ctrl=true
  end
  if ctrl then key = "ctrl+"..key end

  SceneLoader.handlekeypress(key)
end

function love.keyreleased(key)
  if key == "lctrl" or key == "rctrl" then
    ctrl=false
  end
end

function love.mousepressed(x, y, button, istouch)
  SceneLoader.handlemousepress(x,y)
end

function love.mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
  SceneLoader.handlemousemove(x, y, dx, dy)
end

function love.wheelmoved(x, y)
  SceneLoader.handlewheelmove(y)
end

return InputHandler
