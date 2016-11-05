require 'spec_helper'

describe MusicalScore::Part::Measure do
    describe 'initialize' do
        it 'success case' do
            attribute = MusicalScore::Attribute::Attribute.new(divisions: 24)
            notes     = MusicalScore::Notes.new(create_notes_with_rest(6))
            measure   = MusicalScore::Part::Measure.new(notes, 0, attribute)
            expect(measure).to have_attributes(notes: notes, attribute: attribute, number: 0)
        end
    end
end
