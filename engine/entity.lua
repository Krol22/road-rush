Entity = {}
Entity.__index = Entity

function Entity:new()
  self = setmetatable({}, Entity)

  self.components = {}

  return self
end

function Entity:addComponent(componentType, component)
  self.components[componentType] = component
end

function Entity:getComponent(componentType)
  return self.components[componentType]
end

function Entity:hasComponents(componentTypes)
    for _, componentType in pairs(componentTypes) do
        if self.components[componentType] == nil then
            return false
        end
    end
    return true
end

return Entity
