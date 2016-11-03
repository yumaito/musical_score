require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Score
        class Score < MusicalScore::ElementBase
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
                partwise           = xml_doc.elements["//score-partwise"]
                identification_doc = partwise.elements["//identification"]
                credit_doc         = partwise.elements["//credit"]
                part_list_doc      = partwise.elements["//part_list"]
                parts_doc          = partwise.elements["//part"]

                args = {}
                if (identification_doc)
                    identification = MusicalScore::Score::Identification::Identification.create_by_xml(identification_doc)
                    args[:identification] = identification
                end

            end
        end
    end
end
