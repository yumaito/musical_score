module MusicalScore
    module Element
        class Key

            @@mode = [:major, :minor]
            @@circle_of_fifths = [0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5]

            attr_reader :fifths, :mode
            # constructor
            #
            # @param fifths [Integer] The number of sharps (positive) or flats (negative)
            # @param mode [Symbol] major or minor
            def initialize(fifths, mode)
                unless (@@mode.include?(mode.to_sym))
                    raise MusicalScore::InvalidKeyMode, "[#{mode}] is not a kind of key mode"
                end
                unless (fifths.between?(-7,7))
                    raise ArgumentError,  "[fifths] must be between -7 and 7"
                end
                @fifths = fifths
                @mode   = mode
            end

            def scale_name
                if @fifths >= 0
                    pitch_number = @@circle_of_fifths[@fifths]
                else
                end
            end
        end
    end
end