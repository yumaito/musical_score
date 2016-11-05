# MusicalScore

[![Build Status](https://travis-ci.org/yumaito/musical_score.svg?branch=master)](https://travis-ci.org/yumaito/musical_score)
[![Code Climate](https://codeclimate.com/github/yumaito/musical_score/badges/gpa.svg)](https://codeclimate.com/github/yumaito/musical_score)

Library for representing and analysing musical score.
This library is implemented along with the definitions of [MusicXML](http://www.musicxml.com/) mainly.
The goal of this project is handling any kind of musical score as ruby class object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'musical_score'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install musical_score

## Usage

Here is a simple usage to import musicXML file:

```ruby
require 'musical_score'

musical_score = MusicalScore::IO.import("path/to/musicxml.xml")
```

Now you can handle the musical score as a ruby class object.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yumaito/musical_score. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
