function distanceBetweenCirclesSquared (x1, x2, y1, y2)
    return (x2 - x1) ^ 2 + (y2 - y1) ^ 2
end

function distanceBetweenCircles(x1, x2, y1, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function displayScore(score)
    love.graphics.setFont(fonts['score'])
    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.printf(tostring(score.player1), 0, 50, VIRTUAL_WIDTH * 0.5, 'center')
    love.graphics.printf(tostring(score.player2), VIRTUAL_WIDTH * 0.5, 50, VIRTUAL_WIDTH * 0.5, 'center')
    love.graphics.setColor(COLORS.white)
end

function displayFPS()
    love.graphics.setFont(fonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS : ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(COLORS.white)
end