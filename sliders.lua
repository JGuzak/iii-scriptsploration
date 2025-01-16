local MAX_X = grid_size_x()
local MAX_Y = grid_size_y()

Slider = {
	direction = "down",
	length = 2,
	width = 1,
	x = 1,
	y = 1,
	min = 0,
	max = 127,
	speed = 1,
	position = 0,
	move_callback = function ()	end
}

function Slider:_calculate_distance()
	local distance = 0
	if (self.direction == "up") then
		distance = self.y + length
	elseif (self.direction == "down") then
		distance = self.y - length
	elseif (self.direction == "left") then
		distance = self.x - length
	elseif (self.direction == "right") then
		distance = self.x + length
	end
	return distance
end

function Slider:_orientation_safe_end_position()
	local x_end, y_end = 0
	if (self.direction == "up") then
		x_end = self.x
		y_end = self.y + length
	elseif (self.direction == "down") then
		x_end = self.x
		y_end = self.y - length
	elseif (self.direction == "left") then
		x_end = self.x - length
		y_end = self.y
	elseif (self.direction == "right") then
		x_end = self.x + length
		y_end = self.y
	end
	return {x_end, y_end}
end

function Slider:_draw_boarder()
	grid_led(self.x, self.y, 2)

end

function Slider:create(o)
	o.parent = self
	return o
end

function Slider:move(x, y)
	-- Move position towards
end

function Slider:draw()
	-- Draw top, bottom, and middle lines
	_draw_boarder()
	-- Calculate delta between position and minimum
	-- 
end