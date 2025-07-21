
grid_led_all(0)
grid_refresh()

local MAX_X = grid_size_x()
local MAX_Y = grid_size_y()

local sprite = {
}


metro = function(index, count)
	tick_sprite()
end

grid = function(x,y,z)
	-- grid_refresh()
end

metro_set(1, 75)