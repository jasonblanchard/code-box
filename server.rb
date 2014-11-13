require 'eventmachine'
require "stringio"

module EchoServer
  def post_init
    send_data "Enter some code:\n\n"
  end

  def receive_data data
    puts "Executing code"
    code = data.to_s
    output = eval("begin $stdout = StringIO.new; #{code}; $stdout.string;
  ensure $stdout = STDOUT end")
    send_data output
  end
end

EventMachine.run {
  EventMachine.start_server "0.0.0.0", 8081, EchoServer
  puts 'running echo server on 8081'
}
