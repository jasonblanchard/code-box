require 'net/http'
require 'json'

host = '192.168.59.103'
#host = 'localhost'
port = '8081'

url = URI.parse("http://#{host}:#{port}")
code = File.read("code.txt")
code = code.gsub('\r\n', ";").chomp
puts code
#code = 'a = "cats"; puts "hello #{a}"'
#code = "a = 'cats'; puts \"hello \#{a}\""
#code = 'class Animal; def growl; puts "arg"; end; end; Animal.new.growl'
resp = Net::HTTP.post_form url, {'input' => {'code' => code }.to_json}
puts resp.body
