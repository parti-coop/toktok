guard :minitest, spring: 'bin/rails test' do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end

require 'guard/minitest/inspector'
require 'English'

Guard::Minitest::Runner.module_eval do
  def minitest_command(paths, all)
    cmd_parts = []

    cmd_parts << 'bundle exec' if bundler?


    focuses = paths.select do |path|
      file = File.open(path, "rb")
      contents = file.read

      contents.is_a?(String) && contents.scan(/focus!/).length > 0
    end

    cmd_parts << _commander(focuses.any? ? focuses : paths)
    cmd_parts << ['-n /focus\!/'] if focuses.any?
    [cmd_parts.compact.join(' ')].tap do |args|
      env = generate_env(all)
      args.unshift(env) if env.length > 0
    end
  end
end
