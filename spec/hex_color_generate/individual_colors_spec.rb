# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HexColorGenerate do
  describe "individual color methods" do
    HexColorGenerate::COLORS.each do |color, _|
      context "for :#{color}" do # Add context for better grouping per color
        it { expect(HexColorGenerate).to respond_to(color) }
        it { expect(HexColorGenerate).to respond_to("#{color}_keys") }
        it { expect(HexColorGenerate).to respond_to("#{color}_values") }

        describe ".#{color}" do # Describe the method itself
          it "returns a valid hex color string by default" do
            expect(HexColorGenerate.send(color)).to match(/^#[0-9a-fA-F]{6}$/)
          end

          it "accepts a type parameter and returns a string" do
            # Assuming the first key in types is a valid type for that color
            # This makes the test more robust than hardcoding e.g. color.to_s
            example_type = HexColorGenerate::COLORS[color].keys.first
            expect(HexColorGenerate.send(color, type: example_type)).to be_a(String)
            expect(HexColorGenerate.send(color, type: example_type)).to match(/^#[0-9a-fA-F]{6}$/)
          end
        end
      end
    end
  end
end
