require 'musical_score/version'
require 'musical_score/element_base'
require 'musical_score/const'
require 'musical_score/errors'
require 'musical_score/location'
Dir[File.expand_path('../musical_score', __FILE__) << '/**/*.rb'].each do |file|
    require file
end

module MusicalScore
  # Your code goes here...
end
