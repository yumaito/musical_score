require 'spec_helper'

describe MusicalScore::Notes do
    describe 'initialize' do

        it 'initialize' do
            note_array = create_notes(3)
            notes = MusicalScore::Notes.new(note_array)
            expect(notes.notes).to match(note_array)
        end
        it 'divide_to_notes_and_rests' do
            note_and_rest = MusicalScore::Notes.new(create_notes_with_rest(6))
            divided_array = note_and_rest.divide_to_notes_and_rests
            rest_of_notes = divided_array[:note].collect { |note| note.rest }
            rest_of_rests = divided_array[:rest].collect { |note| note.rest }
            expect(rest_of_notes).to all(be_falsey)
            expect(rest_of_rests).to all(be_truthy)
        end

        it 'divide' do
            notes = MusicalScore::Notes.new(create_notes(4))
            notes.set_location(Rational(0), 1)
            durations_before = notes.notes.collect { |note| note.duration }
            expect(notes).to match([
                have_attributes(duration: 4),
                have_attributes(duration: 4),
                have_attributes(duration: 4),
                have_attributes(duration: 4),
            ])
            notes.divide(1,1,1)
            expect(notes).to match([
                have_attributes(duration: 4),
                have_attributes(duration: 2),
                have_attributes(duration: 2),
                have_attributes(duration: 4),
                have_attributes(duration: 4),
            ])
        end
    end
end
