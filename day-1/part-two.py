from functools import reduce

def readmeasurements(f, window = 3):
    pos = f.tell()
    lineno = 0
    measurements = []
    
    while lineno < window:
        line = f.readline()
        if line == '':
            break
        
        measurements.append(int(line))
        lineno += 1

    if len(measurements) < window:
        f.seek(pos)
        return -1

    f.seek(pos)
    f.readline()
    return reduce(lambda x, y: x + y, measurements)
        

def getmeasurements():
    with open('input.txt', 'r') as f:
        larger_sum = 0
        last_window = -1
        window = readmeasurements(f)

        while window >= 0:
            if last_window >= 0:
                if window > last_window:
                    larger_sum += 1
            last_window = window
            window = readmeasurements(f)

        print(f"Answer: {larger_sum}")

if __name__ == '__main__':
    getmeasurements()
