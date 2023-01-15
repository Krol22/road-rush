local ComponentTypes = require("constants/componentTypes")

MaxSpeedSystem = {}
MaxSpeedSystem.__index = MaxSpeedSystem

function MaxSpeedSystem:new()
  self = setmetatable({}, MaxSpeedSystem)

  self.entitiesMetadata = {}
  self.entitiesMetadata["entities"] = {ComponentTypes.Speed}

  return self
end

function MaxSpeedSystem:update()
  for entity, _ in pairs(self.entities) do
    local speedComponent = entity:getComponent(ComponentTypes.Speed)

    if speedComponent.speed < 0 then
      speedComponent.speed = 0
    end

    if speedComponent.speed > speedComponent.maxSpeed then
      speedComponent.speed = speedComponent.maxSpeed
    end
  end
end

return MaxSpeedSystem
