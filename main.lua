local Game = require("engine/game")
local PlayScene = require("scenes/playScene")

local game

function love.load()
  love.window.setTitle("Road")
  love.window.setMode(270, 600, {
    resizable = false
  })

  local playScene = PlayScene:new()
  game = Game:new(playScene)
end

function love.draw()
  game:draw()
end

function love.update(dt)
  game:update(dt)
end
