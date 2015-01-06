require_relative "command"

module Soyuz
  class CommandChoice

    def initialize(choices)
      raise ArgumentError, "Choices must be an array" unless choices.is_a?(Array)
      @choices = choices
    end

    def run
      @choices.each_with_index do |choice, index|
        say "#{index+1}) #{choice[:display]}"
      end
      choice = ask("? ", Integer) { |q| q.in = 1..@choices.length }
      build_command(choice-1)
    end

    def build_command(choice)
      Command.build(@choices[choice][:cmd]).run
    end
  end
end
