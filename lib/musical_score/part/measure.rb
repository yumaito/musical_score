require 'contracts'
require 'musical_score/attribute/attribute'
require 'musical_score/notes'

module MusicalScore
    module Part
        class Measure < MusicalScore::ElementBase
            include Contracts
            attr_reader :attribute, :number, :notes
            attr_accessor :length
            Contract MusicalScore::Notes, Nat, Maybe[MusicalScore::Attribute::Attribute]=> Any
            def initialize(notes, number, attribute = nil)
                @notes     = notes
                @number    = number
                @attribute = attribute
            end

            Contract REXML::Element => MusicalScore::Part::Measure
            def self.create_by_xml(xml_doc)
                attribute_doc = xml_doc.elements["//attributes"]
                attributes    = attribute_doc ? MusicalScore::Attribute::Attribute.create_by_xml(attribute_doc) : nil
                number        = xml_doc.attributes["number"].to_i
                note_array = Array.new
                xml_doc.elements.each("//note") do |element|
                    note = MusicalScore::Note::Note.create_by_xml(element)
                    note_array.push(note)
                end
                notes = MusicalScore::Notes.new(note_array)
                return MusicalScore::Part::Measure.new(notes, number, attributes)
            end

            def self.create_by_hash(doc)
                number = doc["number"].to_i
                attributes = doc.has_key?("attributes") ? MusicalScore::Attribute::Attribute.create_by_hash(doc["attributes"][0]) : nil
                note_array = Array.new
                doc["note"].each do |element|
                    note = MusicalScore::Note::Note.create_by_hash(element)
                    note_array.push(note)
                end
                notes = MusicalScore::Notes.new(note_array)
                return MusicalScore::Part::Measure.new(notes, number, attributes)
            end

            def export_xml
                measure_element = REXML::Element.new('measure')
                measure_element.add_attribute('number',@number.to_s)
                measure_element.add_element(@attribute.export_xml) if @attribute

                @notes.each do |note|
                    measure_element.add_element(note.export_xml)
                end

                return measure_element
            end

            def location
                return @notes[0].location
            end
        end
    end
end
