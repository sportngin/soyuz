require "spec_helper"
require "soyuz/deploy"
module Soyuz
  describe Deploy do
    let(:valid_config){ "files/soyuz_example.yml" }
    subject { Deploy.new(valid_config) }

    before do
      allow_any_instance_of(Config).to receive(:validate!)
    end

    context "#execute" do
      it "to ask for an environment" do
        allow(subject).to receive(:before_callbacks)
        allow(subject).to receive(:deploy)
        allow(subject).to receive(:after_callbacks)
        expect(subject).to receive(:choose_environment)
        subject.execute
      end

      it "to call before callbacks" do
        allow(subject).to receive(:choose_environment)
        allow(subject).to receive(:deploy)
        allow(subject).to receive(:after_callbacks)
        expect(subject).to receive(:before_callbacks)
        subject.execute
      end

      it "to call deploy" do
        allow(subject).to receive(:choose_environment)
        allow(subject).to receive(:before_callbacks)
        allow(subject).to receive(:after_callbacks)
        expect(subject).to receive(:deploy)
        subject.execute
      end

      it "to call after callbacks" do
        allow(subject).to receive(:choose_environment)
        allow(subject).to receive(:before_callbacks)
        allow(subject).to receive(:deploy)
        expect(subject).to receive(:after_callbacks)
        subject.execute
      end
    end
  end
end
