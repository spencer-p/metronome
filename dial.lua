--
-- dial.lua
--

Dial = Class{}

function Dial:init(x, y, radius)
	self.isDial = true
	self.pos, self.radius = vector(x, y), radius
	self.value = 0
end

function Dial:update(dt)
	if self.value < 0 then self.value = 0 end
end

function Dial:draw()
	love.graphics.setColor(0x15, 0x15, 0x15)
	love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
	love.graphics.setColor(0x6f, 0xc2, 0xef)
	love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius/3)
end

function Dial:mousepressed(x, y)
	self.pressed = self.pos:dist(vector(x, y)) <= self.radius
end

function Dial:mousereleased(x, y)
	self.pressed = false
end

function Dial:mousemoved(x, y, dx, dy)
	if self.pressed then
		local oldtocenter = vector(x-dx, y-dy) - self.pos
		local tocenter = vector(x, y) - self.pos
		local changeinangle = tocenter:angleTo(oldtocenter)
		if math.abs(changeinangle) > 6 then return end
		if changeinangle < 0 then
			self.value = self.value - math.abs(changeinangle*10)
		else
			self.value = self.value + math.abs(changeinangle*10)
		end
	end
end
