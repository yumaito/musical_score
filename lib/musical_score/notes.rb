require 'contracts'
module MusicalScore
    class Notes
        include Contracts
        attr_reader :notes

        Contract ArrayOf[MusicalScore::Note::Note] => Any
        def initialize(notes)
            local_location = 0
            @notes = Array.new
            notes.each do |note|
                note.local_location = local_location
                @notes.push(note)
                local_location += note.actual_duration
            end
        end
        def divide_to_notes_and_rests
            divided_array = @notes.partition { |note| note.rest }
            return { note: divided_array[1], rest: divided_array[0] }
        end
    end
end
