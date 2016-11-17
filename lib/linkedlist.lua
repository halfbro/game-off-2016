local LinkedList = {}

function LinkedList:new(o)
  local l = {head=nil, tail=nil, size=0}
  setmetatable(l, self)
  self.__index = self
  if o then l:insert_front(o) end
  return l
end

function LinkedList:insert(pos, value)
  -- Empty List
  if not self.head then
    self:insert_front(value)
    return
  end
  
  if pos == 0 then
    self:insert_front(value)
    return
  end

  local node = self.head

  while node and pos>0 do
    node = node.prev
    pos = pos-1
  end

  if node then
    local newnode = {next=node.next, prev=node, val=value}
    node.next.prev = newnode
    node.next=newnode
    self.size = self.size+1
  else
    self:insert_back(value)
  end
end

function LinkedList:insert_front(value)
  local oldhead = self.head
  local newhead = {next=nil, prev=oldhead, val=value}
  self.head = newhead
  if oldhead then
    oldhead.next = newhead
  else
    self.tail = newhead 
  end
  self.size = self.size+1
end

function LinkedList:insert_back(value)
  local oldtail = self.tail
  local newtail = {next=oldtail, prev=nil, val=value}
  self.tail = newtail
  if oldtail then
    oldtail.prev = newtail
  else
    self.head = newtail
  end
  self.size = self.size+1
end

function LinkedList:remove(n)
  local found = self:find(n)

  if found then
    if found.prev then
      found.prev.next = found.next
    else
      self.tail = found.next
      found.next.prev = nil
    end

    if found.next then
      found.next.prev = found.prev
    else
      self.head = found.prev
      found.prev.next = nil
    end
  end

  self.size = self.size-1
  return found
end

function LinkedList:remove_back()
  if not self.tail then return nil end
  local ret = self.tail
  self.tail = self.tail.next
  if self.tail then
    self.tail.prev = nil
  else
    self.head = nil
  end
  self.size = self.size-1
  return ret
end

function LinkedList:find(value)
  local cur = self.head

  while cur do
    if cur == value then
      return cur
    end
    cur = cur.prev
  end
  
  return nil
end
  
function LinkedList:iter()
  local node = self.head

  return function()
    if node then
      local ret = node
      node = node.prev
      return ret
    else
      return nil
    end
  end
end

return LinkedList
