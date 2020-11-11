player = {}

function player:load()
    player.width = 20
    player.height = 40
    player.angle = 0
    player.aimAngle = 0
    player.x = window.width/2-player.width/2
    player.y = window.height-200-player.height
    player.inAir = false
    player.isJumping = false
    player.velocity = 0
    player.isMovingClockwise = false
    player.isMovingCounterClockwise = false

    player.sprite = {
        gun = love.graphics.newImage("assets/gun.png"),
        player = love.graphics.newImage("assets/player.png")
    }
end

function player:draw()
    -- Player
    love.graphics.setColor(1, 1, 1)
    --love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    love.graphics.draw(player.sprite.player, player.x, player.y, player.angle, 1, 1, 0, 0)

    -- Aim line
    love.graphics.setColor(0.2, 0.3, 0.2)
    love.graphics.line(player.x+player.width/2, player.y+10, love.mouse.getX(), love.mouse.getY())

    -- Gun
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.draw(player.sprite.gun, player.x+player.width/2, player.y+10, player.aimAngle, 1, 1, 0, 5)
end

function player:update(dt)
    local p = {x=player.x+player.width/2, y=player.y+10}
    local mouse = {x=love.mouse.getX(), y=love.mouse.getY()}

    player.aimAngle = math.atan2((mouse.y - p.y), (mouse.x - p.x))

    player.inAir = player.y + player.height < moon.y - moon.r

    if (player.inAir) then
        player.velocity = player.velocity + gravity
        player.y = player.y + player.velocity * dt
    else
        player.velocity = 0
    end

    if (player.isJumping and not player.inAir) then
        player.y = player.y - 10
        player.velocity = -400
    end

    if player.y < moon.y - moon.r then
        if (player.isMovingClockwise) then
            player.x = player.x + 5
        end
        if (player.isMovingCounterClockwise) then
            player.x = player.x - 5
        end
    else
        if (player.isMovingClockwise) then
            player.x = player.x - 5
        end
        if (player.isMovingCounterClockwise) then
            player.x = player.x + 5
        end
    end
end

function player:keypressed(key, isrepeat)
    if (key == "space") then
        player.isJumping = true
    end
    if (key == "a") then
        player.isMovingCounterClockwise = true
    end
    if (key == "d") then
        player.isMovingClockwise = true
    end
end

function player:keyreleased(key)
    if (key == "space") then
        player.isJumping = false
    end
    if (key == "a") then
        player.isMovingCounterClockwise = false
    end
    if (key == "d") then
        player.isMovingClockwise = false
    end
end

