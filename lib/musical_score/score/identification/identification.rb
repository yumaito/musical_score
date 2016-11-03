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
            class Identification
                include Contracts
                attr_reader :creators, :encodings
                Contract ArrayOf[MusicalScore::Score::Identification::Creator], ArrayOf[MusicalScore::Score::Identification::Encoding] => Any
                def initialize(creators, encodings)
                    @creators  = creators
                    @encodings = encodings
                end

                Contract REXML::Element => MusicalScore::Score::Identification::Identification
                def self.create_by_xml(xml_doc)
                end
            end
        end
    end
end
