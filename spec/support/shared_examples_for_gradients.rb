# frozen_string_literal: true

RSpec.shared_examples "a valid gradient" do |gradient_block,
                                             expected_size,
                                             expected_first_color_hex,
                                             expected_last_color_hex|
  let(:gradient) { instance_exec(&gradient_block) }
  let(:hex_color_regex) { /^#[0-9a-fA-F]{6}$/ }

  it "returns an array of the correct size with correct start/end colors" do
    expect(gradient).to be_an(Array)
    expect(gradient.size).to eq(expected_size)
    expect(gradient.first).to eq(expected_first_color_hex)
    expect(gradient.last).to eq(expected_last_color_hex) if expected_size > 1
  end

  it "contains only valid hex color strings" do
    gradient.each { |color| expect(color).to match(hex_color_regex) }
  end
end
