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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hex_color_generate.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
