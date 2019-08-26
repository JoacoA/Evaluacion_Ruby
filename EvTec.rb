# = EvTec.rb
# Author :: Joaquin Abeiro

require 'socket'
require "test/unit"
# require 'memcached' file not found error !!!!!!!!!!!!

# == Class Tester
#
# This class test the server
#
# === Composition
#
# Definition of the _Tester_ class composed of :
# * method test_parse
# * method test_response
# * method test_failure

class Tester < Test::Unit::TestCase

  # def test_parse(request)
  #   assert_equal(3, (parse(request).length))
  #   assert_equal(3, (parse_headers(request).length))
  # end

  # def test_response
  #   assert_equal(4, Response.new(200," ").add(2) )
  # end

  # def test_failure
  #   assert_equal(4, (parse(request).length), "Something doesn't work" )
  # end

end

# == Class Response
#
# The "response" class is made to format the response through a template
#
# === Composition
#
# Definition of the _Response_ class composed of :
# * method initialize
# * method send

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
end

puts "
The server will accept connections on port 2020"
PORT = 2020
server = TCPServer.new('localhost', PORT)
puts "Ctrl + c to stop"

# Functions  that are dedicated to parse the request
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
end

def normalize(header)
  header.gsub(":", "").downcase.to_sym
end

#Response functions
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
  # Code 200 = code OK
end
def file_not_found
  Response.new(code: 404)
  # Clasic error 404
end

#Loop to accept conections
loop {
  client  = server.accept
  request = client.readpartial(2048)
  request  = parse(request)
  response = prepare_response(request)
  puts "#{client.peeraddr[3]} #{request.fetch(:path)} - #{response.code}"
  response.send(client)
  client.close
}
