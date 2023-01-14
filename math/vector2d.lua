Vector2D = {}
Vector2D.__index = Vector2D

function Vector2D:new(x, y)
  self = setmetatable({}, Vector2D)

  self.x = x or 0
  self.y = y or 0

  return self
end

function Vector2D:add(other)
  return Vector2D:new(self.x + other.x, self.y + other.y)
end

function Vector2D:subtract(other)
  return Vector2D:new(self.x - other.x, self.y - other.y)
end

function Vector2D:multiply(scalar)
  return Vector2D:new(self.x * scalar, self.y * scalar)
end

function Vector2D:length()
  return math.sqrt(self.x^2 + self.y^2)
end

return Vector2D
