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
end