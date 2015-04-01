require "spec_helper"
require "soyuz/deploy"
module Soyuz
  describe Deploy do
    subject { Deploy.new(nil, config: CONFIG_PATHS[:valid_modern]) }

    before do
      allow_any_instance_of(Config).to receive(:validate!)
      allow_any_instance_of(HighLine).to receive(:say)
      allow_any_instance_of(HighLine).to receive(:ask) { 1 }
      allow(ENV).to receive("[]=").with("SOYUZ_ENVIRONMENT", kind_of(String))
    end

    context "#execute" do
      it "to ask for an environment" do
        allow(subject).to receive(:before_callbacks)
        allow(subject).to receive(:deploy)
        allow(subject).to receive(:after_callbacks)
        subject.execute
      end

      it "to call before callbacks" do
        allow(subject).to receive(:deploy)
        allow(subject).to receive(:after_callbacks)
        expect(subject).to receive(:before_callbacks)
        subject.execute
      end

      it "to call deploy" do
        allow(subject).to receive(:before_callbacks)
        allow(subject).to receive(:after_callbacks)
        expect(subject).to receive(:deploy)
        subject.execute
      end

      it "to call after callbacks" do
        allow(subject).to receive(:before_callbacks)
        allow(subject).to receive(:deploy)
        expect(subject).to receive(:after_callbacks)
        subject.execute
      end
    end
  end
end
