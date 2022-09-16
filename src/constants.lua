WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 243
VIRTUAL_HEIGHT = 200

PADDLE_SPEED = 200
PLAYER1_POSITION = {
    x = (VIRTUAL_WIDTH * 0.25),
    y = VIRTUAL_HEIGHT - 20
}
PLAYER2_POSITION = {
    x = (VIRTUAL_WIDTH * 0.75),
    y = VIRTUAL_HEIGHT - 20
}

BALL_COLLISION_VELOCITY = 3
BALL_PLAYER1_SERVING_POSITION = {
    x = VIRTUAL_WIDTH * 0.25, 
    y = VIRTUAL_WIDTH * 0.25 + 25
}
BALL_PLAYER2_SERVING_POSITION = {
    x = VIRTUAL_WIDTH * 0.75, 
    y = VIRTUAL_WIDTH * 0.25  + 25
}

NET = {
    x = (VIRTUAL_WIDTH * 0.5) - 6 * 0.5,
    y = (VIRTUAL_HEIGHT * 0.5) + 15,
    width = 6,
    height = 500
}

VICTORY_SCORE = 3

GRAVITY = 3

COLORS = {
    red = {1, 0, 0, 1},
    white = {1, 1, 1, 1},
    grey = {0.8, 0.8, 0.8, 1},
    black = {0, 0.05, 0.12, 1},
    dark = {1, 1, 1, 0.5}
}

