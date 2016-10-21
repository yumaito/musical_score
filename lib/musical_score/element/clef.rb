module MusicalScore
    module Element
            class Clef

            @@sign = [:G, :F, :C, :percussion, :TAB, :jianpu, :none]
            attr_reader :sign, :line, :clef_octave_change

            # constructor
            #
            # @param sign [Symbol] The sign of clef, such as treble, bass. It is described by the @@sign symbols
            # @param line [Integer] The number of line from the bottom of the staff, which the sign note is defined at the line.
            # @param clef_octave_change [Integer] The number of clef changes, which is written either an octave higher or lower than sounding pitch
            def initialize(sign, line = 0, clef_octave_change = 0)
                unless (@@sign.include?(sign.to_sym))
                    raise MusicalScore::InvalidClefSign, "\"#{sign}\" is not a kind of clef sign."
                end
                @sign               = sign
                @line               = line
                @clef_octave_change = clef_octave_change
            end
        end
    end
end