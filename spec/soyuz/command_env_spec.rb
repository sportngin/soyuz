require "spec_helper"
require "soyuz/command_env"

module Soyuz
  describe CommandEnv do
    let(:cmd){ { :env_var => "FOO", :env_val => "BAR" } }
    subject { CommandEnv.new(cmd) }

    before do
      allow(subject).to receive(:puts)
    end

    it "sets the command" do
      expect(subject.instance_variable_get(:@cmd)).to eq(cmd)
    end

    context "cmd isn't a hash" do
      let(:cmd) { 1234 }
      subject { CommandEnv }
      it "raises an error" do
        expect{ subject.new(cmd) }.to raise_error(ArgumentError, "Environment Commands must be a Hash")
      end
    end

    context "cmd doesn't contain :env_var and :env_val" do
      let(:cmd) { {} }
      subject { CommandEnv }
      it "raises an error" do
        expect{ subject.new(cmd) }.to raise_error(ArgumentError, "Environment Commands must contain :env_var and :env_val keys")
      end
    end

    describe "#run" do
      before { @old_env = ENV.dup }

      it "sets the environment_variable" do
        subject.run
        expect(ENV["FOO"]).to eq("BAR")
      end

      after { ENV = @old_env }
    end
  end
end
