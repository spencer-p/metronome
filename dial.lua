--
-- dial.lua
--
-- Copyright (c) 2016 Spencer Peterson
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- Except as contained in this notice, the name(s) of the above copyright holders
-- shall not be used in advertising or otherwise to promote the sale, use or
-- other dealings in this Software without prior written authorization.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
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
