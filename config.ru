require 'rubygems'
require 'yard'
require 'fileutils'

FileUtils.rm_f 'public.html'

libraries = {}
gems = Gem.source_index.find_name('').each do |spec|
  libraries[spec.name] ||= []
  libraries[spec.name] << YARD::Server::LibraryVersion.new(spec.name, spec.version.to_s, nil, :gem)
end

YARD::Logger.instance.level = Logger::DEBUG
run YARD::Server::RackAdapter.new(libraries, {:caching => true}, :DocumentRoot => 'public')
