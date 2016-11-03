require 'spec_helper'

describe MusicalScore::Score::Score do
    describe 'initialize' do
        it 'initialize' do
            part      = create_partwise_part(4)
            part_list = MusicalScore::Score::Part::Part.new("Guitar", "Gt.")
            score     = MusicalScore::Score::Score.new(
                part_list: [ part_list ],
                parts: [ part ],
            )
            expect(score).to have_attributes(part_list: [ part_list ], parts: [ part ])
        end
    end
end
