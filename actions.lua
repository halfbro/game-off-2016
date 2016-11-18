local Actions = {}

local List = require 'lib/linkedlist'

function Actions.moveunit(unit, direction, scene)

  if unit.movesleft == 0 then return false end

  for other in scene.units:iter() do
    if unit ~= other.val then
      for node in other.val.nodes:iter() do
        if direction == "up" then
          if not scene.map[unit.mapx] or not scene.map[unit.mapx][unit.mapy-1] then return false end
          if scene.map[other.val.mapx][other.val.mapy-1].basetile < 0 then return false end
          if node.val.x == unit.mapx and node.val.y == unit.mapy - 1 then return false end
        elseif direction == "down" then
          if not scene.map[unit.mapx] or not scene.map[unit.mapx][unit.mapy+1] then return false end
          if scene.map[other.val.mapx][other.val.mapy+1].basetile < 0 then return false end
          if node.val.x == unit.mapx and node.val.y == unit.mapy + 1 then return false end
        elseif direction == "right" then
          if not scene.map[unit.mapx+1] or not scene.map[unit.mapx+1][unit.mapy] then return false end
          if scene.map[other.val.mapx+1][other.val.mapy].basetile < 0 then return false end
          if node.val.x == unit.mapx + 1 and node.val.y == unit.mapy then return false end
        elseif direction == "left" then
          if not scene.map[unit.mapx-1] or not scene.map[unit.mapx-1][unit.mapy] then return false end
          if scene.map[other.val.mapx-1][other.val.mapy].basetile < 0 then return false end
          if node.val.x == unit.mapx - 1 and node.val.y == unit.mapy then return false end
        end
      end
    end
  end

  local oldvals = {}
  oldvals.movesleft = unit.movesleft
  oldvals.mapx = unit.mapx
  oldvals.mapy = unit.mapy
  oldvals.nodes = List:new()
  for node in unit.nodes:iter() do
    oldvals.nodes:insert_back({ x=node.val.x,
                                y=node.val.y,
                                connections={
                                  up=node.val.connections.up,
                                  right=node.val.connections.right,
                                  down=node.val.connections.down,
                                  left=node.val.connections.left
                                }
                              })
  end

  local actiondescriptor = {
    u = unit,
    d = direction,
    undo = function()
      unit.movesleft = oldvals.movesleft
      unit.mapx = oldvals.mapx
      unit.mapy = oldvals.mapy
      unit.nodes = oldvals.nodes
    end,
  }

  unit:move(direction)
  return true, actiondescriptor
end

return Actions
