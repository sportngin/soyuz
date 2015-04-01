require_relative 'config'
module Soyuz
  class Deploy
    def initialize(env_name, options)
      @config = Config.new(options[:config])
      @config.validate!
      set_environment(env_name) if env_name || $non_interactive
    end

    def execute
      choose_environment unless @environment
      ENV['SOYUZ_ENVIRONMENT'] = @environment.name.to_s
      before_callbacks
      deploy
      after_callbacks
    end

  private
    def environment
      @environment || raise(EnvironmentNotSelected, "Please Select an Environment")
    end
    def environments
      @config.environments
    end

    def set_environment(env_name)
      @environment = environments.detect { |env| env.name.to_s == env_name }
      raise("Invalid environment '#{env_name}'.") unless @environment
    end

    def choose_environment
      say "Choose an Environment: \n"
      environments.each_with_index do |environment, index|
        say "#{index+1}) #{environment.name}"
      end
      choice = ask("? ", Integer) { |q| q.in = 1..environments.length }
      @environment = environments[choice-1]
    end

    def deploy
      environment.deploy
    end

    def before_callbacks
      environment.before_callbacks
    end

    def after_callbacks
      environment.after_callbacks
    end

  end
  EnvironmentNotSelected = Class.new(StandardError)
end
