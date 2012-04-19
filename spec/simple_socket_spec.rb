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

  it "should wrap the socket read with a timeout" do
    with(a_stubbed_socket) do
      Timeout.should_receive(:timeout).with(SimpleSocket::DEFAULT_TIMEOUT) 
      SimpleSocket.new(host, port).write("foo")
    end 
  end

  it "should close the socket even if an exceptions is raised" do
    with(a_stubbed_socket.that_requires_closing) do 
      Timeout.stub(:timeout).and_raise(Timeout::Error)
      lambda {SimpleSocket.new(host, port).write("foo")}.should raise_error
    end 
  end

  it "should return correct error if no connection is made" do
    expect {
      SimpleSocket.new("foobar", 123).write("foo")
    }.to raise_error(SocketError)
  end
end
