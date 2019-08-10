# probando

require 'socket'
PORT = 8081
socket = TCPServer.new('0.0.0.0', PORT)
def handle_connection(client)
  puts "Hello! #{client}"
  client.write("Hello!")
  client.close
end

puts "Listening on #{PORT}. Press CTRL+C to cancel."
loop do
  client = socket.accept
  Thread.new { handle_connection(client) }
end