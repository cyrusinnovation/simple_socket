require 'socket'
require 'timeout'

class SimpleSocket
  attr_reader :host, :port, :timeout
  DEFAULT_TIMEOUT = 10

  def initialize(host, port, timeout = DEFAULT_TIMEOUT)
    @host = host
    @port = port
    @timeout = timeout 
  end

  def write(message)
    begin
      socket = TCPSocket.new(host, port)
      socket.puts(message)
      response = nil
      Timeout::timeout(timeout) do 
        response = socket.read
      end
    ensure
      socket.close
    end
    response
  end
end
