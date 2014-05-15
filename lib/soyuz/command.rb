require_relative 'command_choice'
module Soyuz
  class Command
    def initialize(cmd)
      raise ArgumentError, "Command must be a string" unless cmd.is_a?(String)
      @cmd = cmd
    end

    def self.build(cmd)
     cmd.is_a?(Array) ? CommandChoice.new(cmd) : new(cmd)
    end

    def run
      puts "executing [#{@cmd}]..."
      system(@cmd)
    end
  end
end
