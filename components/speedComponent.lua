SpeedComponent = {}
SpeedComponent.__index = SpeedComponent

function SpeedComponent:new(maxSpeed)
  self = setmetatable({}, SpeedComponent)

  self.name = "SPEED"
  self.speed = 0
  self.maxSpeed = maxSpeed or 10

  return self
end

return SpeedComponent
