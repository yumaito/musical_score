require 'spec_helper'

describe MusicalScore::Measures do
    describe 'initialize' do
        it 'success case' do
            measure_array = create_measures(3)
            measures      = MusicalScore::Measures.new(measure_array)
            expect(measures.measures).to match(measure_array)
        end
    end

    describe 'set_location' do
        it do
            measure_array = create_measures(2)
            measures      = MusicalScore::Measures.new(measure_array)
            measures.set_location

            measures.each do |measure|
                number = measure.number
                measure.notes.each_with_index do |note, index|
                    location = (number - 1) * 4 * 4 + index * 4
                    expect(note.location.measure_number).to eq number
                    expect(note.location.location).to eq Rational(location)
                end
            end
        end
    end
end
