local ComponentTypes = require("src/constants/componentTypes")

DrawSystem = {}
DrawSystem.__index = DrawSystem


function DrawSystem:new()
  self = setmetatable({}, DrawSystem)

  self.entitiesMetadata = {}
  self.entitiesMetadata["entities"] = {ComponentTypes.Draw, ComponentTypes.Position}
  self.entitiesMetadata["playerEntities"] = {ComponentTypes.Player}

  return self
end

function DrawSystem:draw()
  for entity, _ in pairs(self.entities) do
    local drawComponent = entity:getComponent(ComponentTypes.Draw)
    local positionComponent = entity:getComponent(ComponentTypes.Position)

    love.graphics.draw(
      drawComponent.sprite,
      drawComponent.quad,
      positionComponent.pos.x,
      positionComponent.pos.y
    )
  end
end

return DrawSystem
