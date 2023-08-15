# frozen_string_literal: true

RSpec.describe "HexColorGenerate" do
  it "has a version number" do
    expect(HexColorGenerate::VERSION).not_to be nil
  end

  it "has a constant COLORS" do
    expect(HexColorGenerate::COLORS).not_to be nil
  end

  it "has a method generate" do
    expect(HexColorGenerate).to respond_to(:generate)
  end

  it "has a method colors" do
    expect(HexColorGenerate).to respond_to(:colors)
  end

  HexColorGenerate::COLORS.each do |color, _|
    it "has a method #{color}" do
      expect(HexColorGenerate).to respond_to(color)
    end

    it "has a method #{color}_keys" do
      expect(HexColorGenerate).to respond_to("#{color}_keys")
    end

    it "has a method #{color}_values" do
      expect(HexColorGenerate).to respond_to("#{color}_values")
    end

    it "return a color in hex format" do
      expect(HexColorGenerate.send(color)).to match(/^#[0-9a-f]{6}$/)
    end

    it "return a color in hex format in string" do
      expect(HexColorGenerate.send(color, type: color.to_s)).to be_a(String)
    end
  end
end
