local ComponentTypes = require("constants/componentTypes")

PlayerControlSystem = {}
PlayerControlSystem.__index = PlayerControlSystem

function PlayerControlSystem:new()
  self = setmetatable({}, PlayerControlSystem)

  self.entitiesMetadata = {}
  self.entitiesMetadata["entities"] = {ComponentTypes.Velocity, ComponentTypes.Player}

  return self
end

function PlayerControlSystem:update()
  for entity, _ in pairs(self.entities) do
    local acc = entity:getComponent(ComponentTypes.Velocity).acc

    if love.keyboard.isDown("left") then
      acc.x = -70
    end

    if love.keyboard.isDown("right") then
      acc.x = 70
    end

    if love.keyboard.isDown("up") then
      acc.y = -30
    end

    if love.keyboard.isDown("down") then
      acc.y = 30
    end
  end
end

return PlayerControlSystem
