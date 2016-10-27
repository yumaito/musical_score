require 'contracts'
require 'musical_score/measure/measure'
module MusicalScore
    class Measures
        include Contracts
        attr_reader :measures

        Contract ArrayOf[MusicalScore::Measure::Measure] => Any
        def initialize(measures)
            @maesures = measures
            
        end
    end
end
