require_relative 'spec_helper'

describe SimpleSocket do
  let(:host) { "myhost" }
  let(:port) { 1151 }

  it "should create a simple socket with a default timeout" do
    socket = SimpleSocket.new(host, port)
    socket.host.should == host
    socket.port.should == port
    socket.timeout.should == SimpleSocket::DEFAULT_TIMEOUT
  end

  it "should allow specifying a timeout" do
    socket = SimpleSocket.new(host, port, 3)
    socket.timeout.should == 3
  end

end
