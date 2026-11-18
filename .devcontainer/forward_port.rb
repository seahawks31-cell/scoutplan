# Tiny TCP forwarder: makes the Mailcatcher web inbox (mailcatcher:1080) reachable on
# localhost:1080 inside this container, so Codespaces can show it in the PORTS tab.
# Usage: ruby .devcontainer/forward_port.rb LOCAL_PORT TARGET_HOST TARGET_PORT
require "socket"

local_port, target_host, target_port = ARGV[0].to_i, ARGV[1], ARGV[2].to_i
server = TCPServer.new("0.0.0.0", local_port)
loop do
  client = server.accept
  Thread.new(client) do |c|
    upstream = TCPSocket.new(target_host, target_port)
    pipes = [Thread.new { IO.copy_stream(c, upstream) rescue nil; upstream.close_write rescue nil },
             Thread.new { IO.copy_stream(upstream, c) rescue nil; c.close_write rescue nil }]
    pipes.each(&:join)
  rescue StandardError
    nil
  ensure
    c.close rescue nil
    upstream&.close rescue nil
  end
end
