require "spec_helper"
require "soyuz/command_choice"
module Soyuz
  describe CommandChoice do
    let(:choices) { [{display: "choice1", cmd: "echo choice1"}, {display: "choice2", cmd: "echo choice2" }] }
    let(:command_double) { instance_double("Command", :run => true) }

    subject { CommandChoice.new(choices) }

    describe "choices isn't an array" do
      let(:choices) { "I'm a command" }
      subject { CommandChoice }
      it "raises an error" do
        expect{ subject.new(choices) }.to raise_error(ArgumentError)
      end
    end

    describe "#run" do

      it "creates a command for the given choice" do
        expect(subject).to receive(:say).with("1) choice1").once
        expect(subject).to receive(:say).with("2) choice2").once
        expect(subject).to receive(:ask).with(instance_of(String), Integer).and_return(1).once
        expect(subject).to receive(:build_command).with(0).once
        subject.run
      end

    end

    describe "#build_command" do
      context "with a single command" do
        it "builds and runs the command" do
          expect(Command).to receive(:build).with("echo choice1").and_return(command_double)
          expect(command_double).to receive(:run)
          subject.build_command(0)
        end
      end

      context "with nested choices" do
        let(:nested_choices) { [{display: "choice1.1", cmd: "echo choice1.1"}, {display: "choice1.2", cmd: "echo choice1.2" }] }
        let(:choices){ [{display: "choice1", cmd: nested_choices }, {display: "choice2", cmd: "echo choice2" }] }

        it "builds and runs the commands" do
          expect(Command).to receive(:build).with(nested_choices).and_return(command_double)
          expect(command_double).to receive(:run)
          subject.build_command(0)
        end
      end
    end
  end
end
