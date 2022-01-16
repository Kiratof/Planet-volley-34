VictoryScreenState = Class{__includes = BaseState}

local highlighted = 1

function VictoryScreenState:enter(params)
    self.winner = params.winner
end

function VictoryScreenState:update(dt)

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then

        if highlighted == 1 then
            gStateMachine:change('serve', {
                player1 = Paddle((VIRTUAL_WIDTH / 2) - 150, VIRTUAL_HEIGHT - 20, 20),
                player2 = Paddle((VIRTUAL_WIDTH / 2) + 150, VIRTUAL_HEIGHT - 20, 20),
                ball = Ball(BALL_PLAYER1_SERVING_POSITION.x, BALL_PLAYER1_SERVING_POSITION.y, 10),
                net = Net(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT  / 2, 5, 500),
                score = {
                    player1 = 0,
                    player2 = 0
                },
                servingPlayer = 1
            })
        elseif highlighted == 2 then
            gStateMachine:change('quit')
        end
    end

end

function VictoryScreenState:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(fonts['large'])

    love.graphics.printf('VICTORY for ' .. tostring(self.winner), 0, 35, VIRTUAL_WIDTH, 'center')

      -- Start intruction text
      love.graphics.setFont(fonts['regular'])

      if highlighted == 1 then
          love.graphics.setColor(1, 0, 0, 1)
      end
      love.graphics.printf('RESTART', 0, 128, VIRTUAL_WIDTH, 'center')
      love.graphics.setColor(1, 1, 1, 1)
  
      if highlighted == 2 then
          love.graphics.setColor(1, 0, 0, 1)
      end
      love.graphics.printf('QUIT', 0, 150, VIRTUAL_WIDTH, 'center')
      love.graphics.setColor(1, 1, 1, 1)
end