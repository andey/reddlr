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

Create Credentials Files
    .iron.json {"token":"XXX","project_id":"XXX"}
    .mongolab.json {"url":"mongodb://user:password@mongolab.com:9999/db"}
    .tumblr.json {"consumer_key":"XXX","consumer_secret":"XXX","token":"XXX","token_secret":"XXX"}
    

Enqueue
------    
    # iron_worker run enqueue.worker
    
Submit
------   
    # iron_worker run submit.worker
