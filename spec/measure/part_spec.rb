require 'spec_helper'

describe MusicalScore::Measure::Part do
    describe 'initialize' do
        it 'success case' do
            attribute = MusicalScore::Attribute::Attribute.new(divisions: 24)
            notes     = MusicalScore::Notes.new(create_notes_with_rest(6))
            part      = MusicalScore::Measure::Part.new(notes, attribute)
            expect(part).to have_attributes(notes: notes, attribute: attribute)
        end
    end
end