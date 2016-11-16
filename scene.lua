local SceneFunctions = {}

local function loadscene(filename)
  local scene = {}
  scene.name=filename
  return scene
end

for i=1,14 do
  Map[i] = {}
  for j=1,10 do
    Map[i][j] = {basetile=0}
  end
end

