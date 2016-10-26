require 'contracts'
require 'musical_score/attribute/attribute'
require 'musical_score/notes'

module MusicalScore
    module Measure
        class Part
            include Contracts
            attr_reader :attribute, :notes
            Contract Optional[MusicalScore::Attribute::Attribute], MusicalScore::Notes => Any
            def initialize(attribute, notes)
                @attribute = attribute
                @notes     = notes
            end
        end
    end
end
