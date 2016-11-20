require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Attribute
        class Attribute < MusicalScore::ElementBase
            include Contracts
            attr_accessor :divisions, :key, :time, :instruments, :clef

            # initialize the attibute
            #
            Contract KeywordArgs[
                :divisions   => Num,
                :clef        => Optional[MusicalScore::Attribute::Clef],
                :key         => Optional[MusicalScore::Attribute::Key],
                :time        => Optional[MusicalScore::Attribute::Time],
                :instruments => Optional[String],
            ] => Any
            def initialize(
                divisions:,
                clef: MusicalScore::Attribute::Clef.new(:G),
                key: MusicalScore::Attribute::Key.new(0, :major),
                time: MusicalScore::Attribute::Time.new(4, 4),
                instruments: 'Piano',
                **rest_args
                )
                @divisions   = divisions
                @clef        = clef
                @key         = key
                @time        = time
                @instruments = instruments
            end

            Contract REXML::Element => MusicalScore::Attribute::Attribute
            def self.create_by_xml(xml_doc)
                divisions = xml_doc.elements["//divisions"].text.to_i
                clef_doc  = xml_doc.elements["//clef"]
                time_doc  = xml_doc.elements["//time"]
                key_doc   = xml_doc.elements["//key"]

                clef = clef_doc ? MusicalScore::Attribute::Clef.create_by_xml(clef_doc) : nil
                time = time_doc ? MusicalScore::Attribute::Time.create_by_xml(time_doc) : nil
                key  = key_doc ? MusicalScore::Attribute::Key.create_by_xml(key_doc) : nil

                attributes = MusicalScore::Attribute::Attribute.new(divisions: divisions, clef: clef, time: time)
                return attributes
            end

            Contract HashOf[String => Any] => MusicalScore::Attribute::Attribute
            def self.create_by_hash(doc)
                divisions = doc["divisions"][0].to_i
                clef      = doc.has_key?("clef") ? MusicalScore::Attribute::Clef.create_by_hash(doc["clef"][0]) : nil
                time      = doc.has_key?("time") ? MusicalScore::Attribute::Time.create_by_hash(doc["time"][0]) : nil
                key       = doc.has_key?("key") ? MusicalScore::Attribute::Key.create_by_hash(doc["key"][0]) : nil

                attributes = MusicalScore::Attribute::Attribute.new(divisions: divisions, clef: clef, key: key, time: time)
                return attributes
            end

            def export_xml
                attribute_element = REXML::Element.new('attributes')
                divisions_element = REXML::Element.new('divisions').add_text(@divisions.to_s)
                key_element       = @key.export_xml
                time_element      = @time.export_xml
                clef_element      = @clef.export_xml

                attribute_element.add_element(divisions_element)
                attribute_element.add_element(key_element)
                attribute_element.add_element(time_element)
                attribute_element.add_element(clef_element)

                return attribute_element
            end
        end
    end
end
