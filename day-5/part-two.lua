local filename <const> = 'input.txt'

local VERTICAL   <const> = 'vertical'
local HORIZONTAL <const> = 'horizontal'
local DIAGONAL   <const> = 'diagonal'

function readinput()
    local fd <close> = io.open(filename, 'r')
    local lines = {}
    
    for line in fd:lines() do
        local x1, y1, x2, y2 = line:match("(%d+),(%d+) %-> (%d+),(%d+)")
        assert(x1, "error parsing line: " .. line)
        
        local lineObj = {{x = tonumber(x1), y = tonumber(y1)}, {x = tonumber(x2), y = tonumber(y2)}}
        if lineObj[1].x == lineObj[2].x then
            lineObj.type = VERTICAL
        elseif lineObj[1].y == lineObj[2].y then
            lineObj.type = HORIZONTAL
        else
            lineObj.type = DIAGONAL
        end

        table.insert(lines, lineObj)
    end

    return lines
end

function addvertical(points, line)
    local step = (line[1].y < line[2].y and 1) or -1

    for i = line[1].y, line[2].y, step do
        if points[line[1].x] == nil then
            points[line[1].x] = {}
        end

        points[line[1].x][i] = 1 + (points[line[1].x][i] or 0)
    end
end

function addhorizontal(points, line)
    local step = (line[1].x < line[2].x and 1) or -1

    for i = line[1].x, line[2].x, step do
        if points[i] == nil then
            points[i] = {}
        end

        points[i][line[1].y] = 1 + (points[i][line[1].y] or 0)
    end
end

function adddiagonals(points, line)
    local stepx = (line[1].x < line[2].x and 1) or -1
    local stepy = (line[1].y < line[2].y and 1) or -1

    x = line[1].x; y = line[1].y
    while (stepx > 0 and x <= line[2].x) or (stepx < 0 and x >= line[2].x) do
        if points[x] == nil then
            points[x] = {}
        end

        points[x][y] = 1 + (points[x][y] or 0)

        x = x + stepx
        y = y + stepy
    end
end

function printpoints(points)
    tbl = ""
    for y = 0, 9 do
        for x = 0, 9 do
            if points[x] == nil or points[x][y] == nil then
                tbl = tbl .. "."
            else
                tbl = tbl .. points[x][y]
            end
         end
         tbl = tbl .. "\n"
    end

    print(tbl)
end

function getoverlapping()
    local lines <const> = readinput()
    local points = {}

    for _, line in ipairs(lines) do
        if line.type == VERTICAL then
            addvertical(points, line)
        elseif line.type == HORIZONTAL then
            addhorizontal(points, line)
        else
            adddiagonals(points, line)
        end
    end

    --printpoints(points)
    --print()

    overlaps = 0
    for x, line in pairs(points) do
        for y, point in pairs(line) do
            if point >= 2 then
                overlaps = overlaps + 1
            end
        end
    end

    print("Overlaps: " .. overlaps)
end

getoverlapping()
