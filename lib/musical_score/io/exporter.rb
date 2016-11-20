require 'musical_score'
require 'rexml/document'
require 'rexml/formatters/pretty'
module MusicalScore
    module IO
        def export_xml(path, score)
            formatter = REXML::Formatters::Pretty.new(4)
            formatter.compact = true
            File.open(path, 'w') do |file|
                formatter.write(score.export_xml, file)
            end
        end

        module_function :export_xml
    end
end
