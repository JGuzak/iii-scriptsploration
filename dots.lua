
grid_led_all(0)
grid_refresh()

local MAX_X = grid_size_x()
local MAX_Y = grid_size_y()
local MAX_AGE = 16

local droplets = {}

function age_droplets()
	for x = 1, MAX_X, 1 do
		for y = 1, MAX_Y, 1 do
			grid_led_rel(x, y, -1, 0, 16)
		end
	end
	grid_refresh()
end

function seed_droplet()
	local x = math.random(1, MAX_X+1)
	local y = math.random(1, MAX_Y+1)
	grid_led(x, y, MAX_AGE)
end

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

metro.new(tick, 100, -1)
