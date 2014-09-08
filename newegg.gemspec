# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newegg/version'

Gem::Specification.new do |spec|
  spec.name          = 'newegg'
  spec.version       = Newegg::VERSION
  spec.authors       = ['ryancheung']
  spec.email         = ['ryancheung.go@gmail.com']
  spec.summary       = 'Newegg Marketplace API wrapper'
  spec.description   = ''
  spec.homepage      = 'https://github.com/ryancheung/newegg'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'faraday'
end
