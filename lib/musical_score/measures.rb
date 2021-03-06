require 'contracts'
require 'musical_score/part/measure'
module MusicalScore
    class Measures < MusicalScore::ElementBase
        include Contracts
        include Enumerable
        attr_reader :measures

        Contract ArrayOf[MusicalScore::Part::Measure] => Any
        def initialize(measures)
            @measures = measures
        end

        def [](index)
            return @measures[index]
        end

        def each
            @measures.each do |measure|
                yield measure
            end
        end

        def last
            return @measures[@measures.size-1]
        end

        def all_notes
            result = Array.new
            @measures.each do |measure|
                result.concat(measure)
            end
            return result
        end

        def set_location
            current_location = Rational(0)
            @measures.each do |measure|
                number = measure.number
                measure.notes.set_location(current_location, number)
                current_location += measure.notes.duration
                measure.length = measure.notes.duration
            end
        end
    end
end
