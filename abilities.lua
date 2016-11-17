local Abilities = {}

------------------------ Effect functions ------------------------

local function damage(val)
  return function(source, target)
    for i=1,(val-target.defense) do
      target.nodes:remove_back()
    end
  end
end

local function slow(val)
  return function(source, target)
    target.maxmoves = math.max(target.maxmoves-val,0)
  end
end

local function quicken(val)
  return function(source, target)
    target.maxmoves = target.maxmoves+val
  end
end

local function grow(val)
  return function(source, target)
    target.maxsize = target.maxsize+val
  end
end

local function selfdamage(val)
  return function(source, target)
    for i=1,val do
      source.nodes:remove_back()
    end
  end
end

local function charge(val)
  return function(source, target)
    if source.charge then
      source.charge = source.charge+val
    else
      source.charge = val
    end
  end
end

local function chargedability(ability, val)
  return function(source, target)
    if not source.charge then source.charge=0 return ability(0)(source,target) end
    local power = source.charge
    source.charge=0
    return ability(power*val)(source, target)
  end
end

------------------------ Pre-Req functions ------------------------

local function sizeatleast(val)
  return function(source, target)
    return source.nodes.size >= val
  end
end

local function chargeatleast(val)
  return function(source, target)
    if source.charge then
      return source.charge >= val
    else
      source.charge=0
      return false
    end
  end
end

------------------------ Ability tables ------------------------

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

Abilities.Lmao = {
  name = "Lmao",
  desc = "Can't just let it hang there",
  effectstr = "Damages for 3",
  affects = 1,
  range = 1,
  effects = {
    damage(3)
  },
  prereqs = {
    sizeatleast(3)
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

Abilities.Charge = {
  name = "Charge",
  desc = "Soon (tm)",
  effectstr = "Increases charge by 1",
  affects = 0,
  range = 0,
  effects = {
    charge(1)
  }
}

Abilities.Laser = {
  name = "Laser",
  desc = "Have you loaded the Bass Cannon?",
  effectstr = "Damages for 2x charge amount",
  affects = 1,
  range = 3,
  effects = {
    chargedability(damage, 2)
  },
  prereqs = {
    chargeatleast(1)
  }
}

return(Abilities)
