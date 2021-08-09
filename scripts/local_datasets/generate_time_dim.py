import os
import sys
import pandas as pd

def generate(output_path):
    incr = 1000000000

    time_key = pd.DataFrame([i for i in range(0, 86400)])
    times = [i * incr for i in range(0, 86400)]
    times = pd.DataFrame(times)

    times = pd.to_datetime(times[0])

    hours = times.apply(lambda time: time.hour)
    minutes = times.apply(lambda time: time.minute)
    seconds = times.apply(lambda time: time.second)

    time_data = pd.concat([time_key, times, hours, minutes, seconds], axis=1)
    time_data.columns = ['time_id', 'time', 'hour', 'minute', 'second']
    time_data.to_csv(output_path, index=False)


if __name__ == '__main__':
    if not len(sys.argv) > 1:
        output_path = os.getcwd()
    else:
        output_path = sys.argv[1]
    
    output_path = os.path.join(output_path, 'time_dim.csv')

    generate(output_path)