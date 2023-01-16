SpawnCarCommand = {}
SpawnCarCommand.__index = SpawnCarCommand

function SpawnCarCommand:new(carType, x, y)
  self = setmetatable({}, SpawnCarCommand)

  self.name = "SpawnCarCommand";
  self.x = x
  self.y = y
  self.carType = carType

  return self
end

return SpawnCarCommand
