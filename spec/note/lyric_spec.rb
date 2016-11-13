require 'spec_helper'

describe MusicalScore::Note::Lyric do
    describe 'initialize' do
        it 'success case' do
            lyric = MusicalScore::Note::Lyric.new('lyric', :single)
            expect(lyric).to have_attributes(text: 'lyric', syllabic: :single, is_extend: false)
        end

        it 'raise InvalidSyllabic' do
            expect{ MusicalScore::Note::Lyric.new('lyric', :one) }.to raise_error(ArgumentError)
        end
    end

    let(:dummy) {
        '<lyric number="1">
    <syllabic>single</syllabic>
    <text>will</text>
</lyric>'
}
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy)
            lyric = MusicalScore::Note::Lyric.create_by_xml(xml.elements["lyric"])
            expect(lyric).to have_attributes(text: 'will', syllabic: :single, is_extend: false)
        end
    end
    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy)
            lyric = MusicalScore::Note::Lyric.create_by_xml(xml.elements["lyric"])
            expect(format_xml(lyric.export_xml(1))).to eq format_xml(xml.elements["lyric"])
        end
    end
end
