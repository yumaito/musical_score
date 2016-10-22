module MusicalScore
    module Attribute
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
                unless (fifths.between?(-7, 7))
                    raise ArgumentError,  "[fifths] must be between -7 and 7"
                end
                @fifths = fifths
                @mode   = mode
            end

            # detect tonic in major scale and minor scale, and pithes that has sharp or flat
            #
            # @return [Hash] { :major_pitch => Pitch, :minor_pitch => Pitch, :altered_pitches => Array of Pitch }
            def tonic_key_and_altered_pitches
                if @fifths >= 0
                    pitch_number = @@circle_of_fifths[@fifths]
                    major_pitch = MusicalScore::Note::Pitch.new_note_sharp(pitch_number)

                    minor_number = (pitch_number + 9) % 12
                    minor_pitch  = MusicalScore::Note::Pitch.new_note_sharp(minor_number)

                    shap_start_index = 11
                    altered_pitches  = Array.new
                    @fifths.times do |i|
                        count = (i + shap_start_index) % 12
                        altered_pitches.push(MusicalScore::Note::Pitch.new_note_sharp(@@circle_of_fifths[count]))
                    end
                    return { :major_pitch => major_pitch, :minor_pitch => minor_pitch, :altered_pitches => altered_pitches }
                else
                    reversed = @@circle_of_fifths.reverse
                    fif      = @fifths.abs
                    pitch_number = reversed[fif-1]
                    major_pitch = MusicalScore::Note::Pitch.new_note_flat(pitch_number)

                    minor_number = (pitch_number + 9) % 12
                    minor_pitch  = MusicalScore::Note::Pitch.new_note_flat(minor_number)

                    flat_start_index = 6
                    altered_pitches  = Array.new
                    fif.times do |i|
                        count = (i + flat_start_index) % 12
                        altered_pitches.push(MusicalScore::Note::Pitch.new_note_flat(reversed[count]))
                    end
                    return { :major_pitch => major_pitch, :minor_pitch => minor_pitch, :altered_pitches => altered_pitches }
                end
            end
        end
    end
end