require 'spec_helper'

describe MusicalScore::Note::Lyric do
    describe 'initialize' do
        let(:lyric) { MusicalScore::Note::Lyric.new('lyric', :single) }
        it 'success case' do
            expect(lyric.text).to eq 'lyric'
            expect(lyric.syllabic).to eq :single
            expect(lyric.is_extend).to be_falsy
        end

        it 'raise InvalidSyllabic' do
            expect{ MusicalScore::Note::Lyric.new('lyric', :one) }.to raise_error(ArgumentError)
        end
    end
end