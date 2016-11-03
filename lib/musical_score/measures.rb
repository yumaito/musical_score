require 'contracts'
require 'musical_score/part/measure'
module MusicalScore
    class Measures
        include Contracts
        attr_reader :measures

        Contract ArrayOf[MusicalScore::Part::Measure] => Any
        def initialize(measures)
            @measures = measures
        end
    end
end
