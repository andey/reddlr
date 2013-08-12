var config = require('./config.json');

// INITIALIZE IronMQ
var iron_mq = require('iron_mq');
var imq = new iron_mq.Client(config.iron_mq);
var queue = imq.queue("tumblr");

// INITIALIZE Tumblr Client
var tumblr = require('tumblr.js');
var client = tumblr.createClient(config.tumblr);

//POST TO TUMBLR, AND POP OFF QUEUE
var post_to_tumblr = function (item) {
	console.log('Posting to Tumblr');
	client.post('funny.reddlr.com', { type: 'photo', caption: item.title, "source": item.url }, function (err, data) {
		if (data == undefined) {
			console.log(item);
			throw "Tumblr rejected post"; 
		};
		console.log(data); // PRINT POST META
  	queue.del(item.id, function(error, body) { console.log("Removed from the queue"); });
	});
}

//LOOK AT ITEM FROM THE QUEUE
var process = function (error, item) {
	if (item) {
		console.log("Processing: " + String(item.id));
		post_to_tumblr(JSON.parse(item.body));
	} else {
		console.log("No item in the queue");
	}	
};

//START
queue.get({}, process);
