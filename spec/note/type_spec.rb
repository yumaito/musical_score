require 'spec_helper'

describe MusicalScore::Note::Type do
    describe 'initialize' do
        it 'success case' do
            type = MusicalScore::Note::Type.new("eighth")
            expect(type).to have_attributes(size: "eighth")
        end

        it 'error case' do
            expect{ MusicalScore::Note::Type.new("hoge")}.to raise_error(ArgumentError)
        end
    end
end