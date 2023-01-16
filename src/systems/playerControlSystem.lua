local ComponentTypes = require("src/constants/componentTypes")

PlayerControlSystem = {}
PlayerControlSystem.__index = PlayerControlSystem

function PlayerControlSystem:new()
  self = setmetatable({}, PlayerControlSystem)

  self.entitiesMetadata = {}
  self.entitiesMetadata["entities"] = {
    ComponentTypes.Velocity,
    ComponentTypes.Player,
    ComponentTypes.Speed
  }

  return self
end

function PlayerControlSystem:update()
  for entity, _ in pairs(self.entities) do
    local acc = entity:getComponent(ComponentTypes.Velocity).acc
    local speedComponent = entity:getComponent(ComponentTypes.Speed)

    if love.keyboard.isDown("left") then
      acc.x = -70
    end

    if love.keyboard.isDown("right") then
      acc.x = 70
    end

    if love.keyboard.isDown("up") then
      speedComponent.speed = speedComponent.speed + 0.01
    end

    if love.keyboard.isDown("down") then
      speedComponent.speed = speedComponent.speed - 0.02
    end
  end
end

return PlayerControlSystem
