Gem::Specification.new do |s|
  s.name = "simple_socket"
  s.version = "0.0.0"
  s.authors = ["Cyrus Innovation LLC"]
  s.email = ["pzimbelman@cyrusinnovation.com"]
  s.homepage = "https://github.com/cyrusinnovation/simple_socket"
  s.summary = %q{TCP socket wrapper in a Ruby gem}
  s.description = %q{A gem designed to allow easier use of a TCP socket by providing proper handling of the socket, including timeout/error handling, closing the connection, etc.}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
end
