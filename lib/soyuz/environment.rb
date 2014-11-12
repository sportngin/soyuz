require_relative 'command'

module Soyuz
  class Environment
    def initialize(attributes={}, defaults={})
      set_attributes(attributes, defaults)

      if [:deploy_cmds, :deploy_cmd].all?{ |attr| @attributes.has_key?(attr) }
        raise ArgumentError, "Only one definiton of deploy_cmd or deploy_cmds is allowed"
      end

      build
    end

    def valid?
      # If the environment built then it's valid
      true
    end

    def before_callbacks
      @before_callbacks.each do|cmd|
        cmd.run
      end
    end

    def after_callbacks
      @after_callbacks.each do|cmd|
        cmd.run
      end
    end

    def deploy
      @deploy_cmds.each do |cmd|
        cmd.run
      end
    end

    def name
      @name
    end

  private

    def set_attributes(attributes={}, defaults={})
      @name = attributes.keys.first
      @attributes = defaults.merge(attributes[name])
    end

    def build
      # deploy_cmd is deprecated and will be removed in a future version
      @deploy_cmds = Array(Command.build(@attributes[:deploy_cmd]))
      @deploy_cmds += Array(@attributes[:deploy_cmds]).compact.map{|cmd| Command.build(cmd) }
      @before_callbacks = Array(@attributes[:before_deploy_cmds]).compact.map{|cmd| Command.build(cmd) }
      @after_callbacks = Array(@attributes[:after_deploy_cmds]).compact.map{|cmd| Command.build(cmd) }
    end

  end
end
