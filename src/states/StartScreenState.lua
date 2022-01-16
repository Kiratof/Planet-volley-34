StartScreenState = Class{__includes = BaseState}

local highlighted = 1

function StartScreenState:update(dt)

    -- menu toggle selection
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
    end

    -- menu choice
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        if highlighted == 1 then
            gStateMachine:change('serve', {
                player1 = Paddle(PLAYER1_POSITION.x,  PLAYER1_POSITION.y, PLAYERS_RADIUS),
                player2 = Paddle(PLAYER2_POSITION.x,  PLAYER2_POSITION.y, PLAYERS_RADIUS),
                ball = Ball(BALL_PLAYER1_SERVING_POSITION.x, BALL_PLAYER1_SERVING_POSITION.y, 10),
                net = Net(NET.x , NET.y, NET.width, NET.height),
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

function StartScreenState:render()
    love.graphics.setColor(COLORS.white)

    -- Title
    love.graphics.setFont(fonts['title'])
    love.graphics.printf('Blobby Volley 34', 0, 64, VIRTUAL_WIDTH, 'center')

    -- Start intruction text
    love.graphics.setFont(fonts['regular'])

    if highlighted == 1 then
        love.graphics.setColor(COLORS.red)
    end
    love.graphics.printf('START', 0, 128, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(COLORS.white)

    if highlighted == 2 then
        love.graphics.setColor(COLORS.red)
    end
    love.graphics.printf('QUIT', 0, 150, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(COLORS.white)
end    