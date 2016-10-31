require 'spec_helper'

describe MusicalScore::Score::Score do
    describe 'initialize' do
        it 'initialize' do
            measures = MusicalScore::Measures.new(create_masures(4))
            part     = MusicalScore::Score::Part::Part.new("Guitar", "Gt.")
            score    = MusicalScore::Score::Score.new(
                part_lit: [ part ],
                measures: measures,
            )
            expect(score).to have_attributes(part_lit: [part], measures: measures)
        end
    end
end