# Allowable
[![Gem Version](https://badge.fury.io/rb/allowable.svg)](https://badge.fury.io/rb/allowable)
[![Code Climate](https://codeclimate.com/github/msimonborg/allowable/badges/gpa.svg)](https://codeclimate.com/github/msimonborg/allowable)
[![Build Status](https://travis-ci.org/msimonborg/allowable.svg?branch=master)](https://travis-ci.org/msimonborg/allowable)
[![Coverage Status](https://coveralls.io/repos/github/msimonborg/allowable/badge.svg?branch=master)](https://coveralls.io/github/msimonborg/allowable?branch=master)

Filter hashes by setting  allowed or forbidden values for specific keys.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'allowable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install allowable

## Usage
The gem will add four methods to `Hash`: `#allow`, `#allow!`, `#forbid`, and `#forbid!`

```ruby
hash = { one: 'one', two: 'two' }

hash.forbid(one: 'one') # => { two: 'two' }

hash.allow(one: 'two') # => { two: 'two' }

hash.allow(one: ['one', 'two']) # => { one: 'one', two: 'two' }

hash.forbid(one: ['one', 'two']) # => { two: 'two' }

hash.allow!(one: 'two') # => { two: 'two' }

hash.forbid!(two: 'two') # => {}

hash # => {}
```

#### Type sensitive for `Hash`

```ruby
hash = { 'one' => 'one', 'two' => 'two' }

hash.forbid(one: 'one') # => { "one" => "one", "two" => "two" }

hash.forbid('one' => 'one') # => { "two" => "two" }
```

## With Rails and strong parameters

When added to the `Gemfile` in a Rails project, `ActionController::Parameters` will automatically receive these methods so you can use them with your `strong_parameters`:

```ruby
def user_params
  params.require(:user).permit(:email, :password, :role).forbid(role: ['sys_admin', 'owner'])
end
```

#### Type insensitive for `HashWithIndifferentAccess`
```ruby
params = ActionController::Parameters.new('one' => 'one', 'two' => 'two').permit(:one, :two)

params.forbid(one: 'one').to_h # => { "two" => "two" }

params.forbid('one' => 'one').to_h # => { "two" => "two" }
```

If your custom `Hash`-like class implements `#delete` and the `#[]` finder, you can `include Allowable` to mix in the methods.

```ruby
class MyHash
  include Allowable
end
```

## Platform support

The core module should work with all rubies, however at the moment it is only tested for MRI Ruby >= 2.2.2 and JRuby 9.1.6.0

The Rails plugin is currently being tested only with Rails 5.1.2. Rails >= 4.2.0 should not experience any issues.

Tested against:
* MRI 2.2.2
* MRI 2.3.0
* MRI 2.3.4
* MRI 2.4.1
* JRuby 9.1.6.0
* JRuby HEAD
* MRI HEAD

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/msimonborg/allowable.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
