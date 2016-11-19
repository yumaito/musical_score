require 'spec_helper'

describe MusicalScore::Location do
    describe 'initialize' do
        it do
            location = MusicalScore::Location.new(1, Rational(0))
            expect(location).to have_attributes(measure_number: 1, location: Rational(0))
        end
    end
end