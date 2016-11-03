require 'spec_helper'
describe MusicalScore::Score::Identification::Encoding do
    describe 'initialize' do
        it 'success case' do
            now = Time.now
            encoding = MusicalScore::Score::Identification::Encoding.new(
                now,
                "hogehoge",
                ["foo"],
                ["bar"],
            )
            expect(encoding).to have_attributes(
                encoding_date: now,
                encoding_description: "hogehoge",
                softwares: ["foo"],
                supports: ["bar"],
            )
        end
    end
end
