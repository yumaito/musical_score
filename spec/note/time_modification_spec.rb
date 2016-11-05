require 'spec_helper'

describe MusicalScore::Note::TimeModification do
    describe 'initialize' do
        it 'success case' do
            time_modification = MusicalScore::Note::TimeModification.new(3, 2)
            expect(time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
        end
    end

    describe 'create_by_xml' do
        let(:dummy) {
            '<time-modification>
          <actual-notes>3</actual-notes>
          <normal-notes>2</normal-notes>
        </time-modification>'
        }
        it do
            xml = dummy_xml(dummy)
            time_modification = MusicalScore::Note::TimeModification.create_by_xml(xml.elements["time-modification"])
            expect(time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
        end
    end
end
