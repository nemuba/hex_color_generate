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

    # Generate a gradient between two colors
    # @param color1 [Symbol] the starting color name
    # @param color2 [Symbol] the ending color name
    # @param steps [Integer] the number of steps in the gradient
    # @return [Array<String>] an array of hex color strings
    def gradient(color1, color2, steps: 10)
      _validate_gradient_steps(steps)
      hex_color1, hex_color2 = _fetch_gradient_start_end_hex(color1, color2)

      rgb1 = hex_to_rgb(hex_color1)
      rgb2 = hex_to_rgb(hex_color2)

      _generate_gradient_colors(rgb1, rgb2, steps)
    end

    COLORS.each do |method_name_sym, color_types_hash|
      # define method with param type with default value method_name_sym
      # @param type [Symbol] type of color
      # @return [String] hex color
      define_method method_name_sym do |type: method_name_sym| # Changed type_param back to type
        available_types = color_types_hash.freeze
        hex_value_for_type = available_types[type.to_s] # Changed type_param back to type
        unless hex_value_for_type
          # Using type in the error message is fine as it's the parameter name
          raise ArgumentError, "Invalid color type: '#{type}' for color method ':#{method_name_sym}'"
        end

        format_color(hex_value_for_type)
      end

      # define method to get all colors of type
      # @return [Array] array of colors
      define_method "#{method_name_sym}_keys" do
        color_types_hash.keys.map(&:to_sym)
      end

      # define method to get all colors of type
      # @return [Hash] hash of colors
      define_method "#{method_name_sym}_values" do
        # transforma values and symbolize keys
        color_types_hash.transform_keys(&:to_sym).transform_values(&method(:format_color))
      end
    end

    private

    # format color to hex
    # @param color [String] color
    # @return [String] hex color
    def format_color(color_string)
      "##{color_string.upcase}" # Ensure uppercase
    end

    # Convert hex color string to RGB array
    # @param hex [String] hex color string (e.g., "#RRGGBB" or "RRGGBB")
    # @return [Array<Integer>] RGB array [r, g, b]
    def hex_to_rgb(hex)
      hex = hex.start_with?("#") ? hex[1..] : hex
      hex.scan(/../).map(&:hex)
    end

    # Convert RGB integers to hex color string
    # @param red_value [Integer] red component (0-255)
    # @param green_value [Integer] green component (0-255)
    # @param blue_value [Integer] blue component (0-255)
    # @return [String] hex color string (e.g., "#RRGGBB")
    def rgb_to_hex(red_value, green_value, blue_value)
      components = [red_value, green_value, blue_value].map do |color_component|
        val = color_component.clamp(0, 255).to_s(16)
        val.length == 1 ? "0#{val}" : val
      end
      "##{components.join.upcase}"
    end

    # Interpolate RGB components
    # @param rgb1 [Array<Integer>] starting RGB color
    # @param rgb2 [Array<Integer>] ending RGB color
    # @param ratio [Float] interpolation ratio
    # @return [Array<Integer>] interpolated RGB array [r, g, b]
    def _interpolate_rgb_components(rgb1, rgb2, ratio)
      r1, g1, b1 = rgb1
      r2, g2, b2 = rgb2

      one_minus_ratio = 1 - ratio

      # RuboCop's recommended parentheses for precedence are maintained
      r = ((r1 * one_minus_ratio) + (r2 * ratio)).round
      g = ((g1 * one_minus_ratio) + (g2 * ratio)).round
      b = ((b1 * one_minus_ratio) + (b2 * ratio)).round
      [r, g, b]
    end

    # Generate the array of hex color strings for the gradient
    # @param rgb1 [Array<Integer>] starting RGB color
    # @param rgb2 [Array<Integer>] ending RGB color
    # @param steps [Integer] the number of steps
    # @return [Array<String>] an array of hex color strings
    def _generate_gradient_colors(rgb1, rgb2, steps)
      gradient_colors = []
      steps.times do |i|
        ratio = steps == 1 ? 0.0 : i.to_f / (steps - 1)
        # NOTE: _interpolate_rgb_components is already a private helper
        r_int, g_int, b_int = _interpolate_rgb_components(rgb1, rgb2, ratio)
        gradient_colors << rgb_to_hex(r_int, g_int, b_int)
      end
      gradient_colors
    end

    # Validate the number of steps for a gradient
    # @param steps [Integer] the number of steps
    # @raise [ArgumentError] if steps is less than 1
    def _validate_gradient_steps(steps)
      raise ArgumentError, "steps must be 1 or greater" if steps < 1
    end

    # Fetch the hex color strings for the start and end points of a gradient
    # @param color1_name [Symbol] the starting color name
    # @param color2_name [Symbol] the ending color name
    # @return [Array<String>] an array containing two hex color strings [hex_color1, hex_color2]
    def _fetch_gradient_start_end_hex(color1_name, color2_name)
      [send(color1_name), send(color2_name)]
    end
  end
end
