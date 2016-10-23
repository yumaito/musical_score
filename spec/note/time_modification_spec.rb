require 'spec_helper'

describe MusicalScore::Note::TimeModification do
    describe 'initialize' do
        let(:time_modification) { MusicalScore::Note::TimeModification.new(3, 2) }
        it 'success case' do
            expect(time_modification.actual_notes).to eq 3
            expect(time_modification.normal_notes).to eq 2
        end
    end
end