require_relative 'lib/bootstrap5_helper/version'

Gem::Specification.new do |spec|
  spec.name        = 'bootstrap5_helper'
  spec.version     = Bootstrap5Helper::VERSION
  spec.authors     = ['Robert David']
  spec.email       = ['robert.david@state.mn.us']
  spec.homepage    = 'https://github.com/rdavid369/bootstrap5-helper'
  spec.summary     = 'Rails helpers for generating Bootstrap 5 components.'
  spec.description = 'Rails helpers for generating Bootstrap 5 components.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/rdavid369/bootstrap5-helper/blob/main/CHANGELOG.md'
  spec.metadata['changelog_uri']     = 'https://github.com/rdavid369/bootstrap5-helper'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_development_dependency 'bootstrap', '~> 5.2.2'
  spec.add_development_dependency 'jquery-rails'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'solargraph'

  spec.add_dependency 'rails', '> 4.2', '< 8.0.0'
end
