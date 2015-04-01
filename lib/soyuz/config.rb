require 'safe_yaml'
require_relative 'environment'
require_relative 'support'

module Soyuz
  class Config
    include Soyuz::Support

    def initialize(config_file)
      @config_file = config_file
    end

    def check
      validate!
      puts "Config file is valid. We are go for launch."
    end

    def validate!
      raise InvalidConfig, "Your config file is invalid" unless valid?
    end

    def environments
      @environments ||= config_data[:environments].map{|attributes| Environment.new(attributes, defaults) } if config_data[:environments]
      @environments ||= []
    end

  private

    def defaults
      config_data[:defaults] || {}
    end

    def config_data
      @config_data ||= load_config
    end

    def load_config
      symbolize_keys(SafeYAML.load_file(@config_file))
    end

    def valid?
      File.exists?(@config_file) && config_data.is_a?(Hash)
      environments.all?{|env| env.valid?}
    rescue StandardError => e
      puts e.message
      false
    end
  end
  InvalidConfig = Class.new(StandardError)
end
