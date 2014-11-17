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
      Command.build(@choices[choice-1][:cmd]).run
    end
  end
end
