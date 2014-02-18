require "spec_helper"
require "soyuz/config"
module Soyuz
  describe Config do
    let(:valid_config){ "files/soyuz_example.yml" }
    subject { Config.new(valid_config) }

    context "#check" do
      it "to raise an InvalidConfig error if the config is invalid" do
        allow(subject).to receive(:valid?) { false }
        expect{ subject.check }.to raise_error(InvalidConfig)
      end

      it "to not raise an error if the config is valid" do
        allow(subject).to receive(:valid?) { true }
        expect{ subject.check }.to_not raise_error
      end
    end
  end
end
