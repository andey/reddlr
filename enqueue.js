var config = require('./config.json');
var http = require('http');

// INITIALIZE IronMQ 
var iron_mq = require('iron_mq');
var imq = new iron_mq.Client(config.iron_mq);
var queue = imq.queue("tumblr");

// INITIALIZE MongoDB
var MongoClient = require('mongodb').MongoClient;

// GLOBAL VARIABLES
var database = null;
var collections = null;
var number_of_items = -1;
var items_processed = 0;

// IS THE POST SOMETHING WE WANT?
var is_valid = function(data) {	
	if (data.domain == "http://i.imgur.com") {
		return true;
	} else {
		return false;
	}
}

// INSERT INTO THE DATABASE AND QUEUE
var insert_and_enqueue = function(data) {
	collection.insert(data, function(err, docs) {});
	queue.post({body: JSON.stringify(data)}, function(error, body) { console.log(body); items_processed += 1; });
}

// CHECK IF POSTED IN THE PAST
var find_record = function(data) {
	collection.find({id: data.id}).toArray(function(err, results) {
		if (results.length == 0) {
			insert_and_enqueue(data);
		} else {
			console.log('skip');
			items_processed += 1;
		}
	});      
}

// LOOP THROUGH THE REDDIT ITEMS	
var process_items = function (response) {
	console.log('Processing Items');
	children = response["data"]["children"];
	number_of_items = children.length;

	for (var i = 0; i < children.length; i++) { 
		find_record(children[i]["data"]);
	}
}

// FETCH FROM REDDIT
var fetch_items = function () {
	console.log('Fetch Reddit Items');
	var data = '';
	http.get('http://www.reddit.com/r/funny.json', function(res) { 

		res.on('data', function(chunk) {
			data += chunk.toString();
		});

		res.on('end', function(){
			process_items(JSON.parse(data));
		});
		
	});
}

// CONNECTED TO DB
var connected = function (err, db) {
	console.log('Connected to DB');
	if (err) throw err;
	database = db;
	collection = database.collection('items');
	fetch_items();	
}

// CHECKING IF ALL ITEMS ARE DONE
var should_i_exit = function () {
	if (number_of_items == items_processed) {
		exit();	
	}	
}

// CLOSE DATABASE CONNECTION
var exit = function () {
	console.log('Exiting');	
	database.close();
	process.exit(0);
}

// START
var start = function () {
	console.log('Start');
	setInterval(function(){should_i_exit();},1000);
	MongoClient.connect(config.mongodb, connected);
}

start();
