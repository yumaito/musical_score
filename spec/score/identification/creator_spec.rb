require 'spec_helper'

describe MusicalScore::Score::Identification::Creator do
    describe 'initialize' do
        it 'success case' do
            creator = MusicalScore::Score::Identification::Creator.new("hoge", :composer)
            expect(creator).to have_attributes(name: "hoge", type: :composer)
        end
        it 'error case' do
            expect{ MusicalScore::Score::Identification::Creator.new("hoge", :singer) }.to raise_error(ArgumentError)
        end
    end
end
