local Vector2D = require('src/math/vector2d')

VelocityComponent = {}
VelocityComponent.__index = VelocityComponent

function VelocityComponent:new()
  self = setmetatable({}, VelocityComponent)

  self.vel = Vector2D:new(0, 0)
  self.acc = Vector2D:new(0, 0)

  self.damping = Vector2D:new(0.1, 0.1)
  self.maxSpeed = 1

  return self
end

return VelocityComponent
