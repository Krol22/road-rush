local ComponentTypes = require("src/constants/componentTypes")
local CarTypes = require("src/constants/carTypes")
local SpawnCarCommand = require("src/commands/spawnCarCommand")

SpawnerSystem = {}
SpawnerSystem.__index = SpawnerSystem

function SpawnerSystem:new()
  self = setmetatable({}, SpawnerSystem)

  self.entitiesMetadata = {}
  self.entitiesMetadata["entities"] = {ComponentTypes.Spawner}

  return self
end

function SpawnerSystem:update(_, ecs)
  for entity, _ in pairs(self.entities) do
    local spawnerComponent = entity:getComponent(ComponentTypes.Spawner)
    spawnerComponent.counter = spawnerComponent.counter + 1

    if spawnerComponent.counter > 1000 then
      spawnerComponent.counter = 0
      ecs:dispatch(SpawnCarCommand:new(CarTypes.BlueCar1, 200, 220))
    end
  end
end

return SpawnerSystem
