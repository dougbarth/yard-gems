require 'yard'
require 'fileutils'

class YardGems::RackAdapter
  def initialize
    @cached_libraries = load_cached_libraries

    load_libraries

    if @cached_libraries != @libraries
      FileUtils.rm_f 'public.html'
      cache_libraries
    end

    @last_refresh = Time.now
    @yard_server = YARD::Server::RackAdapter.new(@libraries, {:caching => true}, :DocumentRoot => 'public')
  end

  REFRESH_INTERVAL = 60 #seconds

  def call(env)
    if Time.now - @last_refresh > REFRESH_INTERVAL
      $stderr.puts "Checking for new gems"
      Gem.source_index.refresh!

      load_libraries

      if @cached_libraries != @libraries
        $stderr.puts "Reloading gems"

        FileUtils.rm_f 'public.html'
        @yard_server.libraries = @libraries
        cache_libraries
      end
      @last_refresh = Time.now
    end

    @yard_server.call(env)
  end

  private
  def load_cached_libraries
    Marshal.load(IO.read('tmp/gems.index')) if File.exist?('tmp/gems.index')
  end

  def load_libraries
    @libraries = {}
    gems = Gem.source_index.find_name('').each do |spec|
      @libraries[spec.name] ||= []
      @libraries[spec.name] << YARD::Server::LibraryVersion.new(spec.name, spec.version.to_s, nil, :gem)
    end
  end

  def cache_libraries
    File.open('tmp/gems.index', 'w') do |f|
      f << Marshal.dump(@libraries)
    end
    @cached_libraries = @libraries
  end
end
