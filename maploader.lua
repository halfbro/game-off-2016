local MapLoader = {}

local Map = {{}}

function Map:draw() 
  for i=1,14 do
    if self[i] then
      for j=1,10 do
        if self[i][j] then
          if self[i][j].basetile == 0 then
            love.graphics.draw(Sprites.tilespritesheet, Sprites.groundnormal, 320+(i-1)*64, 41+(j-1)*64)
          elseif self[i][j].basetile == 1 then
            love.graphics.draw(Sprites.tilespritesheet, Sprites.grounddecor1, 320+(i-1)*64, 41+(j-1)*64)
          elseif self[i][j].basetile == 2 then
            love.graphics.draw(Sprites.tilespritesheet, Sprites.grounddecor2, 320+(i-1)*64, 41+(j-1)*64)
          elseif self[i][j].basetile == 3 then
            love.graphics.draw(Sprites.tilespritesheet, Sprites.grounddecor3, 320+(i-1)*64, 41+(j-1)*64)
          end
        end
      end
    end
  end
end

local loaded = {}

function MapLoader.load(filename)
  if not loaded[filename] then
    print("Loading file maps/"..filename.."...")

    local ok, module = pcall(require, "maps/"..filename)
    if ok then
      loaded[filename] = module
      print("Load Successful")
    else
      loaded[filename] = nil
      print("Load Failed: \n--- BEGIN ERROR MESSAGE ---\n"..module..")\n----- END ERROR MESSAGE -----")
    end

  end

  local newmapdata = loaded[filename].load()

  setmetatable(newmapdata.map, Map)
  Map.__index = Map

  return newmapdata.map, newmapdata.units
end

return MapLoader
