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
            attr_accessor :credit, :identification, :part_lit, :measure
            Contract KeywordArgs[
                :credit         => Optional[Str],
                :identification => Optional[MusicalScore::Identification::Identification],
                :part_lit       => ArrayOf[MusicalScore::Part::Part],
                :measure        => ArrayOf[MusicalScore::Measures],
            ] => Any
            def initialize(
                credit: nil,
                identification: nil,
                part_lit:
                measure:
                )
        end
    end
end
