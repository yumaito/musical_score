require 'contracts'
module MusicalScore
    module Score
        module Identification
            class Creator < MusicalScore::ElementBase
                attr_reader :name, :type
                include Contracts
                Contract String, Enum[*TYPE_CREATOR] => Any
                def initialize(name, type)
                    @name = name
                    @type = type
                end

                Contract REXML::Element => MusicalScore::Score::Identification::Creator
                def self.create_by_xml(xml_doc)
                    type = xml_doc.attributes["type"].to_sym
                    name = xml_doc.text
                    return MusicalScore::Score::Identification::Creator.new(name, type)
                end

                def self.create_by_hash(doc)
                    type = doc["type"].to_sym
                    name = doc["content"]
                    return MusicalScore::Score::Identification::Creator.new(name, type)
                end

                def export_xml
                    creator = REXML::Element.new('creator')
                    creator.add_attribute('type', @type)
                    creator.add_text(@name)
                    return creator
                end
            end
        end
    end
end
