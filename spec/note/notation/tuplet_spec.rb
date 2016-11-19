require 'spec_helper'

describe MusicalScore::Note::Notation::Tuplet do
    describe 'initialize' do
        it 'success case' do
            tuplet = MusicalScore::Note::Notation::Tuplet.new(:start)
            expect(tuplet).to have_attributes(type: :start)
        end

        it 'error case' do
            expect{ MusicalScore::Note::Notation::Tuplet.new(:continue) }.to raise_error(ArgumentError)
        end
    end
end