require "spec_helper"
require "soyuz/command"
module Soyuz
  describe Command do
    let(:cmd){ "echo derp" }
    subject { Command.new(cmd) }

    context "cmd isn't a string" do
      let(:cmd) { 1234 }
      subject { Command }
      it "raises an error" do
        expect{ subject.new(cmd) }.to raise_error(ArgumentError)
      end
    end

    context "#run" do
      it "to make a system call" do
        expect(subject).to receive(:system)
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
    end
  end
end
