local Entity = require("src/engine/entity")
local ECS = require("src/engine/ecs")
local Map = require("src/map/map")

local PositionComponent = require("src/components/PositionComponent")
local DrawComponent = require("src/components/DrawComponent")
local PlayerComponent = require("src/components/PlayerComponent")
local VelocityComponent = require("src/components/VelocityComponent")
local SpawnerComponent = require("src/components/SpawnerComponent")
local SpeedComponent = require("src/components/SpeedComponent")

local DrawSystem = require("src/systems/DrawSystem")
local MovementSystem = require("src/systems/MovementSystem")
local PlayerControlSystem = require("src/systems/PlayerControlSystem")
local SpawnerSystem = require("src/systems/SpawnerSystem")
local MaxSpeedSystem = require("src/systems/MaxSpeedSystem")

local SpawnCarHandler = require("src/commands/spawnCarHandler")

local SpriteQuads = require("src/constants/spriteQuads")
local ComponentTypes = require("src/constants/componentTypes")
local CarTypes = require("src/constants/carTypes")

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
  local speedComponent = SpeedComponent:new(2)

  local entity1 = Entity:new()
  local entity2 = Entity:new()
  local playerEntity = Entity:new()

  entity1:addComponent(ComponentTypes.Draw, DrawComponent:new(
    sprite,
    SpriteQuads.RedCar1:toLoveQuad(sprite)
  ));

  entity2:addComponent(ComponentTypes.Draw, DrawComponent:new(
    sprite,
    SpriteQuads.YellowCar2:toLoveQuad(sprite)
  ));

  playerEntity:addComponent(ComponentTypes.Player, playerComponent)
  playerEntity:addComponent(ComponentTypes.Speed, speedComponent)
  playerEntity:addComponent(ComponentTypes.Velocity, velocityComponent)
  playerEntity:addComponent(ComponentTypes.Position, positionComponent3)
  playerEntity:addComponent(ComponentTypes.Draw, DrawComponent:new(
    sprite,
    SpriteQuads.Car:toLoveQuad(sprite)
  ))

  entity1:addComponent(ComponentTypes.Position, positionComponent1)
  entity2:addComponent(ComponentTypes.Position, positionComponent2)

  local spawner = Entity:new()
  spawner:addComponent(ComponentTypes.Spawner, SpawnerComponent:new(
    CarTypes.RedCar1
  ))

  self.ecs:addEntity(entity1)
  self.ecs:addEntity(entity2)
  self.ecs:addEntity(playerEntity)
  self.ecs:addEntity(spawner)

  self.ecs:registerHandler("SpawnCarCommand", SpawnCarHandler:new())

  local drawSystem = DrawSystem:new()
  local playerControlSystem = PlayerControlSystem:new()
  local movementSystem = MovementSystem:new()
  local spawnerSystem = SpawnerSystem:new()
  local maxSpeedSystem = MaxSpeedSystem:new()

  self.ecs:addSystem(drawSystem)
  self.ecs:addSystem(movementSystem)
  self.ecs:addSystem(playerControlSystem)
  self.ecs:addSystem(spawnerSystem)
  self.ecs:addSystem(maxSpeedSystem)

  return self
end

function PlayScene:draw()
  self.map:draw()
  self.ecs:draw()
end

function PlayScene:update(dt)
  local players = self.ecs:getEntities({ ComponentTypes.Player })
  local player
  for p, _ in pairs(players) do
    player = p
    break
  end

  self.map:update(dt, player)
  self.ecs:update(dt)
end

return PlayScene
