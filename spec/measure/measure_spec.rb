require 'spec_helper'

describe MusicalScore::Measure::Measure do
    describe 'initialize' do
        it 'success case' do
            notes   = MusicalScore::Notes.new(create_notes_with_rest(6))
            part    = MusicalScore::Measure::Part.new(notes)
            measure = MusicalScore::Measure::Measure.new([ part ])

            expect(measure).to have_attributes(parts: [ part ])
        end
    end
end