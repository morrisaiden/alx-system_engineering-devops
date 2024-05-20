#!/usr/bin/python3
"""
 export data in the CSV format.
"""

import json
import requests
import sys


base_url = 'https://jsonplaceholder.typicode.com'

if __name__ == "__main__":

    user_id = sys.argv[1]
    user_url = '{}/users?id={}'.format(base_url, user_id)
    response = requests.get(user_url)
    data = response.text
    data = json.loads(data)
    user_name = data[0].get('username')
    tasks_url = '{}/todos?userId={}'.format(base_url, user_id)
    # print("tasks url
    response = requests.get(tasks_url)
    # pull data from api
    tasks = response.text
    # parse the data into JSON format
    tasks = json.loads(tasks)

    # build the csv
    builder = ""
    for task in tasks:
        builder += '"{}","{}","{}","{}"\n'.format(
            user_id,
            user_name,
            task['completed'],  # or use get method
            task['title']
        )
    with open('{}.csv'.format(user_id), 'w', encoding='UTF8') as myFile:
        myFile.write(builder)
