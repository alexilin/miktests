# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ar-extensions}
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Dennis", "Mark Van Holstyn", "Blythe Dunham"]
  s.date = %q{2009-04-20}
  s.description = %q{Extends ActiveRecord functionality by adding better finder/query support, as well as supporting mass data import, foreign key, CSV and temporary tables}
  s.email = %q{zach.dennis@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["init.rb", "db/migrate", "db/migrate/generic_schema.rb", "db/migrate/mysql_schema.rb", "db/migrate/oracle_schema.rb", "db/migrate/version.rb", "Rakefile", "ChangeLog", "README", "config/database.yml", "config/database.yml.template", "config/mysql.schema", "config/postgresql.schema", "lib/ar-extensions/adapters/abstract_adapter.rb", "lib/ar-extensions/adapters/mysql.rb", "lib/ar-extensions/adapters/oracle.rb", "lib/ar-extensions/adapters/postgresql.rb", "lib/ar-extensions/adapters/sqlite.rb", "lib/ar-extensions/create_and_update/mysql.rb", "lib/ar-extensions/create_and_update.rb", "lib/ar-extensions/csv.rb", "lib/ar-extensions/delete/mysql.rb", "lib/ar-extensions/delete.rb", "lib/ar-extensions/extensions.rb", "lib/ar-extensions/finder_options/mysql.rb", "lib/ar-extensions/finder_options.rb", "lib/ar-extensions/finders.rb", "lib/ar-extensions/foreign_keys.rb", "lib/ar-extensions/fulltext/mysql.rb", "lib/ar-extensions/fulltext.rb", "lib/ar-extensions/import/mysql.rb", "lib/ar-extensions/import/postgresql.rb", "lib/ar-extensions/import/sqlite.rb", "lib/ar-extensions/import.rb", "lib/ar-extensions/insert_select/mysql.rb", "lib/ar-extensions/insert_select.rb", "lib/ar-extensions/synchronize.rb", "lib/ar-extensions/temporary_table/mysql.rb", "lib/ar-extensions/temporary_table.rb", "lib/ar-extensions/union/mysql.rb", "lib/ar-extensions/union.rb", "lib/ar-extensions/util/sql_generation.rb", "lib/ar-extensions/util/support_methods.rb", "lib/ar-extensions/version.rb", "lib/ar-extensions.rb"]
  s.homepage = %q{http://www.continuousthinking.com/tags/arext}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{arext}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Extends ActiveRecord functionality.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.1.2"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.1.2"])
  end
end
