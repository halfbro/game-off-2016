local UI = {}

local Sprites = require 'spritesheets'
local List = require 'lib/linkedlist'
local Units = require 'units'

UI.uisheet = love.graphics.newImage("assets/UI.png")

UI.mainbg = love.graphics.newQuad(64*0, 64*0, 64*5, 16+64*11, UI.uisheet:getDimensions())
UI.traybg = love.graphics.newQuad(64*5, 64*0, 64*5, 16+64*6, UI.uisheet:getDimensions())

UI.static = love.graphics.newCanvas(320,720)

UIElement = {}
function UIElement:draw(x, y)
end

function UIElement:handlemousepress(x, y)
  for child in self.children:iter() do
    if child.val:handlemousepress(x, y) then return true end
  end
  return false
end

function UIElement:handlemousescroll(dy)
  for child in self.children:iter() do
    if child.val:handlemousescroll(dy) then return true end
  end
  return false
end

function UIElement:new()
  e = {enabled=false}
  setmetatable(e, self)
  self.__index = self
  return e
end

------- TrayElement

TrayElement = {}

function TrayElement:draw(y)
  if self.selected then
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 69, 0, 255)
    love.graphics.rectangle("fill", 2, 0, 254, 96)
    love.graphics.setColor(r,g,b,a)
  end
  love.graphics.draw(Sprites.tilespritesheet, self.unit.tileset.tile, 16, 16+y)
  love.graphics.draw(Sprites.tilespritesheet, self.unit.sprite, 16, 16+y)
  love.graphics.print(self.unit.name, 96, 30+y)
  love.graphics.print(self.unit.desc, 96, 42+y)
end

function TrayElement:new(unit)
  i = {height=96, selected=false, unit = unit}
  setmetatable(i, self)
  self.__index = self
  return i
end

-------- Tray

Tray = UIElement:new()
Tray.yposition = 0
Tray.maxy = 0
Tray.trayitems = List:new()
Tray.trayitems:insert_back(TrayElement:new(Units.ayylmao))

function Tray:draw()
  love.graphics.draw(UI.uisheet, UI.traybg, 0, 0)

  love.graphics.push()
  love.graphics.translate(32,32)
  love.graphics.setScissor(32, 32, 64*3, 64*5+32)

  local nexty = 0
  for element in self.trayitems:iter() do
    element.val:draw(nexty + self.yposition)
    nexty = nexty + element.val.height
  end
  love.graphics.setScissor()
  self.maxy = nexty

  love.graphics.pop()
end

function Tray:handlemousescroll(dy)
  self.yposition = self.yposition - dy
  self.yposition = math.max(self.yposition,0)
  self.yposition = math.min(self.yposition,self.maxy)
  return true
end

function Tray:handlemousepress(x, y)

end


---------- UI State Data ----------

UI.mode = "tray"
UI.currunit = nil

function UI:draw()
  UI.static:renderTo(function ()
    love.graphics.draw(UI.uisheet, UI.mainbg, 0, 0)
  end)

  love.graphics.draw(self.static, 0, 0)
  if self.mode == "tray" then
    Tray:draw()
  end
end

function UI:showunittray()
  self.mode = "tray"
end

function UI:showunit(unit)
  self.mode = "unit"
  self.currunit = unit
end

function UI:showblank()
  self.mode = "blank"
end

function UI:handlemousescroll(dy)
  Tray:handlemousescroll(8*dy)
end

return UI
