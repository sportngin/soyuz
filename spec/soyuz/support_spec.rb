require 'spec_helper'
require 'soyuz/support'

describe Soyuz::Support do

  let(:soyuz_class) { Class.new { include Soyuz::Support }.new }

  describe "#symbolize_keys" do
    context "for a hash" do
      subject { {'foo' => 'bar'} }

      it "converts all the keys to symbols" do
        new_keys = soyuz_class.send(:symbolize_keys, subject).keys
        expect(new_keys).to eq([:foo])
      end
    end

    context "for a hash with a hash for a value" do
      subject { {'foo' => {'bar' => 'baz'}} }

      it "converts all the keys nested in the array" do
        value_keys = soyuz_class.send(:symbolize_keys, subject).values.first.keys
        expect(value_keys).to eq([:bar])
      end
    end

    context "for a hash with an array for a value" do
      subject { {'foo' => [{'bar' => 'baz'}]} }

      it "converts all the keys nested in the array" do
        array_keys = soyuz_class.send(:symbolize_keys, subject).values.first.first.keys
        expect(array_keys).to eq([:bar])
      end
    end

    context "with a non-string/non-symbol key" do
      subject { {1 => 2} }

      it "does not convert the key" do
        new_keys = soyuz_class.send(:symbolize_keys, subject).keys
        expect(new_keys).to eq([1])
      end
    end

    context "when a non-hash is passed in" do
      subject { [1,2] }

      it "does not convert the key" do
        result = soyuz_class.send(:symbolize_keys, subject)
        expect(result).to eq([1, 2])
      end
    end
  end

end
