ServeScreenState = Class{__includes = BaseState}

function ServeScreenState:enter(params)
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.net = params.net
    self.score = params.score
    self.servingPlayer = params.servingPlayer
end

function ServeScreenState:update(dt)
    -- Pause option
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('pause', {
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            net = self.net,
            score = self.score,
            servingPlayer = self.servingPlayer,
            previousState = 'serve'
        })
    end
    
    -- Player 1
    if love.keyboard.isDown('q') then
        self.player1.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('d') then
        self.player1.dx = PADDLE_SPEED
    else
        self.player1.dx = 0
    end
    if love.keyboard.wasPressed('z') then
        self.player1.dy = - 2
    end

    -- Player 2
    if love.keyboard.isDown('left') then
        self.player2.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.player2.dx = PADDLE_SPEED
    else
        self.player2.dx = 0
    end
    if love.keyboard.wasPressed('up') then
        self.player2.dy = - 2
    end

    -- Net Colliding
    -- Player 1
    if self.player1.x > self.net.x - self.player1.radius then
        self.player1.x = self.net.x - self.player1.radius 
    end

    -- Player 2
    if self.player2.x < self.net.x + self.net.width + self.player2.radius then
        self.player2.x = self.net.x + self.net.width + self.player2.radius  
    end


    -- Serving logique
    if self.ball:collides(self.player1) or self.ball:collides(self.player2) then

        gStateMachine:change('play', {
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            net = self.net,
            score = self.score,
            servingPlayer = self.servingPlayer
        })
    end

    self.player1:update(dt)
    self.player2:update(dt)
end

function ServeScreenState:render()
    renderStars(stars)
    if self.score.player1 + self.score.player2 == 0 then 
        love.graphics.setFont(fonts['regular'])
        love.graphics.printf('Hit the ball to start !', 0, 64, VIRTUAL_WIDTH, 'center')
    end
    
    displayScore(self.score)

    self.player1:render()
    self.player2:render()
    self.ball:render()
    self.net:render()
end