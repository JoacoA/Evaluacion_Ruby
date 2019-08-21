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

SERVER_ROOT = "/tmp/web-server/"
def prepare_response(request)
  if request.fetch(:path) == "/"
    respond(SERVER_ROOT + "index.html")
  else
    respond(SERVER_ROOT + request.fetch(:path))
  end
end
def respond(path)
  if File.exists?(path)
    ok_response(File.binread(path))
  else
    file_not_found
  end
end

def ok_response(data)
  Response.new(code: 200, data: data)
  # Codigo 200 = codigo OK
end
def file_not_found
  Response.new(code: 404)
end

class Response
  def initialize(code:,data: "")
    @response=
    "HTTP/1.1 #{code}\r\n" +
    "Content-Length: #{data.size}\r\n" +
    "\r\n" +
    "#{data}\r\n"
  end
  def send(client)
    client.write(@response)
  end

loop

