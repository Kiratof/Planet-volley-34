Paddle = Class{}

function Paddle:init(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
    self.dy = 0
    self.dx = 0
end

function Paddle:setPosition(x, y)
    self.x = x
    self.y = y

    -- side wall limit
    if self.dx < 0 then
        self.x = math.max(0 + self.radius, self.x)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.radius, self.x) 
    end

    -- floor limit
    if self.y > VIRTUAL_HEIGHT - 20 then
        self.y = VIRTUAL_HEIGHT - 20
    end
end

function Paddle:update(dt)
    self.dy = self.dy + GRAVITY * 2 * dt
    self.dx = self.dx * dt

    self:setPosition(self.x + self.dx , self.y + self.dy)
end

function Paddle:render()
    love.graphics.circle('fill', self.x, self.y, self.radius)
end
