require 'spec_helper'

describe MusicalScore::Part::Part do
    describe 'initialize' do
        it 'success case' do
            measures = MusicalScore::Measures.new(create_measures(4))
            part     = MusicalScore::Part::Part.new(measures)
            expect(part).to have_attributes(measures: measures)
        end
    end

    describe 'export_xml' do
        let(:dummy_part_xml) {
            '<score-part id="P1">
    <part-name>Trumpet in Bb</part-name>
    <part-abbreviation>Bb Tpt.</part-abbreviation>
</score-part>'
        }
        it do
            xml  = dummy_xml(dummy_part_xml)
            part = MusicalScore::Score::Part::Part.new("Trumpet in Bb", "Bb Tpt.")
            expect(format_xml(part.export_xml(1))).to eq format_xml(xml.elements["score-part"])
        end
    end
end
