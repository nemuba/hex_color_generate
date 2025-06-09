# HexColorGenerate

This gem is used to generate random hex color codes. It can be used to generate a single color or a list of colors. It can also be used to generate a list of colors with a specific color as the base color. The gem also provides a method to generate a list of colors with a specific color as the base color and a specific number of colors to be generated.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hex_color_generate`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add hex_color_generate

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install hex_color_generate

## Usage

### Generate a single color

```ruby
# Generate a random hex color code
HexColorGenerate.generate

# Generate a random hex color code with a specific color as the base color
HexColorGenerate.generate(color: :red)

# Get all the colors available
HexColorGenerate.colors # => ["white", "red", "blue", "green", ...]

# Generate a color specific
HexColorGenerate.red

# Generate a color specific with a specific color as the base color
HexColorGenerate.red(type: "salmon")

# Get types of colors available for a specific color (red)
HexColorGenerate.red_keys # => ["salmon", "dark_salmon", "light_salmon", "crimson", "red", ...]

# Get values of colors available for a specific color (red)
HexColorGenerate.red_values # => [{:salmon=>"#FA8072"}, {:dark_salmon=>"#E9967A"}, ...]
```

### Generate a color gradient

The `gradient` method generates a list of hex color codes that form a smooth transition between two specified colors.

**Parameters:**

*   `color1` (Symbol): The starting color name (e.g., `:red`).
*   `color2` (Symbol): The ending color name (e.g., `:blue`).
*   `steps` (Integer, optional): The total number of colors in the gradient, including the start and end colors. Defaults to 10.

**Examples:**

```ruby
# Generate a gradient between red and blue with default 10 steps
HexColorGenerate.gradient(:red, :blue)
# => ["#FF0000", "#E2001C", "#C60038", "#AA0055", "#8D0071", "#71008D", "#5500AA", "#3800C6", "#1C00E2", "#0000FF"]
# (Note: The exact intermediate hex values may vary based on the interpolation logic)

# Generate a gradient between green and yellow with 5 steps
HexColorGenerate.gradient(:green, :yellow, steps: 5)
# => ["#008000", "#3FAF00", "#7FBF00", "#BFDF00", "#FFFF00"]
# (Note: The exact intermediate hex values may vary)

# Generate a gradient with 1 step (returns the start color)
HexColorGenerate.gradient(:purple, :orange, steps: 1)
# => ["#800080"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nemuba/hex_color_generate.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
