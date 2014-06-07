require_relative "command"
require_relative "support"

module Soyuz
  class CommandChoice
    include Soyuz::Support

    def initialize(choices)
      raise ArgumentError, "Choices must be an array" unless choices.is_a?(Array)
      @choices = choices.map { |choice| symbolize_keys(choice) }
    end

    def run
      @choices.each_with_index do |choice, index|
        say "#{index+1}) #{choice[:display]}"
      end
      choice = ask("? ", Integer) { |q| q.in = 1..@choices.length }
      Command.new(@choices[choice-1][:cmd]).run
    end
  end
end
