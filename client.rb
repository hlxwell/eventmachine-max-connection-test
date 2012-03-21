require "bundler/setup"
require 'eventmachine'

# $conn_num = 0

module ClientHandler
  def post_init
    # puts "Starting connect #{$conn_num += 1}"
  end

  def unbind
    # puts "unbinded -------- ${$conn_num -= 1}"
  end
end

new_size = EM.set_descriptor_table_size( 60000 )
puts "=== file descriptor size: #{new_size}"

EM.epoll if EM.epoll?
EM.kqueue = true if EM.kqueue?

EM.run do
  EM.add_periodic_timer(0.001) do
    EM.connect "127.0.0.1", 9999, ClientHandler
  end
end