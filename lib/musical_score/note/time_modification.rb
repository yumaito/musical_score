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
        end
    end
end