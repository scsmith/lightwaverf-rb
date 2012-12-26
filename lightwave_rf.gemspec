# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lightwave_rf'

Gem::Specification.new do |gem|
  gem.name          = "lightwave_rf"
  gem.version       = LightwaveRF::VERSION
  gem.authors       = ["Steve Smith"]
  gem.email         = ["gems@dynedge.co.uk"]
  gem.description   = %q{Control LightwaveRF devices with the Wifi Link box}
  gem.summary       = %q{Control LightwaveRF devices with the Wifi Link box}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
