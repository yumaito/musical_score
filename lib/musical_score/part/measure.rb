require 'contracts'
require 'musical_score/attribute/attribute'
require 'musical_score/notes'

module MusicalScore
    module Part
        class Measure
            include Contracts
            attr_reader :attribute, :notes
            Contract MusicalScore::Notes, Maybe[MusicalScore::Attribute::Attribute]=> Any
            def initialize(notes, attribute = nil)
                @notes     = notes
                @attribute = attribute
            end
        end
    end
end
