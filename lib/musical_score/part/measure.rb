require 'contracts'
require 'musical_score/attribute/attribute'
require 'musical_score/notes'

module MusicalScore
    module Part
        class Measure < MusicalScore::ElementBase
            include Contracts
            attr_reader :attribute, :notes
            Contract MusicalScore::Notes, Maybe[MusicalScore::Attribute::Attribute]=> Any
            def initialize(notes, attribute = nil)
                @notes     = notes
                @attribute = attribute
            end

            Contract REXML::Element => MusicalScore::Part::Measure
            def self.create_by_xml(xml_doc)
                attribute_doc = xml_doc.elements["//attributes"]
                attributes    = attribute_doc ? MusicalScore::Attribute::Attribute.create_by_xml(attribute_doc) : nil
                note_array = Array.new
                xml_doc.elements.each("//note") do |element|
                    note = MusicalScore::Note::Note.create_by_xml(element)
                    note_array.push(note)
                end
                notes = MusicalScore::Notes.new(note_array)
                return MusicalScore::Part::Measure.new(notes, attributes)
            end
        end
    end
end
