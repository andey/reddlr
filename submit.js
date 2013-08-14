var config = require('./config.json');

// INITIALIZE IronMQ
var iron_mq = require('iron_mq');
var imq = new iron_mq.Client(config.iron_mq);
var queue = imq.queue("tumblr");

// INITIALIZE Tumblr Client
var tumblr = require('tumblr.js');
var client = tumblr.createClient(config.tumblr);

// FIND SUBREDDIT
var get_tags = function(s) {
	tags = 'reddlr';
	for (i = 0; i < config.subreddits.length; i++) {
		if (s == config.subreddits[i].r) {
			tags = config.subreddits[i].tags;			
		}
	}
	return tags;
}

//POST TO TUMBLR, AND POP OFF QUEUE
var post_to_tumblr = function (item) {
	console.log('Posting to Tumblr');
	queue.del(item.id, function(error, body) { console.log("Removed from the queue"); });
	body = JSON.parse(item.body);
	subreddit = body.subreddit;
	tumblr_path = 'reddlr-' + subreddit.toLowerCase() + '.tumblr.com';
	console.log(tumblr_path);
	client.post( tumblr_path, { type: 'photo', caption: body.title, "source": body.url, "tags": get_tags(subreddit) }, function (err, data) {
		if (data == undefined) {
			console.log(body);
			throw "Tumblr rejected post"; 
		};
		console.log(data); // PRINT POST META
	});
}

//LOOK AT ITEM FROM THE QUEUE
var process = function (error, item) {
	if (item) {
		console.log("Processing: " + String(item.id));
		post_to_tumblr(item);
	} else {
		console.log("No item in the queue");
	}	
};

//START
queue.get({}, process);
