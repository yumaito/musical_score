require 'contracts'
module MusicalScore
    module Note
        class TimeModification < MusicalScore::ElementBase
            include Contracts
            attr_reader :actual_notes, :normal_notes

            Contract Pos, Pos => Any
            def initialize(actual_notes, normal_notes)
                @actual_notes = actual_notes
                @normal_notes = normal_notes
            end

            Contract REXML::Element => MusicalScore::Note::TimeModification
            def self.create_by_xml(xml_doc)
                actual_notes = xml_doc.elements["actual-notes"].text.to_i
                normal_notes = xml_doc.elements["normal-notes"].text.to_i
                return MusicalScore::Note::TimeModification.new(actual_notes, normal_notes)
            end

            def export_xml
                time_modification_element = REXML::Element.new('time-modification')
                actual_notes_element      = REXML::Element.new('actual-notes').add_text(@actual_notes.to_s)
                normal_notes_element      = REXML::Element.new('normal-notes').add_text(@normal_notes.to_s)

                time_modification_element.add_element(actual_notes_element)
                time_modification_element.add_element(normal_notes_element)

                return time_modification_element
            end
        end
    end
end