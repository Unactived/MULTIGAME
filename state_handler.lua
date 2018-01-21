local state

local gameStates = {}

function quitGame()
    love.event.quit()
end

gameStates.gameLoop = {
    bindings = {
        pauseGame = function() state = gameStates.gamePause end,
        left = function() end,
        right = function() end,
        up = function() end,
        down = function() end,
        attack = function() end
    },

    keys = {
        escape = "pauseGame",
        left = "left",
        right = "right",
        up = "up",
        down = "down",
        space = "attack"
    }
}

gameStates.menu = {
    bindings = {
        backToGame = function() state = gameStates.gameLoop end,
        quit = quitGame,
        select = function() end
    },

    keys = {
        ["return"] = "backToGame",
        escape = "quit"
    },

    keysReleased = {},

    buttons = {
        a = "select"
    },

    buttonsReleased = {}
}

gameStates.gamePause = {
    bindings = {
        openMenu = function() state = gameStates.menu end,
        backToGame = function() state = gameStates.gameLoop end
    },

    keys = {
        ["return"] = "backToGame",
        escape = "openMenu"
    }
}

function inputHandler(input)
    local action = state.bindings[input]
    if action then return action() end
end

function love.keypressed(k)
    INPUTMETHOD = "keyboard"
    local binding = state.keys[k]
    return inputHandler(binding)
end

--function love.keyreleased(k)
--    local binding = state.keysReleased[k]
--    return inputHandler(binding)
--end

function love.gamepadpressed(gamepad, button)
    INPUTMETHOD = "gamepad"
    local binding = state.buttons[button]
    return inputHandler(binding)
end

--function love.gamepadreleased(gamepad, button)
--    local binding = state.buttonsReleased[button]
--    return inputHandler(binding)
--end

state = gameStates.gameLoop
