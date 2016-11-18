local SceneLoader = {}

local MapLoader = require 'maploader'
local Actions = require 'actions'
local List = require 'lib/linkedlist'
local UI = require 'ui'

local Scene = {}
local currentscene = {}

function Scene:draw()
  -- s.background:draw()
  if self.map then self.map:draw() end
  if self.units then 
    for it in self.units:iter() do
      it.val:draw()
    end
  end
  if UI then UI:draw() end
end

function Scene:update(dt)
  -- s.background:update(dt)
  -- s.map.update(dt)
  -- s.units:update(dt)
  -- s.ui.update(dt)
end

function SceneLoader.handlekeypress(key)
  if key == "ctrl+1" then
    SceneLoader.loadscene("map1")
    return
  end

  if animating then return end

  local success, actiondesc
  if key=="ctrl+z" then
    if currentscene.actionstaken.head then
      currentscene.actionstaken.tail.val.undo()
      currentscene.actionstaken:remove_back()
    end
  elseif key=="up" then
    if currentscene.selected then
      success, actiondesc = Actions.moveunit(currentscene.selected, "up", currentscene)
    end
  elseif key=="right" then
    if currentscene.selected then
      success, actiondesc = Actions.moveunit(currentscene.selected, "right", currentscene)
    end
  elseif key=="down" then
    if currentscene.selected then
      success, actiondesc = Actions.moveunit(currentscene.selected, "down", currentscene)
    end
  elseif key=="left" then
    if currentscene.selected then
      success, actiondesc = Actions.moveunit(currentscene.selected, "left", currentscene)
    end
  end

  if success then
    currentscene.actionstaken:insert_back(actiondesc)
  end
end

function SceneLoader.handlemousemove(x, y, dx, dy)
  
end

function SceneLoader.handlewheelmove(dy)
  UI:handlemousescroll(dy)
end

function SceneLoader.handlemousepress(x, y)
  local unitclicked = nil
  for unit in currentscene.units:iter() do
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
    if currentscene.selected then
      currentscene.selected.selected = false
    end
    currentscene.selected = unitclicked
    unitclicked.selected = true
    --UI:showunit(unitclicked)
  else
    if currentscene.selected then
      currentscene.selected.selected = false
    end
    currentscene.selected = nil
    --UI:clear()
  end
end

function SceneLoader.draw()
  currentscene:draw()
end

function SceneLoader.update(dt)
  currentscene:update(dt)
end


function SceneLoader.loadscene(filename)
  currentscene = {}
  currentscene.name = filename
  currentscene.map, currentscene.units, currentscene.entrypoints = MapLoader.load(filename)
  currentscene.selected = nil
  currentscene.animating = false
  currentscene.actionstaken = List:new() -- Start focusing on this
  currentscene.turn = 0

  setmetatable(currentscene, Scene)
  Scene.__index = Scene

  return currentscene
end

return SceneLoader
