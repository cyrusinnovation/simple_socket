require_relative '../lib/simple_socket'

module MockHelpers
  def that_returns(response)
    self.should_receive(:read).and_return(response)
    self
  end

  def that_expects_message_of(message)
    self.should_receive(:puts).with(message)
    self
  end

  def that_requires_closing
    self.should_receive(:close)
    self
  end
end

def a_stubbed_socket
  double("tcpsocket").tap do |s|
    s.stub(:puts)
    s.stub(:read)
    s.stub(:close)
  end.extend(MockHelpers)
end

def with(socket)
  TCPSocket.stub(:new => socket)
  yield
end
