# frozen_string_literal: true

RSpec.describe "HexColorGenerate" do
  it "has a version number" do
    expect(HexColorGenerate::VERSION).not_to be nil
  end

  it "has a constant COLORS" do
    expect(HexColorGenerate::COLORS).not_to be nil
  end

  it { expect(HexColorGenerate).to respond_to(:generate) }

  it { expect(HexColorGenerate).to respond_to(:colors) }

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

  describe ".gradient" do
    let(:hex_color_regex) { /^#[0-9a-fA-F]{6}$/ }

    context "with valid colors and default steps" do
      let(:gradient) { HexColorGenerate.gradient(:red, :blue) }

      it "returns an array" do
        expect(gradient).to be_an(Array)
      end

      it "returns 10 elements" do
        expect(gradient.size).to eq(10)
      end

      it "starts with the first color" do
        expect(gradient.first).to eq(HexColorGenerate.red)
      end

      it "ends with the second color" do
        expect(gradient.last).to eq(HexColorGenerate.blue)
      end

      it "contains valid hex color strings" do
        gradient.each { |color| expect(color).to match(hex_color_regex) }
      end
    end

    context "with valid colors and specified steps" do
      let(:gradient) { HexColorGenerate.gradient(:green, :yellow, steps: 5) }

      it "returns an array" do
        expect(gradient).to be_an(Array)
      end

      it "returns the specified number of elements" do
        expect(gradient.size).to eq(5)
      end

      it "starts with the first color" do
        expect(gradient.first).to eq(HexColorGenerate.green)
      end

      it "ends with the second color" do
        expect(gradient.last).to eq(HexColorGenerate.yellow)
      end

      it "contains valid hex color strings" do
        gradient.each { |color| expect(color).to match(hex_color_regex) }
      end
    end

    context "with steps: 1" do
      let(:gradient) { HexColorGenerate.gradient(:purple, :orange, steps: 1) }

      it "returns an array" do
        expect(gradient).to be_an(Array)
      end

      it "returns 1 element" do
        expect(gradient.size).to eq(1)
      end

      it "contains only the first color" do
        expect(gradient.first).to eq(HexColorGenerate.purple)
      end

      it "contains a valid hex color string" do
        expect(gradient.first).to match(hex_color_regex)
      end
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
