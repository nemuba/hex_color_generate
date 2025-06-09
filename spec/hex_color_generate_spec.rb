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

  HexColorGenerate::COLORS.each do |color, _|
    it { expect(HexColorGenerate).to respond_to(color) }

    it { expect(HexColorGenerate).to respond_to("#{color}_keys") }

    it { expect(HexColorGenerate).to respond_to("#{color}_values") }

    it { expect(HexColorGenerate.send(color)).to match(/^#[0-9a-fA-F]{6}$/) } # Updated regex

    it { expect(HexColorGenerate.send(color, type: color.to_s)).to be_a(String) }
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
        expect { HexColorGenerate.gradient(:red, :blue, steps: 0) }.to raise_error(ArgumentError, "steps must be 1 or greater")
      end

      it "raises an ArgumentError for steps: -1" do
        expect { HexColorGenerate.gradient(:red, :blue, steps: -1) }.to raise_error(ArgumentError, "steps must be 1 or greater")
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
