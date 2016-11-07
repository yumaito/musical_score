require 'contracts'
require 'musical_score/note/note'
module MusicalScore
    class Notes < MusicalScore::ElementBase
        include Contracts
        attr_reader :notes, :duration

        Contract ArrayOf[MusicalScore::Note::Note] => Any
        def initialize(notes)
            @notes = notes
        end
        def divide_to_notes_and_rests
            divided_array = @notes.partition { |note| note.rest }
            return { note: divided_array[1], rest: divided_array[0] }
        end

        def [](index)
            return @notes[index]
        end

        def set_location(location, number)
            current_location = MusicalScore::Location.new(number, location)
            @notes.each do |note|
                note.location = current_location
                current_location = MusicalScore::Location.new(number, current_location.location + note.actual_duration)
            end
            @duration = current_location.location - location
        end
    end
end
