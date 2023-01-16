PlayerComponent = {}
PlayerComponent.__index = PlayerComponent

function PlayerComponent:new()
  self = setmetatable({}, PlayerComponent)

  self.name = "PLAYER"

  return self
end

return PlayerComponent
