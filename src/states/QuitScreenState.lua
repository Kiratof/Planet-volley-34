QuitScreenState = Class{__includes = BaseState}

function QuitScreenState:update(dt)
    love.event.quit()
end

function QuitScreenState:render()
    
end