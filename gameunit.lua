Sprites = require "spritesheets"
List = require "lib/linkedlist"
Node = require "node"
--tiles = require "spritesheets"

local Gameunit = {}

Gameunit.name = "base"
Gameunit.desc = "base unit class"
Gameunit.powerlevel = 0
Gameunit.alignment = 1      -- int representing allegiance to the CPU or player1(/2/3/...?)

Gameunit.maxmoves = 0
Gameunit.movesleft = 0
Gameunit.defense = 0
Gameunit.maxsize = 1
Gameunit.abilities = {}

Gameunit.mapx = 0
Gameunit.mapy = 0

Gameunit.selected = false   -- Boolean representing if the unit is selected
Gameunit.hasacted = true    -- Boolean representing if the unit has finished moving or not

Gameunit.nodes = nil       -- List of the unit's nodes

Gameunit.sprite = nil
Gameunit.tileset = nil

function Gameunit:new()
  local t = {}
  setmetatable(t, self)
  self.__index = self
  return t
end

function Gameunit:draw()
  if self.nodes.size == 0 then return end

  local sorted = List:new()

  self:updateconnections() -- Potential cause of fps issues

  for node in self.nodes:iter() do
    local comp = sorted.head
    local depth=0
    while comp and node.val.x + node.val.y >= comp.val.x + comp.val.y do
      depth = depth+1
      comp = comp.prev
    end

    sorted:insert(depth, {x=node.val.x, y=node.val.y, connections=node.val.connections})
  end

  for node in sorted:iter() do
    love.graphics.draw(Sprites.tilespritesheet, self.tileset.tile, 320+(node.val.x-1)*64, 41+(node.val.y-1)*64)
    if node.val.connections.right then
      love.graphics.draw(Sprites.tilespritesheet, self.tileset.hconn, 320+(node.val.x-1)*64+56, 41+(node.val.y-1)*64+20)
    end
    if node.val.connections.down then
      love.graphics.draw(Sprites.tilespritesheet, self.tileset.vconn, 320+(node.val.x-1)*64+20, 41+(node.val.y-1)*64+56)
    end
  end
  
  love.graphics.draw(Sprites.tilespritesheet, self.sprite, 320+(self.mapx-1)*64, 41+(self.mapy-1)*64)

  if self.selected then
    love.graphics.draw(Sprites.tilespritesheet, Sprites.selector, 320+(self.mapx-1)*64, 41+(self.mapy-1)*64)
  end
  
  if not self.hasacted then
    love.graphics.draw(Sprites.tilespritesheet, Sprites.finishedindicator, 340+(self.mapx-1)*64, 11+(self.mapy-1)*64)
  end
end

function Gameunit:updateconnections()
  for node1 in self.nodes:iter() do
    node1.val.connections.right = false
    node1.val.connections.down = false
    for node2 in self.nodes:iter() do
      if node1.val.x == node2.val.x - 1 then
        if node1.val.y == node2.val.y then
          node1.val.connections.right = true
        end
      elseif node1.val.y == node2.val.y - 1 then
        if node1.val.x == node2.val.x then
          node1.val.connections.down = true
        end
      end
    end
  end
end

function Gameunit:move(direction)
  -- Up
  if direction == "up" then
    self.mapy = self.mapy - 1
  elseif direction == "down" then
    self.mapy = self.mapy + 1
  elseif direction == "right" then
    self.mapx = self.mapx + 1
  elseif direction == "left" then
    self.mapx = self.mapx - 1
  end

  self.movesleft = self.movesleft - 1

  for node in self.nodes:iter() do
    if node.val.x == self.mapx and node.val.y == self.mapy then
      self.nodes:remove(node)
      break
    end
  end

  local val = Node:new(self.mapx, self.mapy)

  self.nodes:insert_front(val)

  if self.nodes.size > self.maxsize then
    local temp = self.nodes:remove_back().val.connections
  end
end

return Gameunit
