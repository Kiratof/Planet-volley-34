Ball = Class{}


function Ball:init()
    self.image = gTextures['moon']

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = BALL_PLAYER1_SERVING_POSITION.x
    self.y = BALL_PLAYER1_SERVING_POSITION.y
    self.radius = self.width * 0.5

    self.dx = 0
    self.dy = 0
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - self.radius
    self.y = VIRTUAL_HEIGHT / 2 - self.radius

    self.dx = 0
    self.dy = 0
end

function Ball:collides(circle)
    if distanceBetweenCirclesSquared(self.x, circle.x, self.y, circle.y) <= (self.radius + circle.radius)^2 then
        return true
    end

    return false
end

function Ball:rectCollides(rect)
    if self.x - self.radius > rect.x + rect.width or self.x + self.radius < rect.x  then
        return false
    end

    if self.y + self.radius < rect.y  or self.y > rect.y + rect.height then
        return false
    end

    return true
end

function Ball:handleWallColliding()
   -- WALLs COLLIDING
    if self.x - self.radius < 0 then
        self.x = 0 + self.radius
        self:reflectX()
        
        love.audio.play(sounds.wall_hit)
    end

    if self.x + self.radius > VIRTUAL_WIDTH  then
        self.x = VIRTUAL_WIDTH - self.radius
        self:reflectX()

        love.audio.play(sounds.wall_hit)
    end
end

function Ball:handleNetColliding(net)

    if self:collides(net.top) then

        self.dx = 0
        self.dy = 0

        -- distance between circles centers
        fDistance = distanceBetweenCircles(net.top.x, self.x, net.top.y, self.y)
        fOverlap = (fDistance - net.top.radius - self.radius)

        -- Circle move collision
        -- displace the ball
        self.x = self.x + fOverlap * ((net.top.x - self.x) / fDistance)
        self.y = self.y + fOverlap * ((net.top.y - self.y) / fDistance)

        -- DYNAMIC COLLISION
        -- Normal
        nx = - (net.top.x - self.x) / fDistance
        ny = - (net.top.y - self.y) / fDistance

        BALL_COLLISION_VELOCITY = 2
        nx = nx * BALL_COLLISION_VELOCITY
        ny = ny * BALL_COLLISION_VELOCITY

        self.dx = self.dx + nx
        self.dy = self.dy + ny
    end

    if self:rectCollides(net) then
        if self.dx > 0 then
            self.x = net.x - self.radius
        end
        if self.dx < 0 then
            self.x = net.x + net.width + self.radius
        end
        
        self:reflectX()
    end
end

function Ball:update(dt)
    self.dy = self.dy + GRAVITY * dt

    self.y = self.y + self.dy
    self.x = self.x + self.dx
end

function Ball:render()
  
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width * 0.5, self.height * 0.5 )

    -- ball ui feedback when it's to high
    if self.y < 0 then
        love.graphics.setColor(COLORS.grey)
        love.graphics.rectangle('fill', self.x, 2, 2, 2)
        love.graphics.setColor(COLORS.white)
    end
end

function Ball:reflectX()
    self.dx = - self.dx
end

function Ball:reflectY()
    self.dy = - self.dy
end