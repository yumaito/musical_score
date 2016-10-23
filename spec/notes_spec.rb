require 'spec_helper'

describe MusicalScore::Notes do
    describe 'initialize' do
        let(:note) {
            MusicalScore::Note::Note.new(
                duration: 4,
                lyric: MusicalScore::Note::Lyric.new("all", :single),
                pitch: MusicalScore::Note::Pitch.new(:C, 0, 3),
                type: MusicalScore::Note::Type.new("quarter"),
            )
        }
        let(:notes) {
            MusicalScore::Notes.new([ note, note, note ])
        }

        it 'initialize' do
            expect(notes.notes).to match([ note, note, note ])
        end
    end
end
