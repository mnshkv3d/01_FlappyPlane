local ObjectLibrary = require("lib/ObjectLibrary")

local player
local obstacle

function love.load()
	-- Assets --
	bgImage = love.graphics.newImage("assets/background.png")
	groundImage = love.graphics.newImage("assets/groundSnow.png")
	gameOverImage = love.graphics.newImage("assets/textGameOver.png")
	-- Variables --
	test = 0
	positionBG = 0
	positionGround = 0
	charPosition = 240
	speedBG = 25
	speedGround = 100
	tapDelay = 0.25
	tapTimer = 0
	canTap = true
	gameOver = false
	-- Objects --
	player = ObjectLibrary:new(400 - 44, 240 - 73 / 2, 88, 73, "assets/planeGreen1.png")
	obstacle = ObjectLibrary:new(800, 480 - 235, 108, 239, "assets/rockSnow.png")
end

function love.update(dt)
	-- player:resolveCollision(ground)
	player:resolveCollision(obstacle)
	if not player.isColliding and not gameOver and player.y > 0 and player.y < 407 then
		positionBG = (positionBG - speedBG * dt) % bgImage:getWidth()
		positionGround = (positionGround - speedGround * dt) % groundImage:getWidth()
		obstacle.x = obstacle.x - speedGround * dt
		if not canTap then
			tapTimer = tapTimer + 1 * dt
			if tapTimer >= tapDelay then
				canTap = true
				tapTimer = 0
			end
		end
		if love.keyboard.isDown("space") and canTap then
			player.y = player.y - 15000 * dt
			canTap = false
		else
			player.y = player.y + 100 * dt
		end
	else
		gameOver = true
	end
end

function love.draw()
	love.graphics.draw(bgImage, positionBG, 0)
	love.graphics.draw(bgImage, positionBG - bgImage:getWidth(), 0)
	love.graphics.draw(groundImage, positionGround, 480 - groundImage:getHeight())
	love.graphics.draw(groundImage, positionGround - groundImage:getWidth(), 480 - groundImage:getHeight())
	obstacle:draw()
	player:draw()
	love.graphics.print("Debug: " .. "charPosition = " .. player.y, 0, 0)
	if gameOver then
		love.graphics.draw(gameOverImage, 400 - gameOverImage:getWidth() / 2, 240 - gameOverImage:getHeight() / 2)
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
