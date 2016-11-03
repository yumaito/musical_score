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
            end
        end
    end
end