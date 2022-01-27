PauseScreenState = Class{__includes = BaseState}

highlighted = 1

function PauseScreenState:enter(params)
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.net = params.net
    self.score = params.score
    self.servingPlayer = params.servingPlayer
    self.previousState = params.previousState
end

function PauseScreenState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local gameState = {
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            net = self.net,
            score = self.score,
            servingPlayer = self.servingPlayer
        }
        if highlighted == 1 and self.previousState == 'serve' then
            gStateMachine:change('serve', gameState)
        elseif highlighted == 1 and self.previousState == 'play' then
            gStateMachine:change('play', gameState)
        elseif highlighted == 2 then
            gStateMachine:change('quit')
        end
    end
end

function PauseScreenState:render()
    
    renderStars(stars)

    displayScore(self.score)
    self.player1:render()
    self.player2:render()
    self.ball:render()
    self.net:render()

    -- apply an overlay on object game
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)

    -- Menu 
    love.graphics.setFont(fonts['regular'])
    if highlighted == 1 then 
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.printf('RESUME', 0, 55, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then 
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.printf('QUIT', 0, 75, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(fonts['large'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('PAUSE', 0, 35, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end