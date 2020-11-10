player = {}

function player:load()
    player.width = 20
    player.height = 40
    player.aimAngle = 0

    player.sprite = {
        gun = love.graphics.newImage("assets/gun.png")
    }
end

function player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", window.width/2-player.width/2, window.height-200-player.height, player.width, player.height)

    love.graphics.setColor(0.2, 0.3, 0.2)
    love.graphics.line(window.width/2, window.height-200-player.height+10, love.mouse.getX(), love.mouse.getY())

    love.graphics.translate(window.width/2, window.height-200-player.height+10)
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.draw(player.sprite.gun, 0, 0, player.aimAngle, 1, 1, 0, 5)
end

function player:update(dt)
    local p = {x=window.width/2, y=window.height-200-player.height+10}
    local m = {x=love.mouse.getX(), y=love.mouse.getY()}

    player.aimAngle = math.atan2((m.y - p.y), (m.x - p.x))

   
end

function player:keypressed()

end

function player:keyreleased()

end

