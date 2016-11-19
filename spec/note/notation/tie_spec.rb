require 'spec_helper'

describe MusicalScore::Note::Notation::Tie do
    describe 'initialize' do
        it 'success case' do
            tie = MusicalScore::Note::Notation::Tie.new(:start)
            expect(tie).to have_attributes(type: :start)
        end

        it 'error case' do
            expect{ MusicalScore::Note::Notation::Tie.new(:hoge)}.to raise_error(ArgumentError)
        end
    end
end