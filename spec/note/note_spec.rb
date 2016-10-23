require 'spec_helper'

describe MusicalScore::Note::Note do
    describe 'initialize' do
        let(:rest) {
            MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 0,
                rest: true,
                type: MusicalScore::Note::Type.new("quarter")
            )
        }
        it 'rest note' do
            expect(rest.duration).to eq 4
            expect(rest.tie).to eq nil
            expect(rest.lyric).to eq nil
            expect(rest.pitch).to eq nil
            expect(rest.rest).to be_truthy
            expect(rest.type.size).to eq "quarter"
        end

        let(:note) {
            MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 1,
                lyric: MusicalScore::Note::Lyric.new("all", :single),
                pitch: MusicalScore::Note::Pitch.new(:C),
                type: MusicalScore::Note::Type.new("eighth")
            )
        }
        it 'pitched note' do
            expect(note.duration).to eq 4
            expect(note.tie).to eq nil
            expect(note.dot).to eq 1
            expect(note.lyric.text).to eq "all"
            expect(note.rest).to be_falsey
            expect(note.type.size).to eq "eighth"
        end
    end
end
