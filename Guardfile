require 'active_support/inflector'

group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec' do
    require 'guard/rspec/dsl'
    dsl = Guard::RSpec::Dsl.new(self)

    # Feel free to open issues for suggestions and improvements

    # RSpec files
    rspec = dsl.rspec
    watch(rspec.spec_helper) { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }
    watch(rspec.spec_files)

    # Ruby files
    ruby = dsl.ruby
    dsl.watch_spec_files_for(ruby.lib_files)

    # Rails files
    rails = dsl.rails(view_extensions: %w(erb haml slim))
    dsl.watch_spec_files_for(rails.app_files)
    dsl.watch_spec_files_for(rails.views)

    watch(rails.controllers) do |m|
      [
        rspec.spec.call("routing/#{m[1]}_routing"),
        rspec.spec.call("controllers/#{m[1]}_controller"),
        rspec.spec.call("acceptance/#{m[1]}")
      ]
    end

    # Rails config changes
    watch(rails.spec_helper)     { rspec.spec_dir }
    watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
    watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

    # Capybara features specs
    watch(rails.view_dirs)     { |m| rspec.spec.call("features/#{m[1]}") }
    watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

    # Turnip features and steps
    watch(%r{^spec/acceptance/(.+)\.feature$})
    watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
      Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance'
    end
  end

  # guard :rubocop do
  guard :rubocop, all_on_start: false, cli: ['--format', 'clang', '--rails'] do
    watch(/.+\.rb$/)
    watch(/.+\.rake$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  notification :tmux,
               display_message: true,
               timeout: 5, # in seconds
               default_message_format: '%s >> %s',
               # the first %s will show the title, the second the message
               # Alternately you can also configure *success_message_format*,
               # *pending_message_format*, *failed_message_format*
               line_separator: ' > ', # since we are single line we need a separator
               color_location: 'status-left-bg', # to customize which tmux element will change color

               # Other options:
               default_message_color: 'black',
               success: 'colour150',
               failure: 'colour174',
               pending: 'colour179',

               # Notify on all tmux clients
               display_on_all_clients: false
end
