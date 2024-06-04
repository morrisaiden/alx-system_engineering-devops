#!/usr/bin/python3
"""
prints the titles of the first 10 hot posts listed for a given subreddit
"""
from requests import get


def top_ten(subreddit):
    """
    function that queries the Reddit API
    """
    if subreddit and type(subreddit) is str:
        url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
        headers = {'user-agent': 'my-app/0.0.1'}
        params = {'limit': 10}
        req = get(url, params=params, headers=headers, allow_redirects=False)
        if req.status_code == 200:
            data = req.json()
            posts = data.get('data', {}).get('children', {})
            for post in posts:
                print(post.get('data').get('title'))
        else:
            print(None)
