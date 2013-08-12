var iron_mq = require('iron_mq');
var imq = new iron_mq.Client(require('./.iron.json'));
var queue = imq.queue("tumblr");
var requestify = require('requestify');
var MongoClient = require('mongodb').MongoClient;
var database_string = require('./.mongolab.json');
var database = null;
var collections = null;


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
	queue.post({body: JSON.stringify(data)}, function(error, body) { console.log(body); });
}

// CHECK IF POSTED IN THE PAST
var find_record = function(data) {
	collection.find({id: data.id}).toArray(function(err, results) {
		if (results.length == 0) {
			insert_and_enqueue(data);
		} else {
			console.log(results.length);
		}
	});      
}

// LOOP THROUGH THE REDDIT ITEMS	
var process_items = function (response) {
	console.log('Processing Items');
    body = response.getBody();
	children = body["data"]["children"];

	for (var i = 0; i < children.length; i++) { 
		find_record(children[i]["data"]);
	}
	exit();
}


// FETCH FROM REDDIT
var fetch_items = function () {
	console.log('Fetch Reddit Items');
	requestify.get('http://www.reddit.com/r/funny.json').then(process_items);
}

// CONNECTED TO DB
var connected = function (err, db) {
	console.log('Connected to DB');
	if (err) throw err;
	database = db;
	collection = database.collection('items');
	fetch_items();	
}

// CLOSE DATABASE CONNECTION
var exit = function () {
	//database.close();
}

// START
var start = function () {
	console.log('Start');
	MongoClient.connect(database_string.url, connected);
}

console.log('Node Version: ' + process.version);
start();
