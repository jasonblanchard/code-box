require 'net/telnet'

host = Net::Telnet::new("Host" => '192.168.59.103', "Port" => "8081")

host.cmd('a=\'cats\'; puts "hello #{a}"') do |resp|
  puts resp
end

host.close
