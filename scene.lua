local SceneLoader = {}

local MapLoader = require 'maploader'
local Actions = require 'actions'
local InputHandler = require 'input'
local List = require 'lib/linkedlist'

local Scene = {}

function Scene:draw()
  -- s.background:draw()
  if self.map then self.map:draw() end
  if self.units then 
    for it in self.units:iter() do
      it.val:draw()
    end
  end
  -- s.ui.draw()
  -- etc etc
end

function Scene:update(dt)
  -- s.background:update(dt)
  -- s.map.update(dt)
  -- s.units:update(dt)
  -- s.ui.update(dt)
end

function Scene:handlekeypress(key)
  if animating then return end

  local success, actiondesc
  if key=="ctrl+z" then
    self.actionstaken.tail.val.undo()
    self.actionstaken:remove_back()
  elseif key=="up" then
    --if not self.selected then return end
    success, actiondesc = Actions.moveunit(self.units.head.val, "up", self)
  elseif key=="right" then
    --if not self.selected then return end
    success, actiondesc = Actions.moveunit(self.units.head.val, "right", self)
  elseif key=="down" then
    --if not self.selected then return end
    success, actiondesc = Actions.moveunit(self.units.head.val, "down", self)
  elseif key=="left" then
    --if not self.selected then return end
    success, actiondesc = Actions.moveunit(self.units.head.val, "left", self)
  end

  if success then
    self.actionstaken:insert_back(actiondesc)
  end
end


function SceneLoader.loadscene(filename)
  local scene = {}
  scene.name = filename
  scene.map, scene.units = MapLoader.load(filename)
  scene.selected = nil
  scene.animating = false
  scene.actionstaken = List:new() -- Start focusing on this

  setmetatable(scene, Scene)
  Scene.__index = Scene

  InputHandler.updatescene(scene)
  return scene
end

return SceneLoader

