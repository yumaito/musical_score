require 'spec_helper'

describe MusicalScore::Attribute::Clef do
    describe 'initialize' do
        let(:clef) { MusicalScore::Attribute::Clef.new(:G)}
        it 'success case' do
            expect(clef.sign).to eq :G
            expect(clef.line).to eq 0
            expect(clef.clef_octave_change).to eq 0
        end

        it 'raise error' do
            expect{ MusicalScore::Attribute::Clef.new(:D)}.to raise_error(ArgumentError)
        end
    end
end