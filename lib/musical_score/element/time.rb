module MusicalScore
    module Element
        class Time
            attr_reader :beats, :beat_type

            # constructor
            #
            # @param beats [Integer]
            # @param beat_type [Integer]
            def initialize(beats, beat_type)
                @beats     = beats
                @beat_type = beat_type
            end

            def to_s
                return "%d / %d" % [@beats, @beat_type]
            end
        end
    end
end