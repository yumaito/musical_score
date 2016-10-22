require 'spec_helper'

describe MusicalScore::Element::Key do
    describe 'initialize' do
        let(:key) { MusicalScore::Element::Key.new(3, :major) }
        it 'create key object' do
            expect(key.fifths).to eq 3
            expect(key.mode).to eq :major
        end

        it 'raise ArgumentError' do
            expect{ MusicalScore::Element::Key.new(8, :major)}.to raise_error(ArgumentError)
        end
        it 'raise InvalidKeyMode' do
            expect{ MusicalScore::Element::Key.new(6, :hoge)}.to raise_error(MusicalScore::InvalidKeyMode)
        end
    end
end