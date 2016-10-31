require 'musical_score'
require 'rexml/document'
module MusicalScore
    module IO
        def import_xml(file_path)
            xml = REXML::Document.new(File.new(file_path))
        end
    end
end
