PlayScreenState = Class{__includes = BaseState}

function PlayScreenState:enter(params)
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.net = params.net
    self.score = params.score
    self.servingPlayer = params.score
end

function PlayScreenState:update(dt)
    -- Pause option
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('pause', {
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            net = self.net,
            score = self.score,
            servingPlayer = self.servingPlayer,
            previousState = 'play'
        })    
    end

    -- PLAYERs CONTROLS 
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

    -- PLAYERs COLLIDING
    if self.ball:collides(self.player1) then

        self.ball.dx = 0
        self.ball.dy = 0
        -- distance between circles centers
        fDistance = distanceBetweenCircles(self.player1.x, self.ball.x, self.player1.y, self.ball.y)
        fOverlap = 0.5 * (fDistance - self.player1.radius - self.ball.radius )

        -- Circle move collision
        -- displace the player
        self.player1.x = self.player1.x - fOverlap * ((self.player1.x - self.ball.x) / fDistance)
        self.player1.y = self.player1.y - fOverlap * ((self.player1.y - self.ball.y) / fDistance)


        -- -- displace the ball
        self.ball.x = self.ball.x + fOverlap * ((self.player1.x - self.ball.x) / fDistance)
        self.ball.y = self.ball.y + fOverlap * ((self.player1.y - self.ball.y) / fDistance)
        
        -- -- DYNAMIC COLLISION
        -- -- Normal
        nx = - (self.player1.x - self.ball.x) / fDistance
        ny = - (self.player1.y - self.ball.y) / fDistance

        nx = nx * BALL_COLLISION_VELOCITY
        ny = ny * BALL_COLLISION_VELOCITY

        self.ball.dx = self.ball.dx + nx
        self.ball.dy = self.ball.dy + ny

        love.audio.play(sounds.paddle_hit)
    end

    if self.ball:collides(self.player2) then
        self.ball.dx = 0
        self.ball.dy = 0
        -- distance between circles centers
        fDistance = distanceBetweenCircles(self.player2.x, self.ball.x, self.player2.y, self.ball.y)
        fOverlap = 0.5 * (fDistance - self.player2.radius - self.ball.radius )

        -- Circle move collision
        -- displace the player
        self.player2.x = self.player2.x - fOverlap * ((self.player2.x - self.ball.x) / fDistance)
        self.player2.y = self.player2.y - fOverlap * ((self.player2.y - self.ball.y) / fDistance)

        -- displace the ball
        self.ball.x = self.ball.x + fOverlap * ((self.player2.x - self.ball.x) / fDistance)
        self.ball.y = self.ball.y + fOverlap * ((self.player2.y - self.ball.y) / fDistance)

        -- -- DYNAMIC COLLISION
        -- -- Normal
        nx = - (self.player2.x - self.ball.x) / fDistance
        ny = - (self.player2.y - self.ball.y) / fDistance

        BALL_COLLISION_VELOCITY = 2
        nx = nx * BALL_COLLISION_VELOCITY
        ny = ny * BALL_COLLISION_VELOCITY

        self.ball.dx = self.ball.dx + nx
        self.ball.dy = self.ball.dy + ny

        love.audio.play(sounds.paddle_hit)
    end

    -- Ball
    self.ball:handleWallColliding()
    self.ball:handleNetColliding(self.net)

    -- Scoring system
    if self.ball.y > VIRTUAL_HEIGHT then
        love.audio.play(sounds.wall_hit)
        self.ball.dy = 0
        self.ball.dx = 0

        -- Add points to the one that scored
        if self.ball.x + self.ball.radius < self.net.x then
            self.score.player2 = self.score.player2 + 1
            self.servingPlayer = 1
        elseif self.ball.x - self.ball.radius > self.net.x + self.net.width then
            self.score.player1 = self.score.player1 + 1
            self.servingPlayer = 2
        end

        -- ajustement de la position de la balle en fonction de la personne qui sert
        -- code qui devrait peut-être se retrouver autre part
        if self.servingPlayer == 1 then
            self.ball.x = BALL_PLAYER1_SERVING_POSITION.x
            self.ball.y = BALL_PLAYER1_SERVING_POSITION.y
        elseif self.servingPlayer == 2 then
            self.ball.x = BALL_PLAYER2_SERVING_POSITION.x 
            self.ball.y = BALL_PLAYER2_SERVING_POSITION.y 
        end
        
        if self.score.player1 == VICTORY_SCORE or self.score.player2 == VICTORY_SCORE then
            winner = 0
            if self.score.player1 == VICTORY_SCORE then
                winner = 1
            elseif self.score.player2 == VICTORY_SCORE then
                winner = 2
            end
            gStateMachine:change('victory', {
                winner = winner
            })
        else

            -- reset players positions
            self.player1:setPosition(PLAYER1_POSITION.x,  PLAYER1_POSITION.y)
            self.player2:setPosition(PLAYER2_POSITION.x,  PLAYER2_POSITION.y)
            
            gStateMachine:change('serve', {
                player1 = self.player1,
                player2 = self.player2,
                ball = self.ball,
                net = self.net,
                score = self.score,
                servingPlayer = self.servingPlayer
            })
        end
    end

    -- PLAYER NET COLLIDING
    -- Player 1
    if self.player1.x > self.net.x - self.player1.radius then
        self.player1.x = self.net.x - self.player1.radius 
    end

    -- Player 2
    if self.player2.x < self.net.x + self.net.width + self.player2.radius then
        self.player2.x = self.net.x + self.net.width + self.player2.radius  
    end

    self.player1:update(dt)
    self.player2:update(dt)
    self.ball:update(dt)
end

function PlayScreenState:render()

    renderStars(stars)
  
    displayScore(self.score)

    self.player1:render()
    self.player2:render()
    self.ball:render()
    self.net:render()
end