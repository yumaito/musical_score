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

    describe 'create_by_xml' do
        let(:dummy_identification_xml) {
            '<identification>
    <creator type="composer">Ludwig van Beethoven</creator>
    <encoding>
      <software>Finale 2012 for Windows</software>
      <software>Dolet Light for Finale 2012</software>
      <encoding-date>2012-09-06</encoding-date>
      <supports attribute="new-system" element="print" type="yes" value="yes"/>
      <supports attribute="new-page" element="print" type="yes" value="yes"/>
    </encoding>
  </identification>'
        }
        let(:no_creator) {
            '<identification>
    <encoding>
      <software>Finale 2012 for Windows</software>
      <software>Dolet Light for Finale 2012</software>
      <encoding-date>2012-09-06</encoding-date>
      <supports attribute="new-system" element="print" type="yes" value="yes"/>
      <supports attribute="new-page" element="print" type="yes" value="yes"/>
    </encoding>
  </identification>'
        }
        it do
            xml = dummy_xml(dummy_identification_xml)
            identification = MusicalScore::Score::Identification::Identification.create_by_xml(xml.elements["//identification"])
            expect(identification.creators[0].name).to eq "Ludwig van Beethoven"
            expect(identification.encoding.supports).to match(['print', 'print'])
        end
        it do
            xml = dummy_xml(no_creator)
            identification = MusicalScore::Score::Identification::Identification.create_by_xml(xml.elements["//identification"])
            expect(identification.creators).to match([])
            expect(identification.encoding.supports).to match(['print', 'print'])
        end
    end
end
