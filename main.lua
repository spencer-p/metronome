--
-- main.lua
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

	metronome = {
		click = love.audio.newSource("click.ogg"),
		counter = 0
	}

	running = true
end

function love.update(dt)
	if not running then return end

	if tempo.value > 0 then
		metronome.counter = metronome.counter + dt
		if metronome.counter >= 60/tempo.value then
			metronome.click:play()
			metronome.counter = metronome.counter - 60/tempo.value
		end
	end

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
	love.graphics.printf(math.floor(tempo.value)..(running and "" or " - mute"),
		0, love.graphics.getHeight()/9, love.graphics.getWidth(), "center")
	love.graphics.setFont(littleFont)
	love.graphics.printf(math.floor(targettempo.value).." in "..os.date("!%X", math.floor(time.value)),
		0, love.graphics.getHeight()/9 + 3*64/2, love.graphics.getWidth(), "center")
end

function love.focus(f)
	running = f
end

function love.mousepressed(x, y)
	if y < 3*love.graphics.getHeight()/10 then
		running = not running
	end
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
