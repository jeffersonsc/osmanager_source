# Ruby I18n

[![Build Status](https://api.travis-ci.org/svenfuchs/i18n.svg?branch=master)](https://travis-ci.org/svenfuchs/i18n)

Ruby Internationalization and localization solution.

Features:

* translation and localization
* interpolation of values to translations (Ruby 1.9 compatible syntax)
* pluralization (CLDR compatible)
* customizable transliteration to ASCII
* flexible defaults
* bulk lookup
* lambdas as translation data
* custom key/scope separator
* custom exception handlers
* extensible architecture with a swappable backend

Pluggable features:

* Cache
* Pluralization: lambda pluralizers stored as translation data
* Locale fallbacks, RFC4647 compliant (optionally: RFC4646 locale validation)
* Gettext support
* Translation metadata

Alternative backends:

* Chain
* ActiveRecord (optionally: ActiveRecord::Missing and ActiveRecord::StoreProcs)
* KeyValue (uses active_support/json and cannot store procs)

For more information and lots of resources see: [http://ruby-i18n.org/wiki](http://ruby-i18n.org/wiki)

## Installation

gem install i18n

#### Rails version warning

On Rails < 2.3.6 the method I18n.localize will fail with MissingInterpolationArgument (issue [20](http://github.com/svenfuchs/i18n/issues/issue/20). Upgrade to Rails 2.3.6 or higher (2.3.8 preferably) is recommended.

### Installation on Rails < 2.3.5 (deprecated)

Up to version 2.3.4 Rails will not accept i18n gems > 0.1.3. There is an unpacked
gem inside of active_support/lib/vendor which gets loaded unless `gem 'i18n', '~> 0.1.3'`.
This requirement is relaxed in [6da03653](http://github.com/rails/rails/commit/6da03653)

The new i18n gem can be loaded from vendor/plugins like this:

```
def reload_i18n!
  raise "Move to i18n version 0.2.0 or greater" if Rails.version > "2.3.4"

  $:.grep(/i18n/).each { |path| $:.delete(path) }
  I18n::Backend.send :remove_const, "Simple"
  $: << Rails.root.join('vendor', 'plugins', 'i18n', 'lib').to_s
end
```

Then you can `reload_i18n!` inside an i18n initializer.

## Tests

You can run tests both with

* `rake test` or just `rake`
* run any test file directly, e.g. `ruby -Ilib -Itest test/api/simple_test.rb`

You can run all tests against all Gemfiles with

* `ruby test/run_all.rb`

The structure of the test suite is a bit unusual as it uses modules to reuse
particular tests in different test cases.

The reason for this is that we need to enforce the I18n API across various
combinations of extensions. E.g. the Simple backend alone needs to support
the same API as any combination of feature and/or optimization modules included
to the Simple backend. We test this by reusing the same API defition (implemented
as test methods) in test cases with different setups.

You can find the test cases that enforce the API in test/api. And you can find
the API definition test methods in test/api/tests.

All other test cases (e.g. as defined in test/backend, test/core_ext) etc.
follow the usual test setup and should be easy to grok.

## Authors

* [Sven Fuchs](http://www.artweb-design.de)
* [Joshua Harvey](http://www.workingwithrails.com/person/759-joshua-harvey)
* [Stephan Soller](http://www.arkanis-development.de)
* [Saimon Moore](http://saimonmoore.net)
* [Matt Aimonetti](http://railsontherun.com)

## Contributors

http://github.com/svenfuchs/i18n/contributors

## License

MIT License. See the included MIT-LICENSE file.
