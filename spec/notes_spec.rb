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
    end
end
