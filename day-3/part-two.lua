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

function calculatebitsum(data, pos)
    local bitsum = {}
    bitsum["0"] = 0
    bitsum["1"] = 0

    for _, number in ipairs(data) do
        if number[pos] == 1 then
            bitsum["1"] = bitsum["1"] + 1
        else
            bitsum["0"] = bitsum["0"] + 1
        end
    end

    return bitsum
end

function copydata(data)
    local tmp = {}

    for i, number in ipairs(data) do
        tmp[i] = {}
        for j, bit in ipairs(number) do
            tmp[i][j] = bit
        end
    end

    return tmp
end

function removenumbers(data, bitcriteria, pos)
    local numberno = 1
    local size = #data

    while numberno <= size do
        local number = data[numberno]
        if number[pos] == bitcriteria then
            table.remove(data, numberno)
            size = size - 1
        else
            numberno = numberno + 1
        end
    end
end

function calculateoxygen(data)
    local data_tmp = copydata(data)
    local data_size = #data_tmp
    local number_size = #data_tmp[1]
    local bitno = 1

    while (data_size > 1) and (bitno <= number_size) do
        -- calculate bitsum of current data
        local bitsum = calculatebitsum(data_tmp, bitno)
        local bit_to_remove = nil
        
        -- check the bit criteria
        if bitsum["1"] >= bitsum["0"] then
            bit_to_remove = 0
        else
            bit_to_remove = 1
        end

        -- remove the number using the bit criteria
        removenumbers(data_tmp, bit_to_remove, bitno)
        data_size = #data_tmp
        bitno = bitno + 1
    end

    if (data_size > 1) then
        error("there are " .. data_size .. " numbers remained in 'calculate oxygen'")
    end

    local oxygen = ""
    for _, bit in ipairs(data_tmp[1]) do
        oxygen = oxygen .. tostring(bit)
    end

    return oxygen
end

function calculateco2(data)
    local data_tmp = copydata(data)
    local data_size = #data_tmp
    local number_size = #data_tmp[1]
    local bitno = 1

    while (data_size > 1) and (bitno <= number_size) do
        -- calculate bitsum of current data
        local bitsum = calculatebitsum(data_tmp, bitno)
        local bit_to_remove = nil

        -- check the bit criteria
        if bitsum["0"] <= bitsum["1"] then
            bit_to_remove = 1
        else
            bit_to_remove = 0
        end

        -- remove the numbers using the bit criteria
        removenumbers(data_tmp, bit_to_remove, bitno)
        data_size = #data_tmp
        bitno = bitno + 1
    end

    if (data_size > 1) then
        error("there are " .. data_size .. " numbers remainded in 'calculate co2'")
    end

    local co2 = ""
    for _, bit in ipairs(data_tmp[1]) do
        co2 = co2 .. tostring(bit)
    end

    return co2
end

function calculatelifesupport()
    local data <const> = loadinput()
    local oxygen = calculateoxygen(data)
    local co2 = calculateco2(data)

    print("Oxygen: " .. oxygen .. " (" .. tonumber(oxygen, 2) .. ")")
    print("CO2: " .. co2 .. " (" .. tonumber(co2, 2) .. ")")
    print("Life support: " .. tonumber(oxygen, 2) * tonumber(co2, 2))
end

calculatelifesupport()

