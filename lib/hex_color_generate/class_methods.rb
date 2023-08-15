# frozen_string_literal: true

require_relative "colors"

# HexColorGenerate module
module HexColorGenerate
  # ClassMethods module
  module ClassMethods
    include ::HexColorGenerate::Colors

    # generate random color
    # @param color [Symbol] type of color
    # @return [String] hex color
    def generate(color: nil)
      random = color || COLORS.keys.sample
      color = COLORS[random].keys.sample
      send(random, type: color)
    end

    # get all colors
    # @return [Array] array of colors
    def colors
      COLORS.keys
    end

    COLORS.each do |color, types|
      # define method with param type with default value color
      # @param type [Symbol] type of color
      # @return [String] hex color
      define_method color do |type: color|
        colors = types.freeze
        color = colors[type.to_s]
        raise ArgumentError, "Invalid color type: #{type}" unless color

        format_color(color)
      end

      # define method to get all colors of type
      # @return [Array] array of colors
      define_method "#{color}_keys" do
        types.keys.map(&:to_sym)
      end

      # define method to get all colors of type
      # @return [Hash] hash of colors
      define_method "#{color}_values" do
        # transforma values and symbolize keys
        types.transform_keys(&:to_sym).transform_values(&method(:format_color))
      end
    end

    private

    # format color to hex
    # @param color [String] color
    # @return [String] hex color
    def format_color(color)
      "##{color}"
    end
  end
end
