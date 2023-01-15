local SpriteQuads = require("constants/spriteQuads")
local ComponentTypes = require("constants/componentTypes")
local Reversedipairs = require("utils/reversedipairs")

Map = {}
Map.__index = Map

TrackSegment = {}
TrackSegment.__index = TrackSegment

function TrackSegment:new(segment, trackOffset)
  self = setmetatable({}, TrackSegment)

  self.segment = segment
  self.trackOffset = trackOffset or 0

  return self
end

function TrackSegment:draw(sprite, y)
  love.graphics.draw(
    sprite,
    self.segment,
    self.trackOffset * 16,
    y - 32
  );
end

function Map:new(sprite)
  self = setmetatable({}, Map)

  self.trackOffset = 4
  self.offsetY = 0
  self.speed = 0
  self.prevGeneratedSegment = nil

  self.sprite = sprite

  self.road = SpriteQuads.Road_1:toLoveQuad(sprite)
  self.roadLeft = SpriteQuads.Road_1_left:toLoveQuad(sprite)
  self.roadRight = SpriteQuads.Road_1_right:toLoveQuad(sprite)

  self.generateSegments = {
    self.road,
    self.road,
    self.road,
    self.roadLeft,
    self.roadRight,
  }

  self.segments = {
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset),
    TrackSegment:new(self.road, self.trackOffset)
  }

  return self
end

function Map:draw()
  local segmentHeight = 32
  local drawXOffset = self.trackOffset

  for index, segment in Reversedipairs(self.segments) do
    if segment == self.roadLeft then
      drawXOffset = drawXOffset - 1
    end

    segment:draw(
      self.sprite,
      (index - 1) * segmentHeight + self.offsetY
    )

    if segment == self.roadRight then
      drawXOffset = drawXOffset + 1
    end
  end
end

function Map:update(_, playerEntity)
  local speedComponent = playerEntity:getComponent(ComponentTypes.Speed)
  self.offsetY = self.offsetY + speedComponent.speed

  if self.offsetY > 32 then
    self.offsetY = 0
    local segmentToAdd = self.generateSegments[math.random(#self.generateSegments)]

    if self.trackOffset <= 0 and segmentToAdd == self.roadLeft then
      segmentToAdd = self.road
    end

    if self.trackOffset >= 4 and segmentToAdd == self.roadRight then
      segmentToAdd = self.road
    end

    if self.prevGeneratedSegment == self.roadLeft and segmentToAdd == self.roadRight then
      segmentToAdd = self.road -- or can just continue
    end

    if self.prevGeneratedSegment == self.roadRight and segmentToAdd == self.roadLeft then
      segmentToAdd = self.road -- or can just continue
    end

    if segmentToAdd == self.roadLeft then
      self.trackOffset = self.trackOffset - 1
    end

    table.insert(self.segments, 1, TrackSegment:new(segmentToAdd, self.trackOffset))
    self.prevGeneratedSegment = segmentToAdd

    if segmentToAdd == self.roadRight then
      self.trackOffset = self.trackOffset + 1
    end

    table.remove(self.segments, #self.segments)
  end
end

return Map
