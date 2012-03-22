require "bundler/setup"
require 'eventmachine'

class ServerHandler < EventMachine::Connection
  def post_init
    puts "+++ Total #{EM.connection_count} clients connected"
  end

  def unbind
  end
end

EM.epoll if EM.epoll?
EM.kqueue = true if EM.kqueue?

puts "=== file descriptor size: #{EM.set_descriptor_table_size}"

EM.run do
  EM::start_server "0.0.0.0", 9999, ServerHandler
  puts "Started Server 9999 ..."
end
