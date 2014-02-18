require 'safe_yaml'
module Soyuz
  class Config
    def initialize(config_file)
      @config_file = config_file
    end

    def check
      if valid?
        puts "Config file is valid. We are go for launch."
      else
        raise InvalidConfig, "Your config file is invalid"
      end
    end

  private
    def config_data
      return @config_data if @config_data
      load_config
    end

    def load_config
      @config_data = SafeYAML.load_file(@config_file)
    end

    def valid?
      begin
        File.exists?(@config_file) && config_data.is_a?(Hash)
      rescue StandardError
        false
      end
    end
  end
  InvalidConfig = Class.new(StandardError)
end
