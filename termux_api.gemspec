lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "termux/api/version"

Gem::Specification.new do |spec|
  spec.name          = 'termux_api'
  spec.version       = Termux::API::VERSION
  spec.date          = '2018-06-30'
  spec.summary       = 'Access Termux:API commands'
  spec.description   = 'Access the Termux:API commands natively in ruby for easy scripting of your android device.'
  spec.authors       = ["Sean Ross Earle"]
  spec.email         = ["sean.earle@oeQuacki.com"]
  spec.homepage      = "https://github.com/HellRok/TermuxAPI"
  spec.license       = "Beerware"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
end
