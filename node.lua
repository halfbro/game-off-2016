local Node = {}

function Node:new(x, y, connections)
  local _x = x or 0
  local _y = y or 0
  local _conn = connections or {right=false, down=false}
  local n = {x=_x,y=_y,connections=_conn}
  return n
end

return Node
