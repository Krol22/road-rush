local Quad = require("math/quad")

SpriteQuads = {
  ["Car"] = Quad:new(3, 3, 10, 15),
  ["RedCar_1"] = Quad:new(6, 58, 11, 16),
  ["RedCar_2"] = Quad:new(20, 58, 12, 16),
  ["RedCar_3"] = Quad:new(37, 58, 10, 16),
  ["RedCar_4"] = Quad:new(53, 58, 11, 15),
  ["BlueCar_1"] = Quad:new(6, 80, 11, 16),
  ["BlueCar_2"] = Quad:new(20, 80, 12, 16),
  ["BlueCar_3"] = Quad:new(37, 80, 10, 16),
  ["BlueCar_4"] = Quad:new(53, 80, 11, 15),
  ["YellowCar_1"] = Quad:new(6, 101, 11, 16),
  ["YellowCar_2"] = Quad:new(20, 101, 12, 16),
  ["YellowCar_3"] = Quad:new(37, 101, 10, 16),
  ["YellowCar_4"] = Quad:new(53, 101, 11, 15),
  ["Truck"] = Quad:new(70, 82, 15, 32),

  ["Road_1"] = Quad:new(0, 128, 96, 32),
  ["Road_1_right"] = Quad:new(0, 160, 112, 32),
  ["Road_1_left"] = Quad:new(0, 192, 112, 32),
}

return SpriteQuads
