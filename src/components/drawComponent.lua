DrawComponent = {}
DrawComponent.__index = DrawComponent

function DrawComponent:new(sprite, quad)
  self = setmetatable({}, DrawComponent)
  self.sprite = sprite
  self.quad = quad
  self.name = "DRAW"

  return self
end

return DrawComponent
