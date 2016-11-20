require 'spec_helper'

describe MusicalScore::IO do
    describe 'import' do
        it do
            allow(MusicalScore::IO).to receive(:import_xml_via_hash)
            MusicalScore::IO.import("hoge.xml")
            expect(MusicalScore::IO).to have_received(:import_xml_via_hash).once
        end

        it do
            expect{ MusicalScore::IO.import("hoge") }.to raise_error(MusicalScore::InvalidFileType)
        end
        it do
            expect{ MusicalScore::IO.import("hoge.jpg") }.to raise_error(MusicalScore::InvalidFileType)
        end

        it 'benchmark' do
            Benchmark.bmbm 10 do |r|
                r.report "import xml" do
                    path = File.expand_path('../../sample/grandfathers_clock.xml', __FILE__)
                    MusicalScore::IO::import(path)
                end
            end
        end
    end
    describe 'export' do
        it do
            allow(MusicalScore::IO).to receive(:export_xml)
            part      = create_partwise_part(4)
            part_list = MusicalScore::Score::Part::Part.new("Guitar", "Gt.")
            score     = MusicalScore::Score::Score.new(
                credits: [ "hoge" ],
                part_list: [ part_list ],
                parts: [ part ],
            )
            path = File.expand_path('../../sample/output.xml', __FILE__)
            MusicalScore::IO::export_xml(path, score)
        end
    end
end
