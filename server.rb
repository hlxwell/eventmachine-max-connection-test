require "bundler/setup"
require 'eventmachine'

$conn_num = 0

class ServerHandler < EventMachine::Connection
  def post_init
    $conn_num += 1
    puts "+++ Total #{$conn_num} clients connected"
  end

  def unbind
    # $conn_num -= 1
    # puts "--- unbinded -------- #{$conn_num}"
  end
end

new_size = EM.set_descriptor_table_size( 60000 )
puts "=== file descriptor size: #{new_size}"

EM.epoll if EM.epoll?
EM.kqueue = true if EM.kqueue?

EM.run do
  EM::start_server "0.0.0.0", 9999, ServerHandler
  puts "Started Server 9999 ..."
end
