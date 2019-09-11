
# == Class Response
#
# The "response" class is made to format the response through a template
#
# === Composition
#
# Definition of the _Response_ class composed of :
# * method initialize
# * method send

class Response implements IResponse
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
end
