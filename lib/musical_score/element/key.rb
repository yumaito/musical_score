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

            def altered_pitches
                if @fifths >= 0
                    pitch_number = @@circle_of_fifths[@fifths]
                    pitch = MusicalScore::Element::Pitch.new_note_sharp(pitch_number)
                    shap_start_index = 11
                    altered_pitches = Array.new
                    @fifths.times do |i|
                        count = (i + shap_start_index) % 12
                        altered_pitches.push(MusicalScore::Element::Pitch.new_note_sharp(@@circle_of_fifths[count]))
                    end
                    return { :pitch => pitch, :altered_pitches => altered_pitches }
                else
                    reversed = @@circle_of_fifths.reverse
                    fif      = @fifths.abs
                    pitch_number = reversed[fif-1]
                    pitch = MusicalScore::Element::Pitch.new_note_flat(pitch_number)
                    flat_start_index = 6
                    altered_pitches = Array.new
                    fif.times do |i|
                        count = (i + flat_start_index) % 12
                        altered_pitches.push(MusicalScore::Element::Pitch.new_note_flat(reversed[count]))
                    end
                    return { :pitch => pitch, :altered_pitches => altered_pitches }
                end
            end
        end
    end
end