# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yard_gems/version"

Gem::Specification.new do |s|
  s.name        = "yard_gems"
  s.version     = YardGems::VERSION
  s.authors     = ["Doug Barth"]
  s.email       = ["dougbarth@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Local On Demand YARD Docs for Rubygems}
  s.description = %q{Easily install a YARD backed site for viewing locally installed Rubygem docs. Install this and disable rdoc generation on gem install.}

  s.rubyforge_project = "yard_gems"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "yard"
  s.add_runtime_dependency "rack"
end
