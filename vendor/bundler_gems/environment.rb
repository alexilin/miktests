# DO NOT MODIFY THIS FILE
module Bundler
 file = File.expand_path(__FILE__)
 dir = File.dirname(file)

  ENV["GEM_HOME"] = dir
  ENV["GEM_PATH"] = dir
  ENV["PATH"]     = "#{dir}/../../bin:#{ENV["PATH"]}"
  ENV["RUBYOPT"]  = "-r#{file} #{ENV["RUBYOPT"]}"

  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/eventmachine-0.12.10/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/eventmachine-0.12.10/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/actionmailer-2.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/actionmailer-2.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activesupport-2.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activesupport-2.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activeresource-2.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activeresource-2.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activerecord-2.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/activerecord-2.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rake-0.8.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ruby-smpp-0.1.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ruby-smpp-0.1.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/jrails-0.6.0/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/jrails-0.6.0/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/memcache-client-1.7.7/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/memcache-client-1.7.7/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ar-extensions-0.9.2/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/ar-extensions-0.9.2/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mysql-ruby-2.8.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/mysql-ruby-2.8.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.1/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rack-1.0.1/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/actionpack-2.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/actionpack-2.3.5/lib")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rails-2.3.5/bin")
  $LOAD_PATH.unshift File.expand_path("#{dir}/gems/rails-2.3.5/lib")

  @gemfile = "#{dir}/../../Gemfile"

  require "rubygems"

  @bundled_specs = {}
  @bundled_specs["eventmachine"] = eval(File.read("#{dir}/specifications/eventmachine-0.12.10.gemspec"))
  @bundled_specs["eventmachine"].loaded_from = "#{dir}/specifications/eventmachine-0.12.10.gemspec"
  @bundled_specs["actionmailer"] = eval(File.read("#{dir}/specifications/actionmailer-2.3.5.gemspec"))
  @bundled_specs["actionmailer"].loaded_from = "#{dir}/specifications/actionmailer-2.3.5.gemspec"
  @bundled_specs["activesupport"] = eval(File.read("#{dir}/specifications/activesupport-2.3.5.gemspec"))
  @bundled_specs["activesupport"].loaded_from = "#{dir}/specifications/activesupport-2.3.5.gemspec"
  @bundled_specs["activeresource"] = eval(File.read("#{dir}/specifications/activeresource-2.3.5.gemspec"))
  @bundled_specs["activeresource"].loaded_from = "#{dir}/specifications/activeresource-2.3.5.gemspec"
  @bundled_specs["activerecord"] = eval(File.read("#{dir}/specifications/activerecord-2.3.5.gemspec"))
  @bundled_specs["activerecord"].loaded_from = "#{dir}/specifications/activerecord-2.3.5.gemspec"
  @bundled_specs["rake"] = eval(File.read("#{dir}/specifications/rake-0.8.7.gemspec"))
  @bundled_specs["rake"].loaded_from = "#{dir}/specifications/rake-0.8.7.gemspec"
  @bundled_specs["ruby-smpp"] = eval(File.read("#{dir}/specifications/ruby-smpp-0.1.2.gemspec"))
  @bundled_specs["ruby-smpp"].loaded_from = "#{dir}/specifications/ruby-smpp-0.1.2.gemspec"
  @bundled_specs["jrails"] = eval(File.read("#{dir}/specifications/jrails-0.6.0.gemspec"))
  @bundled_specs["jrails"].loaded_from = "#{dir}/specifications/jrails-0.6.0.gemspec"
  @bundled_specs["memcache-client"] = eval(File.read("#{dir}/specifications/memcache-client-1.7.7.gemspec"))
  @bundled_specs["memcache-client"].loaded_from = "#{dir}/specifications/memcache-client-1.7.7.gemspec"
  @bundled_specs["ar-extensions"] = eval(File.read("#{dir}/specifications/ar-extensions-0.9.2.gemspec"))
  @bundled_specs["ar-extensions"].loaded_from = "#{dir}/specifications/ar-extensions-0.9.2.gemspec"
  @bundled_specs["mysql-ruby"] = eval(File.read("#{dir}/specifications/mysql-ruby-2.8.1.gemspec"))
  @bundled_specs["mysql-ruby"].loaded_from = "#{dir}/specifications/mysql-ruby-2.8.1.gemspec"
  @bundled_specs["rack"] = eval(File.read("#{dir}/specifications/rack-1.0.1.gemspec"))
  @bundled_specs["rack"].loaded_from = "#{dir}/specifications/rack-1.0.1.gemspec"
  @bundled_specs["actionpack"] = eval(File.read("#{dir}/specifications/actionpack-2.3.5.gemspec"))
  @bundled_specs["actionpack"].loaded_from = "#{dir}/specifications/actionpack-2.3.5.gemspec"
  @bundled_specs["rails"] = eval(File.read("#{dir}/specifications/rails-2.3.5.gemspec"))
  @bundled_specs["rails"].loaded_from = "#{dir}/specifications/rails-2.3.5.gemspec"

  def self.add_specs_to_loaded_specs
    Gem.loaded_specs.merge! @bundled_specs
  end

  def self.add_specs_to_index
    @bundled_specs.each do |name, spec|
      Gem.source_index.add_spec spec
    end
  end

  add_specs_to_loaded_specs
  add_specs_to_index

  def self.require_env(env = nil)
    context = Class.new do
      def initialize(env) @env = env && env.to_s ; end
      def method_missing(*) ; yield if block_given? ; end
      def only(*env)
        old, @only = @only, _combine_only(env.flatten)
        yield
        @only = old
      end
      def except(*env)
        old, @except = @except, _combine_except(env.flatten)
        yield
        @except = old
      end
      def gem(name, *args)
        opt = args.last.is_a?(Hash) ? args.pop : {}
        only = _combine_only(opt[:only] || opt["only"])
        except = _combine_except(opt[:except] || opt["except"])
        files = opt[:require_as] || opt["require_as"] || name
        files = [files] unless files.respond_to?(:each)

        return unless !only || only.any? {|e| e == @env }
        return if except && except.any? {|e| e == @env }

        if files = opt[:require_as] || opt["require_as"]
          files = Array(files)
          files.each { |f| require f }
        else
          begin
            require name
          rescue LoadError
            # Do nothing
          end
        end
        yield if block_given?
        true
      end
      private
      def _combine_only(only)
        return @only unless only
        only = [only].flatten.compact.uniq.map { |o| o.to_s }
        only &= @only if @only
        only
      end
      def _combine_except(except)
        return @except unless except
        except = [except].flatten.compact.uniq.map { |o| o.to_s }
        except |= @except if @except
        except
      end
    end
    context.new(env && env.to_s).instance_eval(File.read(@gemfile), @gemfile, 1)
  end
end

module Gem
  @loaded_stacks = Hash.new { |h,k| h[k] = [] }

  def source_index.refresh!
    super
    Bundler.add_specs_to_index
  end
end
