
-- Prints the entire grid led state for Grid Station
function print_grid_led_state()
	print("```")
	for y=1,grid_size_y() do
		local line=nil
		for x=1,grid_size_x() do
			if line==nil then
				line=grid_led_get(x,y)
			else
				line=line.." "..grid_led_get(x,y)
			end
		end
		print(line)
	end
	print("```")
end