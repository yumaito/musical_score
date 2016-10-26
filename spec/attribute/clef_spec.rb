require 'spec_helper'

describe MusicalScore::Attribute::Clef do
    describe 'initialize' do
        it 'success case' do
            clef = MusicalScore::Attribute::Clef.new(:G)
            expect(clef).to have_attributes(sign: :G, line: 0, clef_octave_change: 0)
        end

        it 'raise error' do
            expect{ MusicalScore::Attribute::Clef.new(:D)}.to raise_error(ArgumentError)
        end
    end
end