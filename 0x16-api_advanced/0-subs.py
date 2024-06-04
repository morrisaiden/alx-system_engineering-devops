#!/usr/bin/python3
"""
returns the number of subscribers (not active users, total subscribers)
 for a given subreddit
"""
from requests import get


def number_of_subscribers(subreddit):
    """
     returns number of subscribers
    """
    if subreddit and type(subreddit) is str:
        subscribers = 0
        url = 'https://reddit.com/r/{}/about.json'.format(subreddit)
        headers = {'user-agent': 'my-app/0.0.1'}
        req = get(url, headers=headers)
        if req.status_code == 200:
            data = req.json()
            subscribers = data.get('data', {}).get('subscribers', 0)
        return subscribers
