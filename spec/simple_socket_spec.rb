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

  it "should create a TCP socket with the correct parameters" do
    TCPSocket.should_receive(:new).with(host, port).and_return(a_stubbed_socket)
    SimpleSocket.new(host, port).write("foobar")
  end

  it "should return the sockets response" do
    with(a_stubbed_socket.that_returns("A response")) do 
      socket = SimpleSocket.new(host, port)
      socket.write("foo").should == "A response"
    end 
  end

  it "should send the message passed in to the socket" do
    with(a_stubbed_socket.that_expects_message_of("my message")) do 
      SimpleSocket.new(host, port).write("my message")
    end 
  end

  it "should close the socket" do
    with(a_stubbed_socket.that_requires_closing) do 
      SimpleSocket.new(host, port).write("foo")
    end 
  end
end
