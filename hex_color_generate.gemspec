# frozen_string_literal: true

require_relative "lib/hex_color_generate/version"

Gem::Specification.new do |spec|
  spec.name = "hex_color_generate"
  spec.version = HexColorGenerate::VERSION
  spec.authors = ["Alef Ojeda de Oliveira"]
  spec.email = ["alef.oliveira@dimensa.com.br"]

  spec.summary = "Generate hexadecimal color"
  spec.description = "This gem generate hexadecimal color"
  spec.homepage = "https://github.com/nemuba/hex_color_generate"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.metadata["homepage_uri"] = "https://github.com/nemuba/hex_color_generate"
  spec.metadata["source_code_uri"] = "https://github.com/nemuba/hex_color_generate/tree/main"
  spec.metadata["changelog_uri"] = "https://github.com/nemuba/hex_color_generate/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
