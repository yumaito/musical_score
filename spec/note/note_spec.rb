require 'spec_helper'

describe MusicalScore::Note::Note do
    describe 'initialize' do
        it 'rest note' do
            rest = MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 0,
                rest: true,
                type: MusicalScore::Note::Type.new("quarter"),
            )
            expect(rest.duration).to eq 4
            expect(rest.tie).to eq nil
            expect(rest.lyric).to eq nil
            expect(rest.pitch).to eq nil
            expect(rest.rest).to be_truthy
            expect(rest.type.size).to eq "quarter"
        end

        it 'pitch note' do
            note = MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 1,
                lyric: MusicalScore::Note::Lyric.new("all", :single),
                pitch: MusicalScore::Note::Pitch.new(:C),
                type: MusicalScore::Note::Type.new("eighth")
            )
            expect(note.duration).to eq 4
            expect(note.tie).to eq nil
            expect(note.dot).to eq 1
            expect(note.lyric.text).to eq "all"
            expect(note.rest).to be_falsey
            expect(note.type.size).to eq "eighth"
            expect(note.actual_duration).to eq Rational(4, 1)
        end

        it 'set actual duration' do
            triplet_note = MusicalScore::Note::Note.new(
                duration: 2,
                pitch: MusicalScore::Note::Pitch.new(:C),
                type: MusicalScore::Note::Type.new("eighth"),
                time_modification: MusicalScore::Note::TimeModification.new(3, 2)
            )
            expect(triplet_note.actual_duration).to eq Rational(4, 3)
        end

        let(:pitch_rest) {
            MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                pitch: MusicalScore::Note::Pitch.new(:C),
                rest: true,
                type: MusicalScore::Note::Type.new("16th"),
            )
        }
        it 'raise error' do
            expect{ pitch_rest }.to raise_error(ArgumentError)
        end
    end
end
