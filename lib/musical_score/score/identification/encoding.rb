require 'contracts'
require 'time'

module MusicalScore
    module Score
        module Identification
            class Encoding < MusicalScore::ElementBase
                include Contracts
                attr_reader :encoding_date, :encoding_description, :softwares, :supports
                Contract Time, String, ArrayOf[String], ArrayOf[String] => Any
                def initialize(encoding_date, encoding_description, softwares, supports)
                    @encoding_date        = encoding_date
                    @encoding_description = encoding_description
                    @softwares            = softwares
                    @supports             = supports
                end

                Contract REXML::Element => MusicalScore::Score::Identification::Encoding
                def self.create_by_xml(xml_doc)

                    encoding_date = Time.new
                    if (xml_doc.elements["//encoding-date"])
                        encoding_date = Time.parse(xml_doc.elements["//encoding-date"].text)
                    end
                    encoding_description = xml_doc.elements["//encoding-description"] ? xml_doc.elements["//encoding_description"].text : ''
                    softwares = Array.new
                    xml_doc.elements.each("//software") do |element|
                        softwares.push(element.text)
                    end
                    supports = Array.new
                    xml_doc.elements.each("//supports") do |element|
                        if (element.attributes["type"] == "yes")
                            supports.push(element.attributes["element"])
                        end
                    end

                    return MusicalScore::Score::Identification::Encoding.new(encoding_date, encoding_description, softwares, supports)
                end
            end
        end
    end
end
