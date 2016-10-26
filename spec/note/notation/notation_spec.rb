require 'spec_helper'

describe MusicalScore::Note::Notation::Notation do
    describe 'initialize' do
        it 'success initializing' do
            notation = MusicalScore::Note::Notation::Notation.new(
                    articulation: :accent,
                    dynamics: :mf,
                    tie: MusicalScore::Note::Notation::Tie.new(:start),
                    tuplet: MusicalScore::Note::Notation::Tuplet.new(:start)
                )
            expect(notation.articulation).to eq :accent
            expect(notation.dynamics).to eq :mf
            expect(notation.tie.type).to eq :start
            expect(notation.tuplet.type).to eq :start
        end

        it 'some attributes are nil' do
            notation_with_some_params = MusicalScore::Note::Notation::Notation.new(:articulation => :tenuto)
            expect(notation_with_some_params).to have_attributes(articulation: :tenuto, dynamics: nil, tie: nil, tuplet: nil)
        end

        it 'all attributes are nil' do
            notation_without_params = MusicalScore::Note::Notation::Notation.new
            expect(notation_without_params).to have_attributes(articulation: nil, dynamics: nil, tie: nil, tuplet: nil)
        end

        it 'non-articulation argument' do
            expect{ MusicalScore::Note::Notation::Notation.new(articulation: :hoge)}.to raise_error(ArgumentError)
        end
    end
end