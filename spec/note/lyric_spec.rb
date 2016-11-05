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
    describe 'create_by_xml' do
        let(:dummy) {
            '<lyric default-y="-73" name="verse" number="1">
          <syllabic>single</syllabic>
          <text>will</text>
        </lyric>'
        }
        it do
            xml = dummy_xml(dummy)
            lyric = MusicalScore::Note::Lyric.create_by_xml(xml.elements["lyric"])
            expect(lyric).to have_attributes(text: 'will', syllabic: :single, is_extend: false)
        end
    end
end
