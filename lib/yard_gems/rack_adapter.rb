require 'yard'
require 'fileutils'

class YardGems::RackAdapter
  def initialize
    FileUtils.rm_f 'public.html'

    libraries = {}
    gems = Gem.source_index.find_name('').each do |spec|
      libraries[spec.name] ||= []
      libraries[spec.name] << YARD::Server::LibraryVersion.new(spec.name, spec.version.to_s, nil, :gem)
    end

    @yard_server = YARD::Server::RackAdapter.new(libraries, {:caching => true}, :DocumentRoot => 'public')
  end

  def call(env)
    @yard_server.call(env)
  end
end
