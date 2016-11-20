require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Score
        module Identification
            class Identification < MusicalScore::ElementBase
                include Contracts
                attr_reader :creators, :encoding
                Contract ArrayOf[Maybe[MusicalScore::Score::Identification::Creator]], Maybe[MusicalScore::Score::Identification::Encoding] => Any
                def initialize(creators, encodings)
                    @creators = creators
                    @encoding = encodings
                end

                Contract REXML::Element => MusicalScore::Score::Identification::Identification
                def self.create_by_xml(xml_doc)
                    creator_doc  = xml_doc.elements["//creator"]
                    encoding_doc = xml_doc.elements["//encoding"]

                    creators = Array.new
                    xml_doc.elements.each("//creator") do |element|
                        creators.push(MusicalScore::Score::Identification::Creator.create_by_xml(element))
                    end

                    encoding = encoding_doc ? MusicalScore::Score::Identification::Encoding.create_by_xml(encoding_doc) : nil

                    return MusicalScore::Score::Identification::Identification.new(creators, encoding)
                end

                def self.create_by_hash(doc)
                    creators = Array.new
                    if (doc.has_key?("creator"))
                        doc["creator"].each do |element|
                            creators.push(MusicalScore::Score::Identification::Creator.create_by_hash(element))
                        end
                    end
                    encoding = doc.has_key?("encoding") ? MusicalScore::Score::Identification::Encoding.create_by_hash(doc["encoding"][0]) : nil
                    return MusicalScore::Score::Identification::Identification.new(creators, encoding)
                end

                def export_xml
                    identification = REXML::Element.new('identification')
                    @creators.each do |creator|
                        identification.add_element(creator.export_xml)
                    end
                    identification.add_element(@encoding.export_xml)

                    return identification
                end
            end
        end
    end
end
