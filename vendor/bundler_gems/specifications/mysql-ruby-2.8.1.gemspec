# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mysql-ruby}
  s.version = "2.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Masahiro TOMITA"]
  s.date = %q{2008-09-29}
  s.description = %q{This is the MySQL API module for Ruby. It provides the same functions for Ruby
programs that the MySQL C API provides for C programs.
}
  s.email = %q{tommy.(at).tmtm.org}
  s.extensions = ["ext/extconf.rb"]
  s.files = ["COPYING", "COPYING.ja", "README.html", "README_ja.html", "ext/extconf.rb", "ext/mysql.c", "setup.rb", "test.rb", "tommy.css", "mysql-ruby.gemspec"]
  s.homepage = %q{http://www.tmtm.org/mysql/ruby/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{mysql-ruby}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{MySQL driver for Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
