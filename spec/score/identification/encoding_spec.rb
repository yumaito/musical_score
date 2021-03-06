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

    let(:dummy_encoding_xml) {
        '<encoding>
    <software>Finale 2012 for Windows</software>
    <software>Dolet Light for Finale 2012</software>
    <encoding-date>2012-09-06</encoding-date>
    <supports type="yes" element="print"/>
    <supports type="yes" element="print"/>
</encoding>'
    }
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy_encoding_xml)
            encoding = MusicalScore::Score::Identification::Encoding.create_by_xml(xml.elements["//encoding"])
            encoding_date = Time.local(2012, 9, 6)
            expect(encoding.encoding_date).to eq encoding_date
            expect(encoding.encoding_description).to eq ""
            expect(encoding.softwares).to match(['Finale 2012 for Windows', 'Dolet Light for Finale 2012'])
            expect(encoding.supports).to match(['print', 'print'])
        end
    end

    describe 'create_by_hash' do
        it do
            doc      = dummy_xml_hash(dummy_encoding_xml)
            encoding = MusicalScore::Score::Identification::Encoding.create_by_hash(doc)
            encoding_date = Time.local(2012, 9, 6)
            expect(encoding.encoding_date).to eq encoding_date
            expect(encoding.encoding_description).to eq ""
            expect(encoding.softwares).to match(['Finale 2012 for Windows', 'Dolet Light for Finale 2012'])
            expect(encoding.supports).to match(['print', 'print'])
        end
    end

    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy_encoding_xml)
            encoding = MusicalScore::Score::Identification::Encoding.create_by_xml(xml.elements["//encoding"])
            expect(format_xml(encoding.export_xml)).to eq format_xml(xml.elements["//encoding"])
        end
    end
end
