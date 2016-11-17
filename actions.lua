local Actions = {}

local List = require 'lib/linkedlist'

function Actions.moveunit(unit, direction, scene)
  for other in scene.units:iter() do
    if unit ~= other.val then
      for node in other.val.nodes:iter() do
        if direction == "up" then
          if not scene.map[other.val.mapx][other.val.mapy-1] then return false, nil end
          if node.val.x == unit.mapx and node.val.y == unit.mapy - 1 then
            return false, nil
          end
        elseif direction == "down" then
          if not scene.map[other.val.mapx][other.val.mapy+1] then return false, nil end
          if node.val.x == unit.mapx and node.val.y == unit.mapy + 1 then
            return false, nil
          end
        elseif direction == "right" then
          if not scene.map[other.val.mapx+1][other.val.mapy] then return false, nil end
          if node.val.x == unit.mapx + 1 and node.val.y == unit.mapy then
            return false, nil
          end
        elseif direction == "left" then
          if not scene.map[other.val.mapx-1][other.val.mapy] then return false, nil end
          if node.val.x == unit.mapx - 1 and node.val.y == unit.mapy then
            return false, nil
          end
        end
      end
    end
  end

  local oldvals = {}
  oldvals.movesleft = unit.movesleft
  oldvals.hasmoved = unit.hasmoved
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
      unit.hasmoved = oldvals.hasmoved
      unit.mapx = oldvals.mapx
      unit.mapy = oldvals.mapy
      unit.nodes = oldvals.nodes
      print(unit)
    end,
  }

  unit:move(direction)
  return true, actiondescriptor
end

return Actions
