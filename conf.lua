function love.conf(t)
  t.identity = saves
  t.version = "0.10.2"

  t.window.width = 1024
  t.window.height = 1024
  t.window.title = GameOffGame
  t.window.resizable = false
  t.window.fullscreen = false
  t.window.msaa = 1

  t.modules.joystick = false
  t.modules.video = false
end
