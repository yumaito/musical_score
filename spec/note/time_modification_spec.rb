require 'spec_helper'

describe MusicalScore::Note::TimeModification do
    describe 'initialize' do
        it 'success case' do
            time_modification = MusicalScore::Note::TimeModification.new(3, 2)
            expect(time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
        end
    end

    let(:dummy) {
        '<time-modification>
    <actual-notes>3</actual-notes>
    <normal-notes>2</normal-notes>
</time-modification>'
    }
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy)
            time_modification = MusicalScore::Note::TimeModification.create_by_xml(xml.elements["time-modification"])
            expect(time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
        end
    end
    describe 'create_by_hash' do
        it do
            doc = dummy_xml_hash(dummy)
            time_modification = MusicalScore::Note::TimeModification.create_by_hash(doc)
            expect(time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
        end
    end
    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy)
            time_modification = MusicalScore::Note::TimeModification.create_by_xml(xml.elements["time-modification"])
            expect(format_xml(time_modification.export_xml)).to eq format_xml(xml.elements["time-modification"])
        end
    end
end
