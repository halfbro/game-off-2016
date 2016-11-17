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
    if self.actionstaken.head then
      self.actionstaken.tail.val.undo()
      self.actionstaken:remove_back()
    end
  elseif key=="up" then
    if self.selected then
      success, actiondesc = Actions.moveunit(self.selected, "up", self)
    end
  elseif key=="right" then
    if self.selected then
      success, actiondesc = Actions.moveunit(self.selected, "right", self)
    end
  elseif key=="down" then
    if self.selected then
      success, actiondesc = Actions.moveunit(self.selected, "down", self)
    end
  elseif key=="left" then
    if self.selected then
      success, actiondesc = Actions.moveunit(self.selected, "left", self)
    end
  end

  if success then
    self.actionstaken:insert_back(actiondesc)
  end
end

function Scene:handlemousepress(x, y)
  local unitclicked = nil
  for unit in self.units:iter() do
    for node in unit.val.nodes:iter() do
      local lbx, ubx, lby, uby
      lbx = 320+(node.val.x-1)*64
      ubx = 320+(node.val.x)*64
      lby = 41+(node.val.y-1)*64
      uby = 41+(node.val.y)*64
      if lbx < x and x < ubx then
        if lby < y and y < uby then
          unitclicked = unit.val
          break
        end
      end
    end
    if unitclicked then break end
  end

  if unitclicked then
    self.selected = unitclicked
  else
    self.selected = nil
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
