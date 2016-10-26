require 'spec_helper'

describe MusicalScore::Attribute::Time do
    let(:time) { MusicalScore::Attribute::Time.new(6, 8)}
    describe 'initialize' do
        it 'success case' do
            expect(time.beats).to eq 6
            expect(time.beat_type).to eq 8
        end
    end
    describe 'to_s' do
        it 'returns 6/8' do
            expect(time.to_s).to eq '6/8'
        end
    end
end