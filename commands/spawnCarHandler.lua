local Entity = require("engine/entity")

local ComponentTypes = require("constants/componentTypes")
local SpriteQuads = require("constants/spriteQuads")

local PositionComponent = require("components/PositionComponent")
local DrawComponent = require("components/DrawComponent")

local sprite = love.graphics.newImage("assets/sprite.png");

SpawnCarHandler = {}
SpawnCarHandler.__index = SpawnCarHandler

function SpawnCarHandler:new()
  self = setmetatable({}, SpawnCarHandler)

  return self
end

function SpawnCarHandler:handle(command, ecs)
  local positionComponent = PositionComponent:new(command.x, command.y)
  local drawComponent = DrawComponent:new(sprite, SpriteQuads[command.carType]:toLoveQuad(sprite))

  local newCar = Entity:new()

  newCar:addComponent(ComponentTypes.Position, positionComponent)
  newCar:addComponent(ComponentTypes.Draw, drawComponent)

  ecs:addEntity(newCar)
end

return SpawnCarHandler
