require 'spec_helper'

describe MusicalScore::Note::Notation::Tuplet do
    describe 'initialize' do
        let(:tuplet) { MusicalScore::Note::Notation::Tuplet.new(:start) }
        it 'success case' do
            expect(tuplet.type).to eq :start
        end

        it 'error case' do
            expect{ MusicalScore::Note::Notation::Tuplet.new(:continue) }.to raise_error(ArgumentError)
        end
    end
end