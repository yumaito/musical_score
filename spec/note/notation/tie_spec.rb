require 'spec_helper'

describe MusicalScore::Note::Notation::Tie do
    describe 'initialize' do
        let(:tie) { MusicalScore::Note::Notation::Tie.new(:start) }
        it 'success case' do
            expect(tie.type).to eq :start
        end

        it 'error case' do
            expect{ MusicalScore::Note::Notation::Tie.new(:hoge)}.to raise_error(ArgumentError)
        end
    end
end