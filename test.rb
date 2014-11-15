require 'net/http'

url = URI.parse('http://192.168.59.103:8081')
resp = Net::HTTP.post_form url, {'code' => 'a = "cat"; puts "hello #{a}"'}
puts resp.body
