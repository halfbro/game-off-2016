Abilities = {}

local function damage(val)
  return function(unit)
    for val=1,(val-unit.defense) do
      unit.nodes.remove_back()
    end
  end
end

local function slow(val)
  return function(unit)
    unit.maxmoves = math.max(unit.maxmoves-val,0)
  end
end

local function grow(val)
  return function(unit)
    unit.maxsize = unit.maxsize+val
  end
end

local function quicken(val)
  return function(unit)
    unit.maxmoves = unit.maxmoves+val
  end
end

Abilities.Ayy = {
  name = "Ayy",
  desc = "Spit hot fire on your enemies",
  effectstr = "Damages for 2",
  affects = 1,
  range = 1,
  effects = {
    damage(2)
  }
}

Abilities.IcyBurn = {
  name = "Icy Burn",
  desc = "So cold it hurts (it's still cold)",
  effectstr = "Damages and slows for 1",
  affects = 1,
  range = 2,
  effects = {
    damage(1),
    slow(1)
  }
}

Abilities.FastNFurious = {
  name = "Boost",
  desc = "Woah there",
  effectstr = "Speeds up for 2",
  affects = 0,
  range = 2,
  effects = {
    quicken(2)
  }
}

Abilities.Grow = {
  name = "Grow",
  desc = "*insert Lenny here*",
  effectstr = "Max Size increased by 2",
  affects = 0,
  range = 2,
  effects = {
    grow(2)
  }
}

return(Abilities)
