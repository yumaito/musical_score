require 'musical_score'
require 'rexml/document'
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
            xml = REXML::Document.new(File.new(file_path))
        end

        module_function :import
    end
end
