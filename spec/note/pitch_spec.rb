require 'spec_helper'

describe MusicalScore::Note::Pitch do
    describe 'initialize' do

        it 'successfully create pitch with symbol' do
            pitch_with_symbol = MusicalScore::Note::Pitch.new(:D, -2, 2)
            expect(pitch_with_symbol.step).to eq :D
            expect(pitch_with_symbol.alter).to eq -2
            expect(pitch_with_symbol.octave).to eq 2
        end

        # check error case
        it 'raise InvalidNote Error' do
            expect{ MusicalScore::Note::Pitch.new(:R, 2, 2) }.to raise_error(ArgumentError)
        end
        context 'step is lower case letter' do
            it 'raise InvalidNote Error' do
                expect{ MusicalScore::Note::Pitch.new(:c, 0, 0) }.to raise_error(ArgumentError)
            end
        end
        context 'alter is not integer' do
            it 'raise ArgumentError for string' do
                expect{ MusicalScore::Note::Pitch.new(:C, "2", 0) }.to raise_error(ArgumentError)
            end
            it 'raise ArgumentError for decimal value' do
                expect{ MusicalScore::Note::Pitch.new(:C, 1.3, 0) }.to raise_error(ArgumentError)
            end
        end
        context 'alter is out of range' do
            it 'raise ArgumentError' do
                expect{ MusicalScore::Note::Pitch.new(:C, 3, 0) }.to raise_error(ArgumentError)
            end
        end
        context 'octave is not integer' do
            it 'raise ArgumentError for string' do
                expect{ MusicalScore::Note::Pitch.new(:C, 0, "0") }.to raise_error(ArgumentError)
            end
            it 'raise ArgumentError for decimal value' do
                expect{ MusicalScore::Note::Pitch.new(:C, 0, 0.0) }.to raise_error(ArgumentError)
            end
        end
        context 'octave is less than zero' do
            it 'raise ArgumentError' do
                expect{ MusicalScore::Note::Pitch.new(:C, 0, -1) }.to raise_error(ArgumentError)
            end
        end
    end

    describe 'Comparable' do
        let(:c3) { MusicalScore::Note::Pitch.new(:C, 0, 3)}
        let(:c3_2) { MusicalScore::Note::Pitch.new(:C, 0, 3)}
        let(:d2) { MusicalScore::Note::Pitch.new(:D, 0, 2)}
        let(:c4) { MusicalScore::Note::Pitch.new(:C, 0, 4)}
        it 'c3 = c3' do
            expect(c3 == c3_2).to be_truthy
        end
        it 'c3 > d2' do
            expect(c3 > d2).to be_truthy
        end
        it 'c3 < c4' do
            expect(c3 < c4).to be_truthy
        end
    end

    describe 'new_note_sharp' do
        it 'create new note from note number 60' do
            note1 = MusicalScore::Note::Pitch.new_note_sharp(60)
            expect(note1.step).to eq :C
            expect(note1.alter).to eq 0
            expect(note1.octave).to eq 5
        end
        it 'create new note from note number 39' do
            note2 = MusicalScore::Note::Pitch.new_note_sharp(39)
            expect(note2.step).to eq :D
            expect(note2.alter).to eq 1
            expect(note2.octave).to eq 3
        end
        it 'create new note from note number 70' do
            note3 = MusicalScore::Note::Pitch.new_note_sharp(70)
            expect(note3.step).to eq :A
            expect(note3.alter).to eq 1
            expect(note3.octave).to eq 5
        end
    end

    describe 'new_note_flat' do
        it 'create new note from note number 60' do
            note1 = MusicalScore::Note::Pitch.new_note_flat(60)
            expect(note1.step).to eq :C
            expect(note1.alter).to eq 0
            expect(note1.octave).to eq 5
        end
        it 'create new note from note number 39' do
            note2 = MusicalScore::Note::Pitch.new_note_flat(39)
            expect(note2.step).to eq :E
            expect(note2.alter).to eq -1
            expect(note2.octave).to eq 3
        end
        it 'create new note from note number 70' do
            note3 = MusicalScore::Note::Pitch.new_note_flat(70)
            expect(note3.step).to eq :B
            expect(note3.alter).to eq -1
            expect(note3.octave).to eq 5
        end
    end

    describe 'note_number' do
        let(:pitch) { MusicalScore::Note::Pitch.new(:C, 0, 3) }
        it 'C3 returns correct note number' do
            expect(pitch.note_number).to eq 36
        end
        let(:pitch_d) { MusicalScore::Note::Pitch.new(:D, 1, 3) }
        it 'D#3 returns correct note number' do
            expect(pitch_d.note_number).to eq 39
        end
    end

    describe 'to_s' do
        let(:note1) { MusicalScore::Note::Pitch.new(:C, 0, 5)}
        let(:note2) { MusicalScore::Note::Pitch.new(:D, 1, 3)}
        let(:note3) { MusicalScore::Note::Pitch.new(:D, 2, 3)}
        let(:note4) { MusicalScore::Note::Pitch.new(:B, -1, 3)}
        let(:note5) { MusicalScore::Note::Pitch.new(:A, -2, 3)}
        it 'returns C5' do
            expect(note1.to_s(true)).to eq 'C5'
        end
        it 'reteurns D#3' do
            expect(note2.to_s(true)).to eq 'D#3'
        end
        it 'returns D##3' do
            expect(note3.to_s(true)).to eq 'D##3'
        end
        it 'reteurns Bb3' do
            expect(note4.to_s(true)).to eq 'Bb3'
        end
        it 'returns Abb3' do
            expect(note5.to_s(true)).to eq 'Abb3'
        end
    end

    describe 'clone' do
        let(:note) { MusicalScore::Note::Pitch.new(:C, 0, 5)}
        it 'creates different instance' do
            expect(note.clone.equal?(note)).to be_falsey
        end
        it '== shows equal' do
            expect(note == note.clone).to be_truthy
        end
    end

    let(:dummy) {
        '<pitch>
    <step>F</step>
    <alter>1</alter>
    <octave>4</octave>
</pitch>'
    }
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy)
            pitch = MusicalScore::Note::Pitch.create_by_xml(xml.elements["pitch"])
            expect(pitch).to have_attributes(step: :F, alter: 1, octave: 4)
        end
    end
    describe 'create_by_hash' do
        it do
            doc = dummy_xml_hash(dummy)
            pitch = MusicalScore::Note::Pitch.create_by_hash(doc)
            expect(pitch).to have_attributes(step: :F, alter: 1, octave: 4)
        end
    end
    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy)
            pitch = MusicalScore::Note::Pitch.create_by_xml(xml.elements["pitch"])
            expect(format_xml(pitch.export_xml)).to eq format_xml(xml.elements["pitch"])
        end
    end
end
