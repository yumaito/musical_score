require 'contracts'
module MusicalScore
    class Notes
        include Contracts
        attr_reader :notes

        Contract ArrayOf[MusicalScore::Note::Note] => Any
        def initialize(notes)
            @notes = notes
        end
    end
end
