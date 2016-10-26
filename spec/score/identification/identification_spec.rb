require 'spec_helper'
describe MusicalScore::Score::Identification do
    describe 'initialize' do
        it 'success case' do
            now = Time.now
            creator  = MusicalScore::Score::Identification::Creator.new("hoge", :composer)
            encoding = MusicalScore::Score::Identification::Encoding.new("music", now, "hogehoge", ["foo"], ["bar"])
            identification = MusicalScore::Score::Identification::Identification.new(
                [creator],
                [encoding],
            )
            expect(identification.creators[0].name).to eq "hoge"
            expect(identification.encodings[0].type).to eq "music"
        end
    end
end
