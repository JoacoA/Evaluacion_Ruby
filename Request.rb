# == Class Request
#
# Author :: Joaquin Abeiro
#
# The "request" class is made to format the response through a template
#
# === Composition
#
# Definition of the _Request_ class composed of :
# * method parse
# * method parse_headers
# * method normalise


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