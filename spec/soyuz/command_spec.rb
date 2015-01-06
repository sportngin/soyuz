require "spec_helper"
require "soyuz/command"
module Soyuz
  describe Command do
    let(:cmd){ "echo derp" }
    subject { Command.new(cmd) }

    before do
      allow(subject).to receive(:puts)
    end

    context "cmd isn't a string" do
      let(:cmd) { 1234 }
      subject { Command }
      it "raises an error" do
        expect{ subject.new(cmd) }.to raise_error(ArgumentError)
      end
    end

    context "#run" do
      before(:each) { allow(subject).to receive(:say) }

      it "to make a system call" do
        expect(subject).to receive(:system).and_return(true)
        subject.run
      end

      it "exits if the command returns a non-zero exist status" do
        expect(subject).to receive(:system)
        expect(subject).to receive(:exit)
        subject.run
      end
    end

    context ".build" do
      context "cmd is an array" do
        let(:cmd) { [{display: "DERP", cmd: "echo derp"}, {display: "HERP", cmd: "echo herp"}] }
        subject { Command }
        it "to create a new command choice if the command argument is an array" do
          expect(CommandChoice).to receive(:new).with(cmd)
          subject.build(cmd)
        end
      end

      context "cmd is a string" do
        let(:cmd) { "echo derp" }
        subject { Command }
        it "to create a new command object if the command argument is a string" do
          expect(Command).to receive(:new).with(cmd)
          subject.build(cmd)
        end
      end

      context "cmd is a env command" do
        let(:cmd) { {:env_var => "FOO", :env_val => "BAR" } }
        subject { Command }

        it "sets the ENV based off of the :env_var and :env_val" do
          expect(CommandEnv).to receive(:new).with(cmd)
          subject.build(cmd)
        end
      end
    end
  end
end
