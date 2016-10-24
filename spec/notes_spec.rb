require 'spec_helper'

describe MusicalScore::Notes do
    describe 'initialize' do
        let(:note_array) {
            create_notes(3)
        }
        let(:notes) {
            MusicalScore::Notes.new(note_array)
        }

        it 'initialize' do
            expect(notes.notes).to match(note_array)
        end
        it 'check local location' do
            locations = notes.notes.collect{ |item| item.local_location }
            expect(locations).to match([
                Rational(0),
                Rational(4),
                Rational(8),
            ])
        end
        let(:note_and_rest) {
            MusicalScore::Notes.new(create_notes_with_rest(6))
        }
        it 'divide_to_notes_and_rests' do
            divided_array = note_and_rest.divide_to_notes_and_rests
            rest_of_notes = divided_array[:note].collect { |note| note.rest }
            rest_of_rests = divided_array[:rest].collect { |note| note.rest }
            expect(rest_of_notes).to all(be_falsey)
            expect(rest_of_rests).to all(be_truthy)
        end
    end
end