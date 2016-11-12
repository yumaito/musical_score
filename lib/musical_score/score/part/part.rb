require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Score
        module Part
            class Part < MusicalScore::ElementBase
                include Contracts
                attr_reader :part_name, :part_abbreviation

                Contract String, String => Any
                def initialize(part_name, part_abbreviation)
                    @part_name         = part_name
                    @part_abbreviation = part_abbreviation
                end

                def export_xml(index)
                    score_part_element = REXML::Element.new('score-part')
                    score_part_element.add_attribute('id', "P" + index.to_s)

                    part_name_element  = REXML::Element.new('part-name')
                    part_name_element.add_text(@part_name)
                    part_abbreviation_element = REXML::Element.new('part-abbreviation')
                    part_abbreviation_element.add_text(@part_abbreviation)
                    score_part_element.add_element(part_name_element)
                    score_part_element.add_element(part_abbreviation_element)

                    return score_part_element
                end
            end
        end
    end
end
