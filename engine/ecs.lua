ECS = {}
ECS.__index = ECS

function ECS:new()
  self = setmetatable({}, ECS)

  self.systems = {}
  self.entities = {}

  return self
end

function ECS:addEntity(entity)
  table.insert(self.entities, entity)
end

function ECS:addSystem(system)
  table.insert(self.systems, system)
end

function ECS:update(dt)
  for _, system in ipairs(self.systems) do
    self:injectEntities(system)
    local mt = getmetatable(system)
    if mt.__index.update then
      system:update(dt)
    end
  end
end

function ECS:draw()
  for _, system in ipairs(self.systems) do
    self:injectEntities(system)
    local mt = getmetatable(system)
    if mt.__index.draw then
      system:draw()
    end
  end
end

function ECS:getEntities(componentTypes)
  local entities = {}
  for _, entity in ipairs(self.entities) do
    if entity:hasComponents(componentTypes) then
      entities[entity] = true
    end
  end

  return entities
end

function ECS:injectEntities(system)
  for prop, components in pairs(system.entitiesMetadata) do
    local entities = self:getEntities(components)
    system[prop] = entities
  end
end

return ECS
