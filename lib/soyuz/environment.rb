require_relative 'command'
module Soyuz
  class Environment
    def initialize(attributes={}, defaults={})
      set_attributes(attributes, defaults)
      build
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
      end unless @deploy_cmds.empty?
      @deploy_cmd.run if @deploy_cmd
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
      @deploy_cmd = Command.build(@attributes[:deploy_cmd])
      @deploy_cmds = Array(@attributes[:deploy_cmds]).compact.map{|cmd| Command.build(cmd) }
      @before_callbacks = Array(@attributes[:before_deploy_cmds]).compact.map{|cmd| Command.build(cmd) }
      @after_callbacks = Array(@attributes[:after_deploy_cmds]).compact.map{|cmd| Command.build(cmd) }
    end

  end
end
