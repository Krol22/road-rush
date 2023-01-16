ECS = {}
ECS.__index = ECS

function ECS:new()
  self = setmetatable({}, ECS)

  self.systems = {}
  self.entities = {}

  self.handlers = {}
  self.commandsToDispatch = {}

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
      system:update(dt, self)
    end
  end

  self:commit()

  for index, entity in ipairs(self.entities) do
    if entity.markedToRemove then
      table.remove(self.entities, index)
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

function ECS:dispatch(command)
  table.insert(self.commandsToDispatch, command)
end

function ECS:registerHandler(commandName, commandHandler)
  if self.handlers[commandName] == nil then
    self.handlers[commandName] = {}
  end

  table.insert(self.handlers[commandName], commandHandler)
end

function ECS:commit()
  for _, command in ipairs(self.commandsToDispatch) do
    local commandName = command.name
    local handlers = self.handlers[commandName]

    if #handlers == 0 then
      goto continue
    end

    for _, handler in ipairs(handlers) do
      handler:handle(command, self)
    end

    ::continue::
  end

  self.commandsToDispatch = {}
end

return ECS
