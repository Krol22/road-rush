local ComponentTypes = require("constants/componentTypes")

SpawnerComponent = {}
SpawnerComponent.__index = SpawnerComponent

function SpawnerComponent:new(carType)
  self = setmetatable({}, SpawnerComponent)

  self.name = ComponentTypes.Spawner
  self.carType = carType
  self.counter = 0

  return self
end

return SpawnerComponent
