require 'spec_helper'

describe MusicalScore::Note::TimeModification do
    describe 'initialize' do
        it 'success case' do
            time_modification = MusicalScore::Note::TimeModification.new(3, 2)
            expect(time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
        end
    end
end