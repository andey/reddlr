var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('<a href="http://sk3tchy.com">Sk3tchy.com</a> Database Server');
}).listen(process.env.VMC_APP_PORT || 1337, null);
