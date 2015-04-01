require "spec_helper"
require "soyuz/deploy"
module Soyuz
  describe Deploy do
    subject { Deploy.new(nil, config: CONFIG_PATHS[:valid_modern]) }

    before do
      $non_interactive = false
      allow(ENV).to receive("[]=").with("SOYUZ_ENVIRONMENT", kind_of(String))
    end

    context "#execute" do
      context "interactive" do
        before do
          allow_any_instance_of(Config).to receive(:validate!)
          allow_any_instance_of(HighLine).to receive(:say)
          allow_any_instance_of(HighLine).to receive(:ask) { 1 }
        end

        it "to ask for an environment" do
          expect(subject).to receive(:choose_environment).and_call_original
          allow(subject).to receive(:before_callbacks)
          allow(subject).to receive(:deploy)
          allow(subject).to receive(:after_callbacks)
          subject.execute
        end

        it "to call deploy and callbacks" do
          allow(subject).to receive(:choose_environment).and_call_original
          expect(subject).to receive(:before_callbacks)
          expect(subject).to receive(:deploy)
          expect(subject).to receive(:after_callbacks)
          subject.execute
        end

      end
      context "non interactive" do
        subject { Deploy.new("staging", config: CONFIG_PATHS[:non_interactive]) }
        it "to not ask anything" do
          expect(subject).to_not receive(:choose_environment)
          expect(subject).to receive(:before_callbacks)
          expect(subject).to receive(:deploy)
          expect(subject).to receive(:after_callbacks)
          subject.execute
        end
      end
    end
  end
end
