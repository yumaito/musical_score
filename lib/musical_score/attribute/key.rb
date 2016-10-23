require "contracts"
module MusicalScore
    module Attribute
        class Key
            include Contracts
            @@mode = [:major, :minor]
            @@circle_of_fifths = [0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5]

            attr_reader :fifths, :mode
            # constructor
            #
            # @param fifths The number of sharps (positive) or flats (negative)
            # @param mode major or minor
            Contract Enum[*-NUMBER_OF_FIFTHS..NUMBER_OF_FIFTHS], Enum[*@@mode] => Any
            def initialize(fifths, mode)
                @fifths = fifths
                @mode   = mode
            end

            # detect tonic in major scale and minor scale, and pithes that has sharp or flat
            #
            Contract None => HashOf[Any, Any]
            def tonic_key_and_altered_pitches
                if @fifths >= 0
                    pitch_number = @@circle_of_fifths[@fifths]
                    major_pitch = MusicalScore::Note::Pitch.new_note_sharp(pitch_number)

                    minor_number = (pitch_number + RELATED_KEY_SLIDE_NUMBER) % NUMBER_OF_NOTES
                    minor_pitch  = MusicalScore::Note::Pitch.new_note_sharp(minor_number)

                    altered_pitches  = Array.new
                    @fifths.times do |i|
                        count = (i + SHARP_START_INDEX) % NUMBER_OF_NOTES
                        altered_pitches.push(MusicalScore::Note::Pitch.new_note_sharp(@@circle_of_fifths[count]))
                    end
                    return { :major_pitch => major_pitch, :minor_pitch => minor_pitch, :altered_pitches => altered_pitches }
                else
                    reversed = @@circle_of_fifths.reverse
                    fif      = @fifths.abs
                    pitch_number = reversed[fif-1]
                    major_pitch = MusicalScore::Note::Pitch.new_note_flat(pitch_number)

                    minor_number = (pitch_number + RELATED_KEY_SLIDE_NUMBER) % NUMBER_OF_NOTES
                    minor_pitch  = MusicalScore::Note::Pitch.new_note_flat(minor_number)

                    altered_pitches  = Array.new
                    fif.times do |i|
                        count = (i + FLAT_START_INDEX) % NUMBER_OF_NOTES
                        altered_pitches.push(MusicalScore::Note::Pitch.new_note_flat(reversed[count]))
                    end
                    return { :major_pitch => major_pitch, :minor_pitch => minor_pitch, :altered_pitches => altered_pitches }
                end
            end
        end
    end
end