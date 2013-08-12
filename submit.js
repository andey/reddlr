var iron_mq = require('iron_mq');
var imq = new iron_mq.Client(require('./.iron.json'));
var queue = imq.queue("tumblr");
var tumblr = require('tumblr.js');
var client = tumblr.createClient(require('./.tumblr.json'));


//POST TO TUMBLR, AND POP OFF QUEUE
var post_to_tumblr = function (item) {
	console.log('Posting to Tumblr');
	client.post('funny.reddlr.com', { type: 'photo', caption: item.title, "source": item.url }, function (err, data) {
		console.log(data);
    	queue.del(item.id, function(error, body) { console.log("Removed from the queue"); });
	});
}

//LOOK AT WHAT ITEM FROM THE QUEUE
var process = function (error, item) {
	if (item) {
		console.log("Processing: " + String(item.id));
		body = JSON.parse(item.body);
		post_to_tumblr(body);
	} else {
		console.log("No item in the queue");
	}	
};

//START
console.log('Node Version: ' + process.version);
queue.get({}, process);
