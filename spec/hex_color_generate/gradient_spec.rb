# frozen_string_literal: true

require "spec_helper" # This will load the support file

RSpec.describe HexColorGenerate do
  # Shared examples definition removed from here

  describe ".gradient" do
    # let(:hex_color_regex) { /^#[0-9a-fA-F]{6}$/ } # This was moved to shared_examples

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
                       HexColorGenerate.purple
    end

    describe "error handling" do
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
end
