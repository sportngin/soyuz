require "spec_helper"
require "soyuz/command_choice"
module Soyuz
  describe CommandChoice do
    let(:choices){ [{display: "choice1", cmd: "echo choice1"}, {display: "choice2", cmd: "echo choice2" }] }
    let(:command_double){ instance_double("Command", :run => true) }
    subject { CommandChoice.new(choices) }

    context "choices isn't an array" do
      let(:choices) { "I'm a command" }
      subject { CommandChoice }
      it "raises an error" do
        expect{ subject.new(choices) }.to raise_error(ArgumentError)
      end
    end

    context "#run" do
      it "creates a command for the given choice" do
        expect(subject).to receive(:say).with("1) choice1").once
        expect(subject).to receive(:say).with("2) choice2").once
        expect(subject).to receive(:ask).with(instance_of(String), Integer).and_return(1).once
        expect(Command).to receive(:new).with("echo choice1").and_return(command_double)
        subject.run
      end
    end

  end
end
