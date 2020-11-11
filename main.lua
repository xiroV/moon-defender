require "player"

function love.update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.setColor(0.8, 0.8, 0.8)
    --love.graphics.circle("fill", window.width/2, window.height*2-200, window.height, 500)
    love.graphics.circle("fill", moon.x, moon.y, moon.r, 500)
    player:draw()
end

function love.load()
    math.randomseed(os.time())
    window = {width=1280, height=800}
    love.window.setTitle("Moon Defender")
    love.window.setMode(window.width, window.height)

    moon = {
        x = window.width/2,
        y = window.height-100,
        r = 100
    }

    gravity = 5

    player:load()

end

function love.mousepressed(_, _, button, istouch, presses)

end

function love.keypressed(key, scancode, isrepeat)
    player:keypressed(key, isrepeat)
end

function love.keyreleased(key, scancode)
    player:keyreleased(key)
end
