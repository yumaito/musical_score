require 'spec_helper'

describe MusicalScore::Element::Clef do
    describe 'initialize' do
        let(:clef) { MusicalScore::Element::Clef.new(:G)}
        it 'success case' do
            expect(clef.sign).to eq :G
            expect(clef.line).to eq 0
            expect(clef.clef_octave_change).to eq 0
        end

        it 'raise error' do
            expect{ MusicalScore::Element::Clef.new(:D)}.to raise_error(MusicalScore::InvalidClefSign)
        end
    end
end