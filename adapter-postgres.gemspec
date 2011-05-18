# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adapter/postgres/version"

Gem::Specification.new do |s|
  s.name        = "adapter-postgres"
  s.version     = Adapter::Postgres::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Casey Rosenthal"]
  s.email       = ["clr@port49.com"]
  s.homepage    = ""
  s.summary     = %q{Adapter for postgres}
  s.description = %q{Adapter for postgres}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'adapter', '~> 0.5.1'
  s.add_dependency 'pg', '~> 0.10.1'
end
