require 'spec_helper'

describe MusicalScore::Note::Type do
    describe 'initialize' do
        let(:type) { MusicalScore::Note::Type.new("eighth")}
        it 'success case' do
            expect(type.size).to eq "eighth"
        end

        it 'error case' do
            expect{ MusicalScore::Note::Type.new("hoge")}.to raise_error(ArgumentError)
        end
    end
end