# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HexColorGenerate do
  # Shared examples for gradient tests
  RSpec.shared_examples "a valid gradient" do |gradient_block, expected_size, expected_first_color_hex, expected_last_color_hex|
    let(:gradient) { instance_exec(&gradient_block) }
    let(:hex_color_regex) { /^#[0-9a-fA-F]{6}$/ } # Moved regex here

    it "returns an array of the correct size with correct start/end colors" do
      expect(gradient).to be_an(Array)
      expect(gradient.size).to eq(expected_size)
      expect(gradient.first).to eq(expected_first_color_hex)
      # Only check last color if not steps: 1 scenario where last_color_hex might be the same as first or nil
      expect(gradient.last).to eq(expected_last_color_hex) if expected_size > 1
    end

    it "contains only valid hex color strings" do
      # For steps: 1, gradient.each still works fine for a single element array
      gradient.each { |color| expect(color).to match(hex_color_regex) }
    end
  end

  describe ".gradient" do
    # let(:hex_color_regex) { /^#[0-9a-fA-F]{6}$/ } # No longer needed here

    context "with valid colors and default steps" do
      include_examples "a valid gradient",
                       -> { HexColorGenerate.gradient(:red, :blue) },
                       10,
                       HexColorGenerate.red,
                       HexColorGenerate.blue
    end

    context "with valid colors and specified steps" do
      include_examples "a valid gradient",
                       -> { HexColorGenerate.gradient(:green, :yellow, steps: 5) },
                       5,
                       HexColorGenerate.green,
                       HexColorGenerate.yellow
    end

    context "with steps: 1" do
      include_examples "a valid gradient",
                       -> { HexColorGenerate.gradient(:purple, :orange, steps: 1) },
                       1,
                       HexColorGenerate.purple,
                       HexColorGenerate.purple # For steps: 1, first and last are the same
    end

    context "with invalid steps value" do
      it "raises an ArgumentError for steps: 0" do
        expect do
          HexColorGenerate.gradient(:red, :blue, steps: 0)
        end.to raise_error(ArgumentError, "steps must be 1 or greater")
      end

      it "raises an ArgumentError for steps: -1" do
        expect do
          HexColorGenerate.gradient(:red, :blue, steps: -1)
        end.to raise_error(ArgumentError, "steps must be 1 or greater")
      end
    end

    context "with an invalid color name" do
      it "raises a NoMethodError for the first color" do
        expect { HexColorGenerate.gradient(:non_existent_color, :blue) }.to raise_error(NoMethodError)
      end

      it "raises a NoMethodError for the second color" do
        expect { HexColorGenerate.gradient(:red, :non_existent_color) }.to raise_error(NoMethodError)
      end
    end
  end
end
