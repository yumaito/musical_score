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
            attr_accessor :credit, :identification, :part_lit, :measures
            Contract KeywordArgs[
                :credit         => Optional[String],
                :identification => Optional[MusicalScore::Score::Identification::Identification],
                :part_lit       => ArrayOf[MusicalScore::Score::Part::Part],
                :measures       => MusicalScore::Measures,
            ] => Any
            def initialize(
                credit: nil,
                identification: nil,
                part_lit:,
                measures:
                )
                @credit         = credit
                @identification = identification
                @part_lit       = part_lit
                @measures       = measures
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
