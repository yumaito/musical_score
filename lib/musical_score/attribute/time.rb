require 'contracts'
module MusicalScore
    module Attribute
        class Time
            include Contracts
            attr_reader :beats, :beat_type

            # constructor
            #
            Contract Num, Num => Any
            def initialize(beats, beat_type)
                @beats     = beats
                @beat_type = beat_type
            end

            # @return [String] describe the time object in a fraction style
            def to_s
                return "%d/%d" % [@beats, @beat_type]
            end
        end
    end
end