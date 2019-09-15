# EvTec.rb
# Author :: Joaquin Abeiro

require 'socket'
require "test/unit"

puts "
The server will accept connections on port 2020"
PORT = 2020
server = TCPServer.new('localhost', PORT)
puts "Ctrl + c to stop"


#Loop to accept conections
loop {
  client  = server.accept
  request = client.readpartial(2048)
  request  = parse(request)
  response = prepare_response(request)
  puts "#{client.peeraddr[3]} #{request.fetch(:path)} "
  response.send(client)
  client.close
}

#  112  request  = RequestParser.new.parse(request)
#  113  response = ResponsePreparer.new.prepare(request)
#  114  - #{response.code}
