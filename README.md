
# Simple Socket

Simple Socket is a gem to allow you to more easily make use of TCP sockets. 

### Installation

    gem install simple_socket

### Usage

    => SimpleSocket.new('localhost', 12345).write("my_query") 
    => "response_value_from_socket"


SimpleSocket also supports specifying a timeout parameter when creating a new socket:

    => SimpleSocket.new('localhost', 12345, 12)

This will set the timeout to 12 seconds. The default timeout is 10 seconds.
