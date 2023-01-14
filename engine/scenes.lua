Scenes = {}
Scenes.__index = Scenes

function Scenes:new()
  self = setmetatable({}, Scenes)

  self.activeScene = nil

  return self
end

function Scenes:changeScene(scene)
  self.activeScene = scene
end

function Scenes:draw()
  if self.activeScene then
    self.activeScene:draw()
  end
end

function Scenes:update(dt)
  if self.activeScene then
    self.activeScene:update(dt)
  end
end

return Scenes
