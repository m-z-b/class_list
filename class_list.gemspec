# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'class_list/version'

Gem::Specification.new do |spec|
  spec.name          = "class_list"
  spec.version       = ClassList::VERSION
  spec.authors       = ["Mike Bell"]
  spec.email         = ["mike.bell@cenx.com"]

  spec.summary       = "Print a cruide class list for a set of ruby files"
  spec.description   = "Print a cruide class list for a set of ruby ls-files"
  spec.homepage      = "https://github.com/m-z-b/class_list"
  spec.licenses      = ['MIT']


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
