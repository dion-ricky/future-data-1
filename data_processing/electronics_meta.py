import json
import os
import numpy as np


def main():
    filepath = '../datasets/amazon/.large_datasets/meta_Electronics.json'
    filesize = getFileSize(filepath)

    with open(filepath, 'r') as _f:
        lines = _f.readlines()

        # count = 0
        processed_size = 0
        for line in lines:
            # count += 1
            processed_size += len(line)

            # if (count == 5):
            #     break
            
            print("Progress: {}".format((processed_size/filesize)*100),
                flush=True)

            process(line)

            # print("{}: {}".format(count, line.strip()))


def preprocess(data):
    return (data.replace("\\'", '\'')
            .replace(': \"', ': \'')
            .replace(', \"', ', \'')
            .replace('\",', '\',')
            .replace('\"}', '\'}')

            .replace('"', '\\"')

            .replace('{\'', '{\"')
            .replace('\':', '\":')
            .replace(': \'', ': \"')
            .replace('[\'', '[\"')

            .replace(', \'', ', \"')
            .replace('\',', '\",')
            .replace('\']', '\"]')
            .replace('\'}', '\"}'))


def process(data):
    # print(data)
    data = preprocess(data)
    # print(data)

    try:
        data = json.loads(data)
    except Exception as e:
        print(data)
        raise e
    
    new_data = data.copy()

    new_data['categories'] = np.array(
                                new_data['categories']
                            ).flatten().tolist()

    if 'related' in new_data.keys():
        also_bought = (new_data['related']['also_bought']
                        if 'also_bought' in new_data['related']
                        else ''
                        )

        also_viewed = (new_data['related']['also_viewed']
                        if 'also_viewed' in new_data['related']
                        else ''
                        )

        bought_together = (new_data['related']['bought_together']
                            if 'bought_together' in new_data['related']
                            else ''
                            )

        new_data['also_bought'] = also_bought
        new_data['also_viewed'] = also_viewed
        new_data['bought_together'] = bought_together
    
    new_data.pop('salesRank', 'none')
    new_data.pop('related', 'none')

    saveData(new_data)


def saveData(data):
    filepath = './.large_datasets/meta_electronics_mod.json'
    
    with open(filepath, 'a') as _f:
        _f.write(
            json.dumps(data) + "\n"
        )


def getFileSize(filepath):
    with open(filepath, "rb") as f:
        return os.fstat(f.fileno()).st_size


if __name__ == '__main__':
    main()

