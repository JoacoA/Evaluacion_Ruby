# probando

require 'socket'

puts "Enter port: "
p = gets
puts "Well I don't care what port you want, I'm going to put it in 2020 because I can"
PORT = 2020
socket = TCPServer.new('localhost', PORT)
def handle_connection(client)
  puts "Good Morning! #{client}"
  client.write("Good Afternoon")
  client.close
end

puts "Listening on #{PORT}. Press CTRL+C to cancel."
loop do
  client = socket.accept
  Thread.new { handle_connection(client) }
end

#-falta implementar memcached-#



