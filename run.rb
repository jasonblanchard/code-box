require 'net/http'

host = '192.168.59.103'
#host = 'localhost'
port = '8081'

url = URI.parse("http://#{host}:#{port}")
resp = Net::HTTP.post_form url, {'code' => 'a = "cats"; puts "hello #{a}"'}
puts resp.body
