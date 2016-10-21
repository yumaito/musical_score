module MusicalScore
    module Element
        class key

            @@mode = [:major, :minor]

            attr_reader :fifths, :mode
            # constructor
            #
            # @param fifthss [Integer] The number of sharps (positive) or flats (negative)
            # @param mode [Symbol] major or minor
            def initialize(fifths, mode)
                unless (@@mode.include?(mode.to_sym))
                    raise MusicalScore::InvalidKeyMode, "[#{mode}] is not a kind of key mode"
                end
                @fifths = fifths
                @mode   = mode
            end


        end
    end
end