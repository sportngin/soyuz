require "spec_helper"
require "soyuz/config"
module Soyuz
  describe Config do
    before do
      $non_interactive = false
    end

    context "#check" do
      context "valid modern" do
        subject { Config.new(CONFIG_PATHS[:valid_modern]) }
        it "to not raise an error if the config is valid" do
          expect(STDOUT).to receive(:puts).with("Config file is valid. We are go for launch.")
          expect{ subject.check }.to_not raise_error
        end
        it "to raise an InvalidConfig error in non interactive mode" do
          $non_interactive = true
          expect(STDOUT).to receive(:puts).with("Default choice required for non interactive mode.")
          expect{ subject.check }.to raise_error(InvalidConfig)
        end
      end

      context "valid legacy" do
        subject { Config.new(CONFIG_PATHS[:valid_legacy]) }

        it "to not raise an error if the config is valid" do
          expect(STDOUT).to receive(:puts).with("Config file is valid. We are go for launch.")
          expect{ subject.check }.to_not raise_error
        end
      end

      context "non interactive" do
        subject { Config.new(CONFIG_PATHS[:non_interactive]) }
        before do
          $non_interactive = true
        end

        it "to not raise an error if the config is valid" do
          expect(STDOUT).to receive(:puts).with("Config file is valid. We are go for launch.")
          expect{ subject.check }.to_not raise_error
        end
      end

      context "incompatible" do
        subject { Config.new(CONFIG_PATHS[:incompatible]) }
        it "to raise an InvalidConfig error if the config is invalid" do
          expect(STDOUT).to receive(:puts).with("Only one definiton of deploy_cmd or deploy_cmds is allowed")
          expect{ subject.check }.to raise_error(InvalidConfig)
        end
      end

      context "invalid" do
        subject { Config.new(CONFIG_PATHS[:invalid]) }
        it "to raise an InvalidConfig error if the config is invalid" do
          expect(STDOUT).to receive(:puts).with(kind_of(String))
          expect{ subject.check }.to raise_error(InvalidConfig)
        end
      end
    end
  end
end
