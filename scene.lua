local SceneLoader = {}

local MapLoader = require 'maploader'
local Actions = require 'actions'
local List = require 'lib/linkedlist'
local UI = require 'ui'

local Scene = {}
local currentscene = {}

function Scene.nextturn()
  if currentscene.turn == 0 then
    for _,v in pairs(currentscene.entrypoints) do
      if v.unit then
        currentscene.units:insert_back(v.unit:new(v.x, v.y))
      end
    end
  end
  currentscene.turn = currentscene.turn + 1
  for u in currentscene.units:iter() do
    u.val.movesleft = u.val.maxmoves
    u.val.hasacted = false
  end
  currentscene.actionstaken = List:new()

  --AI.move(currentscene)
end

function Scene:drawattackrange()
  UI:drawattackrange(self.selected.mapx, self.selected.mapy, self.currentability.range)
end

function Scene:draw()
  -- s.background:draw()
  if self.map then self.map:draw() end
  if self.turn == 0 then
    self.map:drawentrypoints(self.entrypoints)
  end
  if self.units then 
    for it in self.units:iter() do
      it.val:draw()
    end
  end
  if UI then UI:draw() end
  if self.currentability and self.selected then
    self:drawattackrange()
  end
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
    UI:showunittray()
    return
  elseif key == "ctrl+2" then
    SceneLoader.loadscene("map2")
    UI:showunittray()
    return
  end

  if animating then return end

  if key == "space" then
    Scene.nextturn()
    return
  end

  if key == "1" or key == "2" then
    if currentscene.selected then
      if key == "1" and currentscene.selected.abilities[1] then
        currentscene.currentability = currentscene.selected.abilities[1]
      elseif key == "2" and currentscene.selected.abilities[2] then
        currentscene.currentability = currentscene.selected.abilities[2]
      end
    end
  end

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
  local ux, uy
  for unit in currentscene.units:iter() do
    for node in unit.val.nodes:iter() do
      ux, uy = node.val.x, node.val.y
      local lbx, ubx, lby, uby
      lbx = 320+(ux-1)*64
      ubx = 320+(ux)*64
      lby = 41+(uy-1)*64
      uby = 41+(uy)*64
      if lbx < x and x < ubx then
        if lby < y and y < uby then
          unitclicked = unit.val
          break
        end
      end
    end
    if unitclicked then break end
  end

  if currentscene.currentability and currentscene.selected then
    if math.abs(currentscene.selected.mapx - ux + currentscene.selected.mapy - uy) <= currentscene.currentability.range then
      success, actiondesc = Actions.attack(currentscene.selected, unitclicked, currentscene.currentability)
      if success then
        currentscene.actionstaken:insert_back(actiondesc)
      end
    end
  end

  if unitclicked then
    currentscene.currentability = nil

    if currentscene.selected then
      currentscene.selected.selected = false
    end
    currentscene.selected = unitclicked
    unitclicked.selected = true
    if currentscene.turn > 0 then UI:showunit(unitclicked) end
  else
    if currentscene.selected then
      currentscene.selected.selected = false
    end
    currentscene.selected = nil
    if not UI:handlemousepress(x, y) and currentscene.turn > 0 then
      UI:clear()
    end
  end


  if currentscene.turn == 0 then
    for _,v in pairs(currentscene.entrypoints) do
      local ux, uy = v.x, v.y
      local lbx, ubx, lby, uby
      lbx = 320+(ux-1)*64
      ubx = 320+(ux)*64
      lby = 41+(uy-1)*64
      uby = 41+(uy)*64
      if lbx < x and x < ubx then
        if lby < y and y < uby then
          v.unit = UI:gettrayunit()
          break
        end
      end
    end
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
  currentscene.currentability = nil
  currentscene.animating = false
  currentscene.actionstaken = List:new() -- Start focusing on this
  currentscene.turn = 0

  setmetatable(currentscene, Scene)
  Scene.__index = Scene

  return currentscene
end

return SceneLoader
