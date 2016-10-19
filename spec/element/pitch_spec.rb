require 'spec_helper'

describe MusicalScore::Element::Pitch do
    describe 'initialize' do
        let(:pitch) { MusicalScore::Element::Pitch.new("C", 2, 3) }
        it 'successfully create pitch' do
            expect(pitch.step).to eq :C
            expect(pitch.alter).to eq 2
            expect(pitch.octave).to eq 3
        end

        let(:pitch_with_symbol) { MusicalScore::Element::Pitch.new(:D, -2, 2) }
        it 'successfully create pitch with symbol' do
            expect(pitch_with_symbol.step).to eq :D
            expect(pitch_with_symbol.alter).to eq -2
            expect(pitch_with_symbol.octave).to eq 2
        end

        # check error case
        it 'raise InvalidNote Error' do
            expect{ MusicalScore::Element::Pitch.new(:R, 2, 2) }.to raise_error(MusicalScore::InvalidNote)
        end
        context 'step is lower case letter' do
            it 'raise InvalidNote Error' do
                expect{ MusicalScore::Element::Pitch.new(:c, 0, 0) }.to raise_error(MusicalScore::InvalidNote)
            end
        end
        context 'alter is not integer' do
            it 'raise TypeError for string' do
                expect{ MusicalScore::Element::Pitch.new(:C, "2", 0) }.to raise_error(TypeError)
            end
            it 'raise TypeError for decimal value' do
                expect{ MusicalScore::Element::Pitch.new(:C, 1.3, 0) }.to raise_error(TypeError)
            end
        end
        context 'alter is out of range' do
            it 'raise ArgumentError' do
                expect{ MusicalScore::Element::Pitch.new(:C, 3, 0) }.to raise_error(ArgumentError)
            end
        end
        context 'octave is not integer' do
            it 'raise TypeError for string' do
                expect{ MusicalScore::Element::Pitch.new(:C, 0, "0") }.to raise_error(TypeError)
            end
            it 'raise TypeError for decimal value' do
                expect{ MusicalScore::Element::Pitch.new(:C, 0, 0.0) }.to raise_error(TypeError)
            end
        end
        context 'octave is less than zero' do
            it 'raise ArgumentError' do
                expect{ MusicalScore::Element::Pitch.new(:C, 0, -1) }.to raise_error(ArgumentError)
            end
        end
    end

    describe 'Comparable' do
        let(:c3) { MusicalScore::Element::Pitch.new(:C, 0, 3)}
        let(:c3_2) { MusicalScore::Element::Pitch.new(:C, 0, 3)}
        let(:d2) { MusicalScore::Element::Pitch.new(:D, 0, 2)}
        let(:c4) { MusicalScore::Element::Pitch.new(:C, 0, 4)}
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

    describe 'new_note_number' do
        let(:note1) { MusicalScore::Element::Pitch.new_note_number(60)}
        it 'create new note from note number 60' do
            expect(note1.step).to eq :C
            expect(note1.alter).to eq 0
            expect(note1.octave).to eq 5
        end
        let(:note2) { MusicalScore::Element::Pitch.new_note_number(39)}
        it 'create new note from note number 39' do
            expect(note2.step).to eq :D
            expect(note2.alter).to eq 1
            expect(note2.octave).to eq 3
        end
        let(:note3) { MusicalScore::Element::Pitch.new_note_number(71)}
        it 'create new note from note number 71' do
            expect(note3.step).to eq :B
            expect(note3.alter).to eq 0
            expect(note3.octave).to eq 5
        end
    end
    describe 'note_number' do
        let(:pitch) { MusicalScore::Element::Pitch.new(:C, 0, 3) }
        it 'C3 returns correct note number' do
            expect(pitch.note_number).to eq 36
        end
        let(:pitch_d) { MusicalScore::Element::Pitch.new(:D, 1, 3) }
        it 'D#3 returns correct note number' do
            expect(pitch_d.note_number).to eq 39
        end
    end
end