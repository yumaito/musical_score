require 'contracts'
module MusicalScore
    module Attribute
        class Time < MusicalScore::ElementBase
            include Contracts
            attr_reader :beats, :beat_type

            # constructor
            #
            Contract Num, Num => Any
            def initialize(beats, beat_type)
                @beats     = beats
                @beat_type = beat_type
            end

            # @return [String] describe the time object in a fraction style
            def to_s
                return "%d/%d" % [@beats, @beat_type]
            end

            Contract REXML::Element => MusicalScore::Attribute::Time
            def self.create_by_xml(xml_doc)
                beats     = xml_doc.elements["beats"].text.to_i
                beat_type = xml_doc.elements["beat-type"].text.to_i
                return MusicalScore::Attribute::Time.new(beats, beat_type)
            end

            Contract HashOf[String => Any] => MusicalScore::Attribute::Time
            def self.create_by_hash(doc)
                beats     = doc["beats"][0].to_i
                beat_type = doc["beat-type"][0].to_i
                return MusicalScore::Attribute::Time.new(beats, beat_type)
            end

            def export_xml
                time      = REXML::Element.new('time')
                beats     = REXML::Element.new('beats')
                beat_type = REXML::Element.new('beat-type')

                beats.add_text(@beats.to_s)
                beat_type.add_text(@beat_type.to_s)

                time.add_element(beats)
                time.add_element(beat_type)

                return time
            end
        end
    end
end
