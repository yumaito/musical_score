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

    let(:dummy_creator_xml) {
        '<creator type="composer">Ludwig van Beethoven</creator>'
    }
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy_creator_xml)
            creator = MusicalScore::Score::Identification::Creator.create_by_xml(xml.elements["//creator"])
            expect(creator).to have_attributes(name: "Ludwig van Beethoven", type: :composer)
        end
    end

    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy_creator_xml)
            creator = MusicalScore::Score::Identification::Creator.create_by_xml(xml.elements["//creator"])
            expect(format_xml(creator.export_xml)).to eq format_xml(xml.elements["//creator"])
        end
    end
end
