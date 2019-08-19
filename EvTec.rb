# probando

require 'socket'

puts "Enter port: "
p = gets
puts "Well I don't care what port you want, I'm going to put it in 2020 because I can"
PORT = 2020
socket = TCPServer.new('localhost', PORT)

puts "Ctrl + c to stop"

loop {
  client  = server.accept
  request = client.readpartial(2048)
  puts request
}

def parse(request)
  method, path, version = request.lines[0].split
  {
    path: path,
    method: method,
    headers: parse_headers(request)
  }
end
def parse_headers(request)
  headers = {}
  request.lines[1..-1].each do |line|
    return headers if line == "\r\n"
    header, val= line.split
    header = normalize(header)
    headers[header] = val
  end
  def normalize(header)
    header.gsub(":", "").downcase.to_sym
  end
end
