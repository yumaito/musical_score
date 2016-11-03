require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Score
        class Score
            include Contracts
            attr_accessor :credit, :identification, :part_list, :parts
            Contract KeywordArgs[
                :credit         => Optional[String],
                :identification => Optional[MusicalScore::Score::Identification::Identification],
                :part_list      => ArrayOf[MusicalScore::Score::Part::Part],
                :parts          => ArrayOf[MusicalScore::Part::Part],
            ] => Any
            def initialize(
                credit: nil,
                identification: nil,
                part_list:,
                parts:
                )
                @credit         = credit
                @identification = identification
                @part_list      = part_list
                @parts          = parts
            end

            Contract REXML::Document => MusicalScore::Score::Score
            def self.create_by_xml(xml_doc)
                part = xml_doc.elements["//score-timewise"] ? xml_doc.elements["//score-timewise"] : xml_doc.elements["//score-partwise"]
                identification_doc = part.elements["//identification"]
                credit_doc         = part.elements["//credit"]
                part_lit           = part.elements["//part_lit"]
            end
        end
    end
end
