var net = require("net"), util = require('util');

var server = net.createServer(function (stream) {
  stream.setEncoding("utf8");
  stream.on("connect", function () {
    util.puts(server.connections);
  });
  stream.on("data", function (data) {
  });
  stream.on("end", function () {
  });
});
server.listen(9999, "0.0.0.0");

console.log("created server on 9999 port");
