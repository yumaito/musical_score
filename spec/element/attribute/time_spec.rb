require 'spec_helper'

describe MusicalScore::Element::Attribute::Time do
    describe 'initialize' do
        let(:time) { MusicalScore::Element::Attribute::Time.new(6, 8)}
        it 'success case' do
            expect(time.beats).to eq 6
            expect(time.beat_type).to eq 8
        end
    end
    describe 'to_s' do
        let(:time) { MusicalScore::Element::Attribute::Time.new(6, 8)}
        it 'returns 6 / 8' do
            expect(time.to_s).to eq '6 / 8'
        end
    end
end