# MusicalScore

[![Build Status](https://travis-ci.org/yumaito/musical_score.svg?branch=master)](https://travis-ci.org/yumaito/musical_score)
[![Code Climate](https://codeclimate.com/github/yumaito/musical_score/badges/gpa.svg)](https://codeclimate.com/github/yumaito/musical_score)
[![Test Coverage](https://codeclimate.com/github/yumaito/musical_score/badges/coverage.svg)](https://codeclimate.com/github/yumaito/musical_score/coverage)
[![Gem Version](https://badge.fury.io/rb/musical_score.svg)](https://badge.fury.io/rb/musical_score)

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

For example, if you want to know the pitch of the first note information:
```ruby
pitch = musical_score.part[0].measures[0].notes[0].pitch
puts pitch
# E3
```

## Contributing

1. Fork it ( https://github.com/yumaito/musical_score  )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
