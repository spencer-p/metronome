--
-- main.lua
--

Class = require "hump.class"
vector = require "hump.vector"

require "dial"

function love.load()
	bigFont = love.graphics.newFont(64)
	littleFont = love.graphics.newFont(36)
	love.graphics.setBackgroundColor(0xff, 0xff, 0xff)
	tempo = Dial(love.graphics.getWidth()/2, love.graphics.getHeight()/2, love.graphics.getHeight()/5)
	time = Dial(3*love.graphics.getWidth()/4, 5*love.graphics.getHeight()/6, love.graphics.getHeight()/9)
	targettempo = Dial(love.graphics.getWidth()/4, 5*love.graphics.getHeight()/6, love.graphics.getHeight()/9)
	increment = 0
end

function love.update(dt)
	time.value = time.value - dt

	tempo:update(dt)
	time:update(dt)
	targettempo:update(dt)

	if targettempo.value > tempo.value and time.value > 0 and not time.pressed then
		tempo.value = tempo.value + dt * increment
	end
end

function love.draw()
	tempo:draw()
	time:draw()
	targettempo:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(bigFont)
	love.graphics.printf(math.floor(tempo.value),
		0, love.graphics.getHeight()/9, love.graphics.getWidth(), "center")
	love.graphics.setFont(littleFont)
	love.graphics.printf(math.floor(targettempo.value).." in "..os.date("!%X", math.floor(time.value)),
		0, love.graphics.getHeight()/9 + 3*64/2, love.graphics.getWidth(), "center")
end

function love.mousepressed(x, y)
	tempo:mousepressed(x, y)
	time:mousepressed(x, y)
	targettempo:mousepressed(x, y)
end

function love.mousereleased(x, y)
	if time.pressed or tempo.pressed or targettempo.pressed then 
		increment = (targettempo.value - tempo.value) / time.value 
	end
	tempo:mousereleased(x, y)
	time:mousereleased(x, y)
	targettempo:mousereleased(x, y)
end

function love.mousemoved(x, y, dx, dy)
	tempo:mousemoved(x, y, dx, dy)
	time:mousemoved(x, y, dx, dy)
	targettempo:mousemoved(x, y, dx, dy)
end
