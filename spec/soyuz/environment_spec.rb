require 'spec_helper'
require 'soyuz/environment'
module Soyuz
  describe Environment do
    let(:attributes){ {environment: {deploy_cmd: "echo derp", before_deploy_cmds: ['echo before', 'echo more before'], after_deploy_cmds: ['echo after', 'echo another after']}} }
    subject{ Environment.new(attributes) }
    let(:cmd){ double("Command") }

    context ".new" do
      subject{ Environment }
      it "sets the environment name" do
        expect(subject.name).to_not be_nil
        subject.new(attributes)
      end
      it "sets the attributes" do
        allow_any_instance_of(subject).to receive(:build)
        expect_any_instance_of(subject).to receive(:set_attributes)
        subject.new(attributes)
      end

      it "builds the environment" do
        allow_any_instance_of(subject).to receive(:set_attributes)
        expect_any_instance_of(subject).to receive(:build)
        subject.new(attributes)
      end
    end

    context "#deploy" do
      it "runs the deploy command" do
        allow(Command).to receive(:new).and_return(cmd)
        expect(cmd).to receive(:run)
        subject.deploy
      end
    end

    context "#before_callbacks" do
      it "runs all of the before callbacks" do
        allow(Command).to receive(:new).and_return(cmd)
        expect(cmd).to receive(:run).twice
        subject.before_callbacks
      end
    end

    context "#after_callbacks" do
      it "runs all of the after callbacks" do
        allow(Command).to receive(:new).and_return(cmd)
        expect(cmd).to receive(:run).twice
        subject.after_callbacks
      end
    end
  end
end
