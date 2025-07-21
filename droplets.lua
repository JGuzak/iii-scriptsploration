
grid_led_all(0)
grid_refresh()

local MAX_X = grid_size_x()
local MAX_Y = grid_size_y()
local MAX_AGE = 16

local droplets = {}

function age_droplets()
	for index, value in pairs(droplets) do
		droplets[index] = value - 1

		grid_led(index[1], index[2], droplets[index])

		if (droplets[index] == 0) then
			droplets[index] = nil
		end
	end
	grid_refresh()
end

function seed_droplet()
	local x_pos = math.random(1, MAX_X+1)
	local y_pos = math.random(1, MAX_Y+1)

	droplets[{x_pos, y_pos}] = MAX_AGE
end

metro.new(tick, 100)

function tick()
	age_droplets()

	local seed = math.random(0, 100)
	if (seed > 70) then
		seed_droplet()
	end
end



grid = function(x,y,z)
	grid_refresh()
end
