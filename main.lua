--
-- main.lua
--

vector = require "hump.vector"

function love.load()
	love.graphics.setBackgroundColor(0xff, 0xff, 0xff)
	dial = {
		center = vector(love.graphics.getWidth()/2, love.graphics.getHeight()/2),
		draw = function()
			love.graphics.setColor(0, 0, 0)
			love.graphics.circle("fill", dial.center.x, dial.center.y, 150)
			love.graphics.setColor(0xff, 0xff, 0xff)
			love.graphics.circle("fill", dial.center.x, dial.center.y, 30)
		end
	}
	num = 0
end

function love.update(dt)
	num = num - dt
	if num < 0 then num = 0 end
end

function love.draw()
	dial:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(os.date("!%X", math.floor(num)))
end

function love.mousepressed(x, y)
	mousedown = true
end

function love.mousereleased(x, y)
	mousedown = false
end

function love.mousemoved(x, y, dx, dy)
	if mousedown then
		local oldtocenter = vector(x-dx, y-dy) - dial.center
		local tocenter = vector(x, y) - dial.center
		local changeinangle = tocenter:angleTo(oldtocenter)
		if math.abs(changeinangle) > 6 then return end
		if changeinangle < 0 then
			num = num - 0.25
		else
			num = num + 0.25
		end
	end
end
