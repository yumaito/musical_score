require 'musical_score'
require 'rexml/document'
require 'xmlsimple'
require 'pp'
module MusicalScore
    module IO
        def import(file)
            extname = File.extname(file)
            case extname
            when ".xml"
                return import_xml_via_hash(file)
            else
                raise MusicalScore::InvalidFileType
            end
        end
        def import_xml(file_path)
            doc = REXML::Document.new(File.new(file_path))
            score = MusicalScore::Score::Score.create_by_xml(doc, file_path)
            return score
        end

        def import_xml_via_hash(file_path)
            doc = XmlSimple.xml_in(open(file_path))
            score = MusicalScore::Score::Score.create_by_hash(doc, file_path)
        end

        module_function :import, :import_xml, :import_xml_via_hash
    end
end
