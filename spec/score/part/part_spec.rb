require 'spec_helper'
describe MusicalScore::Score::Part::Part do
    describe 'initialize' do
        it 'success case' do
            part = MusicalScore::Score::Part::Part.new("Guitar", "Gt.")
            expect(part).to have_attributes(part_name: "Guitar", part_abbreviation: "Gt.")
        end
    end
end