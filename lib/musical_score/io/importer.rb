require 'musical_score'
require 'rexml/document'
require 'rexml/formatters/pretty'
module MusicalScore
    module IO
        def import(file)
            extname = File.extname(file)
            case extname
            when ".xml"
                return import_xml(file)
            else
                raise MusicalScore::InvalidFileType
            end
        end
        def import_xml(file_path)
            doc = REXML::Document.new(File.new(file_path))
            score = MusicalScore::Score::Score.create_by_xml(doc, file_path)
            return score
        end

        module_function :import, :import_xml
    end
end
