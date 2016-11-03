require 'spec_helper'

describe MusicalScore::Measures do
    describe 'initialize' do
        it 'success case' do
            measure_array = create_measures(3)
            measures      = MusicalScore::Measures.new(measure_array)
            expect(measures.measures).to match(measure_array)
        end
    end
end
