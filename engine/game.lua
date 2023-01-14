local Scenes = require("engine/scenes")

Game = {}
Game.__index = Game

function Game:new(scene)
  self = setmetatable({}, Game)

  self.scenes = Scenes:new()

  local initialScene = scene
  self.scenes:changeScene(initialScene)

  return self
end

function Game:update(dt)
  self.scenes:update(dt)
end

function Game:draw()
  self.scenes:draw()
end

return Game
