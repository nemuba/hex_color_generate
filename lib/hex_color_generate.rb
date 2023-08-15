# frozen_string_literal: true

require_relative "hex_color_generate/version"
require_relative "hex_color_generate/colors"
require_relative "hex_color_generate/class_methods"

# Generate random hex color
module HexColorGenerate
  include HexColorGenerate::Colors
  extend HexColorGenerate::ClassMethods
end
