
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'monopoly-ruby'
  spec.version       = '0.1.0'
  spec.authors       = ['Rob van Aarle']
  spec.email         = ['rob.van.aarle@cg.nl']
  spec.summary       = 'Dummy Monopoly implementation used for assignments'
  spec.description   = 'Dummy Monopoly implementation used for assignments'
  spec.homepage      = 'https://cg.nl'
  spec.bindir        = "bin"
  spec.executables   = ["monopoly"]
  spec.require_paths = ["lib"]
  spec.files         = Dir['lib/**/*', 'Rakefile', 'README.md']

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8.0"
  spec.add_development_dependency "zeitwerk", "~> 2.1.9"
  spec.add_development_dependency "byebug", "~> 11.0.1"
  spec.add_development_dependency 'rubocop', '~> 0.74.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.36.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5.0'
end
