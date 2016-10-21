require 'spec_helper'

describe MusicalScore::Element::Attribute::Clef do
    describe 'initialize' do
        let(:clef) { MusicalScore::Element::Attribute::Clef.new(:G)}
        it 'valid case' do
            expect(clef.sign).to eq :G
            expect(clef.line).to eq 0
            expect(clef.clef_octave_change).to eq 0
        end

        it 'raise error' do
            expect{ MusicalScore::Element::Attribute::Clef.new(:D)}.to raise_error(MusicalScore::InvalidClefSign)
        end
    end
end