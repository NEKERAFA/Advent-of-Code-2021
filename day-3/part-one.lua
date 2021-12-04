function loadinput()
    local fd <close> = io.open('input.txt', 'r')
    local data = {}

    local lineno = 1
    for line in fd:lines() do
        data[lineno] = {}

        local charno = 1
        for char in line:gmatch('.') do
            data[lineno][charno] = tonumber(char)
            charno = charno + 1
        end

        lineno = lineno + 1
    end
    
    return data
end

function calculategamma(data)
    local bitsum = {}
    bitsum["0"] = {}
    bitsum["1"] = {}

    for i = 1, #data do
        for j = 1, #data[i] do
            if data[i][j] == 1 then
                bitsum["1"][j] = 1 + (bitsum["1"][j] or 0)
            else
                bitsum["0"][j] = 1 + (bitsum["0"][j] or 0)
            end
        end
    end

    local gamma = ""
    for i = 1, #bitsum["0"] do
        if bitsum["0"][i] > bitsum["1"][i] then
            gamma = gamma .. "0"
        else
            gamma = gamma .. "1"
        end
    end

    return gamma
end

function calculateepsilon(gamma)
    local epsilon = ""
    for bit in gamma:gmatch('.') do
        if tonumber(bit) == 1 then
            epsilon = epsilon .. "0"
        else
            epsilon = epsilon .. "1"
        end
    end

    return epsilon
end

function calculatepower()
    local data <const> = loadinput()
    local gamma <const> = calculategamma(data)
    local epsilon <const> = calculateepsilon(gamma)

    print("Gamma: " .. gamma .. " (" .. tonumber(gamma, 2) .. ")")
    print("Epsilon: " ..  epsilon .. " (" .. tonumber(epsilon, 2) .. ")")
    print("Power consumption: " .. tonumber(gamma, 2) * tonumber(epsilon, 2))
end

calculatepower()

