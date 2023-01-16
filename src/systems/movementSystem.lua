local ComponentTypes = require("src/constants/componentTypes")

MovementSystem = {}
MovementSystem.__index = MovementSystem

function MovementSystem:new()
  self = setmetatable({}, MovementSystem)

  self.entitiesMetadata = {}
  self.entitiesMetadata["entities"] = {ComponentTypes.Position, ComponentTypes.Velocity}

  return self
end

function MovementSystem:update(dt)
  for entity, _ in pairs(self.entities) do
    local positionComponent = entity:getComponent(ComponentTypes.Position)
    local velocityComponent = entity:getComponent(ComponentTypes.Velocity)

    velocityComponent.vel = velocityComponent.vel:add(velocityComponent.acc:multiply(dt))
    positionComponent.pos = positionComponent.pos:add(velocityComponent.vel)

    velocityComponent.vel.x = velocityComponent.vel.x * 0.1
    velocityComponent.vel.y = velocityComponent.vel.y * 0.1

    velocityComponent.acc.x = 0
    velocityComponent.acc.y = 0
  end
end

return MovementSystem
