--
-- main.lua
--

Class = require "hump.class"
vector = require "hump.vector"

require "dial"

function love.load()
	love.graphics.setBackgroundColor(0xff, 0xff, 0xff)
	tempo = Dial(love.graphics.getWidth()/2, love.graphics.getHeight()/2, love.graphics.getHeight()/4)
	--time = Dial(love.graphics.getWidth()/5, 4*love.graphics.getHeight()/5, love.graphics.getHeight()/8)
end

function love.update(dt)
	tempo:update(dt)
end

function love.draw()
	tempo:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(os.date("!%X", math.floor(tempo.value)))
end

function love.mousepressed(x, y)
	tempo:mousepressed()
end

function love.mousereleased(x, y)
	tempo:mousereleased()
end

function love.mousemoved(x, y, dx, dy)
	tempo:mousemoved(x, y, dx, dy)
end
