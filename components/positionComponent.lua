local Vector2D = require('math/vector2d')

PositionComponent = {}
PositionComponent.__index = PositionComponent

function PositionComponent:new(x, y)
  self = setmetatable({}, PositionComponent)
  self.pos = Vector2D:new(x, y)
  self.name = "POSITION"

  return self
end

return PositionComponent
