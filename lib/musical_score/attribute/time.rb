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
                beat_type = xml_doc.elements["beat_type"].text.to_i
                return MusicalScore::Attribute::Time.new(beats, beat_type)
            end
        end
    end
end