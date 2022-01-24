Paddle = Class{}

function Paddle:init(player)

    if player == 'player1' then
        self.image = gTextures['earth']
        self.x = PLAYER1_POSITION.x
        self.y = PLAYER1_POSITION.y
    elseif player == 'player2' then
        self.x = PLAYER2_POSITION.x
        self.y = PLAYER2_POSITION.y
        self.image = gTextures['mars']
    end

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.radius = self.width * 0.5

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
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width * 0.5, self.height * 0.5)
end
