require "bundler/setup"
require 'eventmachine'

module ClientHandler
  def post_init
  end

  def unbind
  end
end


EM.run do
  EM.epoll if EM.epoll?
  EM.kqueue = true if EM.kqueue?

  puts "=== file descriptor size: #{EM.set_descriptor_table_size}"

  EM.add_periodic_timer(0.001) do
    5.times {
      EM.connect "127.0.0.1", 9999, ClientHandler
    }
  end
end