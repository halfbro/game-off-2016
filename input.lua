local InputHandler = {}

local scenehandle = {}
local ctrl = false

function InputHandler.updatescene(scene)
  scenehandle = scene
end

function love.keypressed(key, sc, isrepeat)
  if key == "lctrl" or key == "rctrl" then
    ctrl=true
  end
  
  if ctrl then key = "ctrl+"..key end
  scenehandle:handlekeypress(key)
end

function love.keyreleased(key)
  if key == "lctrl" or key == "rctrl" then
    ctrl=false
  end
end

return InputHandler
