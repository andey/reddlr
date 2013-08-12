reddlr
======

> This app uses the reddit api to grab posts, select images, and post them tumblr.

Dependencies:
* iron_mq
* mongodb
* tumblr.js

Setup
------
    # npm install

Enqueue
------    
    # iron_worker run enqueue.worker
    
Submit
------   
    # iron_worker run submit.worker
