require 'contracts'
require 'musical_score/note/note'
module MusicalScore
    class Notes < MusicalScore::ElementBase
        include Contracts
        attr_reader :notes

        Contract ArrayOf[MusicalScore::Note::Note] => Any
        def initialize(notes)
            @notes = notes
        end
        def divide_to_notes_and_rests
            divided_array = @notes.partition { |note| note.rest }
            return { note: divided_array[1], rest: divided_array[0] }
        end
    end
end
