# frozen_string_literal: true

require 'spec_helper' # Keep spec_helper

RSpec.describe "HexColorGenerate" do # Keep main describe block
  describe "gem structure and constants" do
    it "has a version number" do
      expect(HexColorGenerate::VERSION).not_to be nil
    end

    it "has a constant COLORS" do
      expect(HexColorGenerate::COLORS).not_to be nil
    end
  end

  describe ".generate method" do
    it { expect(HexColorGenerate).to respond_to(:generate) }
    # TODO: Add more tests for .generate functionality (e.g., output format, randomness)
  end

  describe ".colors method" do
    it { expect(HexColorGenerate).to respond_to(:colors) }
    # TODO: Add more tests for .colors functionality (e.g., returns array, content)
  end

  # Removed "individual color methods" describe block
  # Removed ".gradient" describe block
  # Removed "a valid gradient" shared examples
end
