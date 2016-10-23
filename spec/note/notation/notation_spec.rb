require 'spec_helper'

describe MusicalScore::Note::Notation::Notation do
    describe 'initialize' do
        let(:notation) {
            MusicalScore::Note::Notation::Notation.new(
                articulation: :accent,
                dynamics: :mf,
                tie: MusicalScore::Note::Notation::Tie.new(:start),
                tuplet: MusicalScore::Note::Notation::Tuplet.new(:start)
            )
        }
        it 'success initializing' do
            expect(notation.articulation).to eq :accent
            expect(notation.dynamics).to eq :mf
            expect(notation.tie.type).to eq :start
            expect(notation.tuplet.type).to eq :start
        end

        let(:notation_with_some_params) {
            MusicalScore::Note::Notation::Notation.new(:articulation => :tenuto)
        }
        it 'some attributes are nil' do
            expect(notation_with_some_params.articulation).to eq :tenuto
            expect(notation_with_some_params.dynamics).to eq nil
            expect(notation_with_some_params.tie).to eq nil
            expect(notation_with_some_params.tuplet).to eq nil
        end

        let(:notation_without_params) {
            MusicalScore::Note::Notation::Notation.new
        }
        it 'all attributes are nil' do
            expect(notation_without_params.articulation).to eq nil
            expect(notation_without_params.dynamics).to eq nil
            expect(notation_without_params.tie).to eq nil
            expect(notation_without_params.tuplet).to eq nil
        end

        it 'non-articulation argument' do
            expect{ MusicalScore::Note::Notation::Notation.new(articulation: :hoge)}.to raise_error(ArgumentError)
        end
    end
end