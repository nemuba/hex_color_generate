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

    it { expect(HexColorGenerate.send(color)).to match(/^#[0-9a-f]{6}$/) }

    it { expect(HexColorGenerate.send(color, type: color.to_s)).to be_a(String) }
  end
end
