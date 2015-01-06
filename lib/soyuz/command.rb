require 'highline/import'
require_relative 'command_choice'
require_relative 'command_env'

module Soyuz
  class Command
    def initialize(cmd)
      raise ArgumentError, "Command must be a string" unless cmd.is_a?(String)
      @cmd = cmd
    end

    def self.build(cmd)
      return if cmd.nil? || cmd.empty?

      if cmd.is_a?(Array)
        CommandChoice.new(cmd)
      elsif cmd.is_a?(Hash)
        CommandEnv.new(cmd)
      else
        new(cmd)
      end
    end

    def run
      say("<%= color('executing [#{@cmd}]...', :green) %>")
      exit(false) unless system(@cmd)
    end
  end
end
