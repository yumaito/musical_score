require 'spec_helper'

describe MusicalScore::Attribute::Time do
    let(:time) { MusicalScore::Attribute::Time.new(6, 8)}
    describe 'initialize' do
        it 'success case' do
            expect(time.beats).to eq 6
            expect(time.beat_type).to eq 8
        end
    end
    describe 'to_s' do
        it 'returns 6/8' do
            expect(time.to_s).to eq '6/8'
        end
    end

    let(:dummy_time_xml) {
        '<time>
    <beats>3</beats>
    <beat-type>4</beat-type>
</time>'
    }
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy_time_xml)
            time = MusicalScore::Attribute::Time.create_by_xml(xml.elements["time"])
            expect(time).to have_attributes(beats: 3, beat_type: 4)
        end
    end

    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy_time_xml)
            time = MusicalScore::Attribute::Time.create_by_xml(xml.elements["time"])
            expect(format_xml(time.export_xml)).to eq format_xml(xml.elements["time"])
        end
    end
end
