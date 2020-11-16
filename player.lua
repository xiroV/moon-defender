player = {}

function player:load()
    player.width = 20
    player.height = 40
    player.speed = {
        cw=0,
        ccw=0,
        multiplierInAir=1,
        multiplierGrounded=20,
        max=3
    }
    player.offset = {x=0,y=-50}
    player.x = moon.x - player.width / 2 + player.offset.x
    player.y = moon.y - moon.r - player.height + player.offset.y
    player.angle = math.pi + math.pi/2 - 0.07
    player.top = {
        x=moon.x + math.cos(player.angle + math.rad(4)) * (moon.r + player.height),
        y=moon.y + math.sin(player.angle + math.rad(4)) * (moon.r + player.height)
    }
    player.gun = {
        x=moon.x + math.cos(player.angle + math.rad(4)) * (moon.r + player.height-10),
        y=moon.y + math.sin(player.angle + math.rad(4)) * (moon.r + player.height-10)
    }
    player.rotation = math.atan2((moon.y - player.top.y), (moon.x - player.top.x))
    player.aimAngle = 0
    player.inAir = false
    player.isJumping = false
    player.velocity = {x=0, y=0}
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
    love.graphics.draw(player.sprite.player, player.x, player.y, player.rotation, 1, 1, -5, 0)

    -- Aim line
    love.graphics.setColor(0.2, 0.3, 0.2)
    love.graphics.line(player.gun.x, player.gun.y, love.mouse.getX(), love.mouse.getY())

    -- Gun
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.draw(player.sprite.gun, player.gun.x, player.gun.y, player.aimAngle, 1, 1, 0, 5)
end

function player:update(dt)
    local moonDistance = math.sqrt(math.pow(moon.x - player.x, 2) + math.pow(moon.y - player.y, 2))

    player.inAir = moonDistance > moon.r + player.height

    if (player.isMovingClockwise) then
        if player.speed.cw < player.speed.max then
            if player.inAir then
                player.speed.cw = player.speed.cw + dt * player.speed.multiplierInAir
            else
                player.speed.cw = player.speed.cw + dt * player.speed.multiplierGrounded
            end
        end
        print(player.speed.cw)
        player.angle = player.angle + player.speed.cw * dt
        player.x = moonDistance * math.cos(player.angle) + moon.x
        player.y = moonDistance * math.sin(player.angle) + moon.y
    end
    if (player.isMovingCounterClockwise) then
        if player.speed.ccw < player.speed.max then
            if player.inAir then
                player.speed.ccw = player.speed.ccw + dt * player.speed.multiplierInAir
            else
                player.speed.ccw = player.speed.ccw + dt * player.speed.multiplierGrounded
            end
        end
        player.angle = player.angle - player.speed.ccw * dt
        player.x = moonDistance * math.cos(player.angle) + moon.x
        player.y = moonDistance * math.sin(player.angle) + moon.y
    end

    if not(player.isMovingClockwise) and not(player.isMovingCounterClockwise) then
        player.speed.cw = 0
        player.speed.ccw = 0
    end

    local mouse = {x=love.mouse.getX(), y=love.mouse.getY()}


    player.top.x = moon.x + math.cos(player.angle + math.rad(4)) * moonDistance
    player.top.y = moon.y + math.sin(player.angle + math.rad(4)) * moonDistance

    player.gun.x = moon.x + math.cos(player.angle + math.rad(4)) * (moonDistance-10)
    player.gun.y = moon.y + math.sin(player.angle + math.rad(4)) * (moonDistance-10)

    player.aimAngle = math.atan2((mouse.y - player.top.y), (mouse.x - player.top.x))
    player.rotation = math.atan2((moon.y - player.top.y), (moon.x - player.top.x)) - math.pi/2


    if (player.inAir) then
        local g = 1500/moonDistance
        local xspeed = math.cos(player.angle)
        local yspeed = math.sin(player.angle)

        if (player.isMovingCounterClockwise or player.isMovingClockwise) then
            xspeed = xspeed * (player.speed.ccw + player.speed.cw)/2
            yspeed = yspeed * (player.speed.ccw + player.speed.cw)/2
        end

        player.velocity.x = player.velocity.x - g 
        player.x = player.x + player.velocity.x * xspeed * dt

        player.velocity.y = player.velocity.y - g
        player.y = player.y + player.velocity.y * yspeed * dt
    else
        player.velocity.y = 0
        player.velocity.x = 0
    end

    if moonDistance+2 < moon.r + player.height then
        player.x = (moon.r + player.height) * math.cos(player.angle) + moon.x + 2
        player.y = (moon.r + player.height) * math.sin(player.angle) + moon.y + 2
    end

    if (player.isJumping and not(player.inAir)) then
        player.velocity.y = 400
        player.velocity.x = 400
        player.x = (moonDistance + 10) * math.cos(player.angle) + moon.x
        player.y = (moonDistance + 10) * math.sin(player.angle) + moon.y
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

