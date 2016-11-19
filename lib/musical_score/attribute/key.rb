require "contracts"
module MusicalScore
    module Attribute
        class Key < MusicalScore::ElementBase
            include Contracts
            @@mode = %i(major :minor)
            @@circle_of_fifths = [0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5]

            attr_reader :fifths, :mode
            # constructor
            #
            # @param fifths The number of sharps (positive) or flats (negative)
            # @param mode major or minor
            Contract Enum[*-NUMBER_OF_FIFTHS..NUMBER_OF_FIFTHS], Enum[*@@mode] => Any
            def initialize(fifths, mode)
                @fifths = fifths
                @mode   = mode.to_sym
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

            Contract REXML::Element => MusicalScore::Attribute::Key
            def self.create_by_xml(xml_doc)
                fifths = xml_doc.elements["fifths"].text.to_i
                mode   = xml_doc.elements["mode"].text.to_sym
                return MusicalScore::Attribute::Key.new(fifths, mode)
            end

            def export_xml
                key_element    = REXML::Element.new('key')
                fifths_element = REXML::Element.new('fifths').add_text(@fifths.to_s)
                mode_element   = REXML::Element.new('mode').add_text(@mode.to_s)

                key_element.add_element(fifths_element)
                key_element.add_element(mode_element)

                return key_element
            end
        end
    end
end