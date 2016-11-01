require 'spec_helper'

describe MusicalScore::IO do
    describe 'import' do
        it do
            allow(MusicalScore::IO).to receive(:import_xml)
            MusicalScore::IO.import("hoge.xml")
            expect(MusicalScore::IO).to have_received(:import_xml).once
        end

        it do
            expect{ MusicalScore::IO.import("hoge") }.to raise_error(MusicalScore::InvalidFileType)
        end
        it do
            expect{ MusicalScore::IO.import("hoge.jpg") }.to raise_error(MusicalScore::InvalidFileType)
        end
    end
end