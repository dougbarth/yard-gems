$: << File.expand_path(File.dirname(__FILE__), 'lib')
require 'rubygems'
require 'yard_gems'
run YardGems::RackAdapter.new
