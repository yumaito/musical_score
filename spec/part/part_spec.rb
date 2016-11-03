require 'spec_helper'

describe MusicalScore::Part::Part do
    describe 'initialize' do
        it 'success case' do
            measures = MusicalScore::Measures.new(create_measures(4))
            part     = MusicalScore::Part::Part.new(measures)
            expect(part).to have_attributes(measures: measures)
        end
    end
end
