# vim: syntax=ruby
load 'tasks/this.rb'

This.name     = "billys_billing"
This.author   = "Jeremy Hinegardner"
This.email    = "jeremy@copiousfreetime.org"
This.homepage = "http://github.com/copiousfreetime/#{ This.name }"

This.ruby_gemspec do |spec|
  spec.add_dependency( 'faraday', '~> 0.9' )
  spec.add_dependency( 'faraday_middleware', '~> 0.9' )
  spec.add_dependency( 'sawyer', '~> 0.5')
  spec.add_development_dependency( 'rake'     , '~> 10.1')
  spec.add_development_dependency( 'minitest' , '~> 5.0' )
  spec.add_development_dependency( 'rdoc'     , '~> 4.0' )
  spec.add_development_dependency( 'pry'      , '~> 0.10' )
end

load 'tasks/default.rake'
