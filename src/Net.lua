Net = Class{}

function Net:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- top edga of the net pole
    self.top = {
        x = self.x + (self.width * 0.5),
        y = self.y - 2,
        radius = self.width * 0.5
    }
end

function Net:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.circle('fill', self.top.x , self.top.y, self.top.radius)
    love.graphics.setColor(1, 1, 1, 1)
end