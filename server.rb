require 'eventmachine'
require "stringio"
require 'em-http-server'
require 'cgi'

class HTTPHandler < EM::HttpServer::Server
  
  def process_http_request
    response = EM::DelegatedHttpResponse.new(self)
    response.status = 200
    response.content_type 'text/html'
    code = CGI.parse(@http_content)['code'][0]
    puts "Executing `#{code}`"
    output = eval("begin $stdout = StringIO.new; #{code}; $stdout.string;
  ensure $stdout = STDOUT end")
    response.content = output
    response.send_response
  end

end

EM::run do
  EM::start_server("0.0.0.0", 8081, HTTPHandler)
end
