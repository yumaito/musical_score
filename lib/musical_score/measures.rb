require 'contracts'
require 'musical_score/measure/measure'
module MusicalScore
    class Measures
        include Contracts
        attr_reader :measures

        Contract ArrayOf[MusicalScore::Measure::Measure] => Any
        def initialize(measures)
            @measures = measures
        end
    end
end
