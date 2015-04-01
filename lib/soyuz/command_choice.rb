require_relative "command"

module Soyuz
  class CommandChoice

    def initialize(choices)
      raise ArgumentError, "Choices must be an array" unless choices.is_a?(Array)
      @choices = choices
      @default_choice = default_choice_number
      raise ArgumentError, "Default choice required for non interactive mode." if use_default?
    end

    def default_choice_number
      @choices.each_with_index do |choice, index|
        return index+1 if choice[:default]
      end
      nil
    end

    def use_default?
      @default_choice.nil? && $non_interactive
    end

    def run
      if use_default?
        choice = default_choice_number
      else
        @choices.each_with_index do |choice, index|
          say "#{index+1}) #{choice[:display]}"
        end
        choice = ask("? ", Integer) { |q| q.in = 1..@choices.length }
      end
      build_command(choice-1)
    end

    def build_command(choice)
      Command.build(@choices[choice][:cmd]).run
    end
  end
end
