require 'socket'

class SimpleSocket
  attr_reader :host, :port, :timeout
  DEFAULT_TIMEOUT = 10

  def initialize(host, port, timeout = DEFAULT_TIMEOUT)
    @host = host
    @port = port
    @timeout = timeout 
  end

  def write(message)
    socket = TCPSocket.new(host, port)
    socket.puts(message)
    response = socket.read
    socket.close
    response
  end
end
