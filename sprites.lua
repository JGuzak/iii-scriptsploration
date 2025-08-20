grid_led_all(0)
grid_refresh()

local MAX_X = grid_size_x()
local MAX_Y = grid_size_y()

local Sprite = {}
Sprite.__index = Sprite

function Sprite.new(width, height)
    local self = setmetatable({}, Sprite)
    self.width = width or MAX_X
    self.height = height or MAX_Y
    self.data = {}

    for x = 1, self.width do
        self.data[x] = {}
        for y = 1, self.height do
            self.data[x][y] = 0
        end
    end
    
    return self
end

function Sprite:set_pixel(x, y, brightness)
    if x >= 1 and x <= self.width and y >= 1 and y <= self.height then
        self.data[x][y] = clamp(brightness, 0, 15)
    end
end

function Sprite:get_pixel(x, y)
    if x >= 1 and x <= self.width and y >= 1 and y <= self.height then
        return self.data[x][y]
    end
    return 0
end

function Sprite:clear()
    for x = 1, self.width do
        for y = 1, self.height do
            self.data[x][y] = 0
        end
    end
end

function Sprite:fill(brightness)
    brightness = clamp(brightness, 0, 15)
    for x = 1, self.width do
        for y = 1, self.height do
            self.data[x][y] = brightness
        end
    end
end

function Sprite:load_data(data_array)
    -- Load sprite from 2D array and auto-detect dimensions
    -- data_array should be indexed as data_array[x][y]
    if not data_array then return false end

    local new_width = #data_array
    local new_height = 0
    for x = 1, new_width do
        if data_array[x] and #data_array[x] > new_height then
            new_height = #data_array[x]
        end
    end

    if new_width == 0 or new_height == 0 then return false end

    self.width = new_width
    self.height = new_height
    self.data = {}
    for x = 1, self.width do
        self.data[x] = {}
        for y = 1, self.height do
            self.data[x][y] = 0
        end
    end
    for x = 1, self.width do
        for y = 1, self.height do
            if data_array[x] and data_array[x][y] then
                self.data[x][y] = clamp(data_array[x][y], 0, 15)
            end
        end
    end
    
    return true
end


function Sprite:draw(pos_x, pos_y)
    pos_x = pos_x or 1
    pos_y = pos_y or 1
    
    for x = 1, math.min(self.width, MAX_X - pos_x + 1) do
        for y = 1, math.min(self.height, MAX_Y - pos_y + 1) do
            local grid_x = x + pos_x - 1
            local grid_y = y + pos_y - 1
            if grid_x >= 1 and grid_x <= MAX_X and grid_y >= 1 and grid_y <= MAX_Y then
                if self.data[x][y] > 0 then
                    grid_led(grid_x, grid_y, self.data[x][y])
                end
            end
        end
    end
end

function Sprite:print()
    print("Sprite " .. self.width .. "x" .. self.height .. ":")
    for y = 1, self.height do
        local line = ""
        for x = 1, self.width do
            local val = self.data[x][y]
            if val == 0 then
                line = line .. "."
            elseif val < 10 then
                line = line .. tostring(val)
            else
                line = line .. string.char(65 + val - 10)
            end
        end
        print(line)
    end
end

local sprite = null

sprite_data = {
    {8, 8, 15},
    {7, 8, 8},
    {9, 8, 8},
    {8, 7, 8},
    {8, 9, 8},
}
sprite = Sprite.new(16, 16)

sprite.load_data(sprite_data)


function tick_sprite()
    Sprite.draw(sprite, 1, 1)
end

metro.new(tick_sprite, 75)
