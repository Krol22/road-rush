local Entity = require("engine/entity")
local ECS = require("engine/ecs")
local Map = require("map/map")

local PositionComponent = require("components/PositionComponent")
local DrawComponent = require("components/DrawComponent")
local PlayerComponent = require("components/PlayerComponent")
local VelocityComponent = require("components/VelocityComponent")

local DrawSystem = require("systems/DrawSystem")
local MovementSystem = require("systems/MovementSystem")
local PlayerControlSystem = require("systems/PlayerControlSystem")

local SpriteQuads = require("constants/spriteQuads")
local ComponentTypes = require("constants/componentTypes")

PlayScene = {}
PlayScene.__index = PlayScene

local sprite = love.graphics.newImage("assets/sprite.png");

function PlayScene:new()
  self = setmetatable({}, PlayScene)
  self.ecs = ECS:new()
  self.map = Map:new(sprite)

  local positionComponent1 = PositionComponent:new(100, 100)
  local positionComponent2 = PositionComponent:new(100, 200)
  local positionComponent3 = PositionComponent:new(200, 200)
  local playerComponent = PlayerComponent:new()
  local velocityComponent = VelocityComponent:new()

  local entity1 = Entity:new()
  local entity2 = Entity:new()
  local playerEntity = Entity:new()

  entity1:addComponent(ComponentTypes.Draw, DrawComponent:new(
    sprite,
    SpriteQuads.RedCar_1:toLoveQuad(sprite)
  ));

  entity2:addComponent(ComponentTypes.Draw, DrawComponent:new(
    sprite,
    SpriteQuads.YellowCar_2:toLoveQuad(sprite)
  ));

  playerEntity:addComponent(ComponentTypes.Player, playerComponent)
  playerEntity:addComponent(ComponentTypes.Velocity, velocityComponent)
  playerEntity:addComponent(ComponentTypes.Position, positionComponent3)
  playerEntity:addComponent(ComponentTypes.Draw, DrawComponent:new(
    sprite,
    SpriteQuads.Car:toLoveQuad(sprite)
  ))

  entity1:addComponent(ComponentTypes.Position, positionComponent1)
  entity2:addComponent(ComponentTypes.Position, positionComponent2)

  self.ecs:addEntity(entity1)
  self.ecs:addEntity(entity2)
  self.ecs:addEntity(playerEntity)

  local drawSystem = DrawSystem:new()
  local playerControlSystem = PlayerControlSystem:new()
  local movementSystem = MovementSystem:new()

  self.ecs:addSystem(drawSystem)
  self.ecs:addSystem(movementSystem)
  self.ecs:addSystem(playerControlSystem)

  return self
end

function PlayScene:draw()
  self.map:draw()
  self.ecs:draw()
end

function PlayScene:update(dt)
  self.map:update(dt)
  self.ecs:update(dt)
end

return PlayScene
