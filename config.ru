$: << File.expand_path(File.dirname(__FILE__), 'lib')
require 'yard_gems'
run YardGems::RackAdapter.new
