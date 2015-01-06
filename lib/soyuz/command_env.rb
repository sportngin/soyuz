require 'highline/import'

module Soyuz
  class CommandEnv

    NotHashMsg = "Environment Commands must be a Hash"
    BadKeysMsg = "Environment Commands must contain :env_var and :env_val keys"

    def initialize(cmd)
      raise ArgumentError, NotHashMsg unless cmd.is_a?(Hash)
      raise ArgumentError, BadKeysMsg unless cmd.has_key?(:env_var) && cmd.has_key?(:env_val)
      @cmd = cmd
    end

    def run
      ENV[@cmd[:env_var]] = @cmd[:env_val]
    end

  end
end
