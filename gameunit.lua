Sprites = require "spritesheets"
List = require "lib/linkedlist"
Node = require "node"
--tiles = require "spritesheets"

local Gameunit = {}

Gameunit.name = "base"
Gameunit.desc = "base unit class"
Gameunit.powerlevel = 0
Gameunit.alignment = 1

Gameunit.maxmoves = 0
Gameunit.movesleft = 0
Gameunit.defense = 0
Gameunit.maxsize = 1
Gameunit.abilities = nil
Gameunit.selectedability = nil

Gameunit.mapx = 0
Gameunit.mapy = 0

Gameunit.selected = false   -- Boolean representing if the unit is selected
Gameunit.hasmoved = true    -- Boolean representing if the unit has finished moving or not

Gameunit.nodes = List:new()       -- List of the unit's nodes

Gameunit.sprite = nil
Gameunit.tileset = nil

function Gameunit:new()
  local t = {}
  setmetatable(t, self)
  self.__index = self
  return t
end

function Gameunit:draw()
  local node = self.nodes.head
  local sorted = List:new()

  while node do
    local comp = sorted.head
    local depth=0
    while comp and node.val.x + node.val.y >= comp.val.x + comp.val.y do
      depth = depth+1
      comp = comp.prev
    end

    sorted:insert(depth, {x=node.val.x, y=node.val.y, connections=node.val.connections})
    node = node.prev
  end

  node = sorted.head
  while node do
    love.graphics.draw(Sprites.tilespritesheet, self.tileset.tile, 320+(node.val.x-1)*64, 41+(node.val.y-1)*64)
    if node.val.connections.right then
      love.graphics.draw(Sprites.tilespritesheet, self.tileset.hconn, 320+(node.val.x-1)*64+56, 41+(node.val.y-1)*64+20)
    end
    if node.val.connections.down then
      love.graphics.draw(Sprites.tilespritesheet, self.tileset.vconn, 320+(node.val.x-1)*64+20, 41+(node.val.y-1)*64+56)
    end
    node = node.prev
  end

  love.graphics.draw(Sprites.tilespritesheet, self.sprite, 320+(self.mapx-1)*64, 41+(self.mapy-1)*64)
end

function Gameunit:move(direction)
  -- Up
  if direction == "up" then
    self.mapy = self.mapy - 1

    local node = self.nodes.head
    local val = nil
    while node do
      if node.val.x == self.mapx and node.val.y == self.mapy then
        self.nodes:remove(node)
        val = node.val
        break
      end
      node = node.prev
    end

    if val == nil then
      val = Node:new(self.mapx, self.mapy)
    end

    val.connections.down=true
    self.nodes:insert_front(val)

    if self.nodes.size > self.maxsize then
      local temp = self.nodes:remove_back()
    end

  -- Down
  elseif direction == "down" then
    self.mapy = self.mapy + 1

    local node = self.nodes.head
    local val = nil
    while node do
      if node.val.x == self.mapx and node.val.y == self.mapy then
        self.nodes:remove(node)
        val = node.val
        break
      end
      node = node.prev
    end

    if val == nil then
      val = Node:new(self.mapx, self.mapy)
    end

    self.nodes.head.val.connections.down=true
    self.nodes:insert_front(val)

    if self.nodes.size > self.maxsize then
      local temp = self.nodes:remove_back()
    end

  -- Right
  elseif direction == "right" then
    self.mapx = self.mapx + 1

    local node = self.nodes.head
    local val = nil
    while node do
      if node.val.x == self.mapx and node.val.y == self.mapy then
        self.nodes:remove(node)
        val = node.val
        break
      end
      node = node.prev
    end

    if val == nil then
      val = Node:new(self.mapx, self.mapy)
    end

    self.nodes.head.val.connections.right=true
    self.nodes:insert_front(val)

    if self.nodes.size > self.maxsize then
      local temp = self.nodes:remove_back()
    end

  -- Left
  elseif direction == "left" then
    self.mapx = self.mapx - 1

    local node = self.nodes.head
    local val = nil
    while node do
      if node.val.x == self.mapx and node.val.y == self.mapy then
        self.nodes:remove(node)
        val = node.val
        break
      end
      node = node.prev
    end

    if val == nil then
      val = Node:new(self.mapx, self.mapy)
    end

    val.connections.right=true
    self.nodes:insert_front(val)

    if self.nodes.size > self.maxsize then
      local temp = self.nodes:remove_back()
    end

  end
end

local MemeUnit=Gameunit:new()


return Gameunit
