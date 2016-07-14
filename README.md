# Minikick

Mini Kickstarter, per the specification [here](https://gist.github.com/ktheory/3c28ba04f4064fd9734f).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minikick'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minikick

## Usage

TODO: Write usage instructions here

## Possible Next Steps:

(Including some things that aren't in the specification but would improve usability.)
- Allow multiple credit cards per user.
- Back with a database instead of memory.
- Remove validation repetition for user/project names and amounts.
- Make separate credit card class.
- Potential dependency issue: both projects and users depend on RubyMoney. New class for amounts?
