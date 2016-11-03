require 'spec_helper'
describe MusicalScore::Score::Identification do
    describe 'initialize' do
        it 'success case' do
            now = Time.now
            creator  = MusicalScore::Score::Identification::Creator.new("hoge", :composer)
            encoding = MusicalScore::Score::Identification::Encoding.new(now, "hogehoge", ["foo"], ["bar"])
            identification = MusicalScore::Score::Identification::Identification.new(
                [creator],
                encoding,
            )
            expect(identification.creators[0].name).to eq "hoge"
            expect(identification.encoding.encoding_description).to eq "hogehoge"
        end
    end
end
