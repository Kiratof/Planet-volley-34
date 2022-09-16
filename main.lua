Class = require 'lib/class'
push = require "lib/push"

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StartScreenState'
require 'src/states/ServeScreenState'
require 'src/states/PauseScreenState'
require 'src/states/PlayScreenState'
require 'src/states/VictoryScreenState'
require 'src/states/QuitScreenState'

require 'src/Utils'
require 'src/Paddle'
require 'src/Ball'
require 'src/Net'
require 'src/constants'

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Planet Volley 34 !')

    -- randomseed
    math.randomseed(os.time())

    -- FONT
    -- main
    fonts = {
        ['score'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['title'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 20),
        ['regular'] = love.graphics.newFont('fonts/font.ttf', 15),
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8)
    }

    -- TEXTURES
    gTextures = {
        ['moon'] = love.graphics.newImage('images/ball-moon.png'),
        ['mars'] = love.graphics.newImage('images/player-hearth.png'),
        ['earth'] = love.graphics.newImage('images/player-mars.png')
    }

    -- SOUND
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static')
    }
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine{
        ['start'] = function() return StartScreenState() end,
        ['serve'] = function() return ServeScreenState() end,
        ['play'] = function() return PlayScreenState() end,
        ['pause'] = function() return PauseScreenState() end,
        ['victory'] = function() return VictoryScreenState() end,
        ['quit'] = function() return QuitScreenState() end
    }

    stars = generateStars(100)

    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end 

function love.draw()
    push:apply('start')
    
    love.graphics.clear(COLORS.black)
    gStateMachine:render()

    -- UI
    displayFPS()

    push:apply('end')
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    -- deug purpose
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('start')
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end   

function love.resize(width, height)
    push:resize(width, height)
end