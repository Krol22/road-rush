Quad = {}
Quad.__index = Quad

function Quad:new(tx, ty, w, h)
  self = setmetatable({}, Quad)

  self.tx = tx
  self.ty = ty
  self.w = w
  self.h = h

  return self
end

function Quad:toLoveQuad(sprite)
  return love.graphics.newQuad(self.tx, self.ty, self.w, self.h, sprite)
end

return Quad

