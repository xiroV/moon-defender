function love.update(dt)

end

function love.draw()
    playerWidth = 20
    playerHeight = 40
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.circle("fill", windowWidth/2, windowHeight*2-200, windowHeight, 500)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", windowWidth/2-playerWidth/2, windowHeight-200-playerHeight, playerWidth, playerHeight)

    love.graphics.setColor(0.2, 0.3, 0.2)
    love.graphics.line(windowWidth/2, windowHeight-200-playerHeight+10, love.mouse.getX(), love.mouse.getY())

    local p = {x=windowWidth/2, y=windowHeight-200-playerHeight+10}
    local m = {x=love.mouse.getX(), y=love.mouse.getY()}

    angle = math.atan2((m.y - p.y), (m.x - p.x))

    love.graphics.translate(windowWidth/2, windowHeight-200-playerHeight+10)
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.draw(gun, 0, 0, angle, 1, 1, 0, 5)
end

function love.load()
    math.randomseed(os.time())
    windowHeight = 800
    windowWidth = 1280
    love.window.setTitle("Moon Defender")
    love.window.setMode(windowWidth, windowHeight)

    gun = love.graphics.newImage("assets/gun.png")
end

function love.mousepressed(_, _, button, istouch, presses)

end

function love.keypressed(key, scancode, isrepeat)

end

function love.keyreleased(key, scancode)

end
