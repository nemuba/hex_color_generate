# frozen_string_literal: true

require "yaml"

module HexColorGenerate
  module Colors
    # load colors from yaml file and symbolize keys
    COLORS = YAML.load_file(File.join(__dir__, "colors.yml")).transform_keys(&:to_sym).freeze
  end
end
