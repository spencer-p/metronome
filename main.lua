--
-- main.lua
--

Class = require "hump.class"
vector = require "hump.vector"

require "dial"

function love.load()
	love.graphics.setBackgroundColor(0xff, 0xff, 0xff)
	tempo = Dial(love.graphics.getWidth()/2, love.graphics.getHeight()/3, love.graphics.getHeight()/4)
	time = Dial(4*love.graphics.getWidth()/5, 4*love.graphics.getHeight()/5, love.graphics.getHeight()/8)
	targettempo = Dial(love.graphics.getWidth()/5, 4*love.graphics.getHeight()/5, love.graphics.getHeight()/8)
end

function love.resize()
	tempo.pos, tempo.radius = vector(love.graphics.getWidth()/2, love.graphics.getHeight()/3), love.graphics.getHeight()/4
	time.pos, time.radius = vector(4*love.graphics.getWidth()/5, 4*love.graphics.getHeight()/5), love.graphics.getHeight()/8
	targettempo.pos, targettempo.radius = vector(love.graphics.getWidth()/5, 4*love.graphics.getHeight()/5), love.graphics.getHeight()/8
end

function love.update(dt)
	tempo:update(dt)
	time:update(dt)
	targettempo:update(dt)
end

function love.draw()
	tempo:draw()
	time:draw()
	targettempo:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(os.date("!%X", math.floor(tempo.value)))
end

function love.mousepressed(x, y)
	tempo:mousepressed(x, y)
	time:mousepressed(x, y)
	targettempo:mousepressed(x, y)
end

function love.mousereleased(x, y)
	tempo:mousereleased(x, y)
	time:mousereleased(x, y)
	targettempo:mousereleased(x, y)
end

function love.mousemoved(x, y, dx, dy)
	tempo:mousemoved(x, y, dx, dy)
	time:mousemoved(x, y, dx, dy)
	targettempo:mousemoved(x, y, dx, dy)
end
