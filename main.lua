require ("state_handler")

-- Include Simple Tiled Implementation library
local sti = require "sti"
local tx, ty, sx, sy, map

function love.load()
    map = sti("assets/maps/map_test.lua")
    tx, ty = 0, 0
    sx, sy = 1.5, 1.5

    -- Calque des objets dynamiques (au-dessus du dernier ajouté)
    local layer = map:addCustomLayer("Sprites", #map.layers + 1)

    -- Get Player spawn point
    local player
    for i, object in pairs(map.objects) do
        if object.name == "Player" then
            player = object
            break
        end
    end

    -- player object
    local sprite = love.graphics.newImage("assets/images/sprites/player/joueurl10c0.png")
    layer.player = {
        sprite = sprite,
        x = player.x,
        y = player.y,
        ox = sprite:getWidth() / 2,
        oy = sprite:getHeight() / 1.05,
    }

    -- Draw player
    layer.draw = function(self)
        love.graphics.draw(
        self.player.sprite,
        math.floor(self.player.x),
        math.floor(self.player.y),
        0,
        1,
        1,
        self.player.ox,
        self.player.oy
    )

        -- Point the position
        love.graphics.setPointSize(5)
        love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
    end

    map:removeLayer("spawnpoints")
end

function love.update(dt)
    map:update(dt)
end

function love.draw()
    w = love.graphics.getWidth()
    h = love.graphics.getHeight()
    map:resize(w, h)

    map:draw(tx, ty)
end
