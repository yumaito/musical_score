require 'spec_helper'

describe MusicalScore::Attribute::Clef do
    describe 'initialize' do
        it 'success case' do
            clef = MusicalScore::Attribute::Clef.new(:G)
            expect(clef).to have_attributes(sign: :G, line: 0, clef_octave_change: 0)
        end

        it 'raise error' do
            expect{ MusicalScore::Attribute::Clef.new(:D)}.to raise_error(ArgumentError)
        end
    end

    let(:dummy_clef_xml) {
        '<clef>
    <sign>G</sign>
    <line>2</line>
    <clef-octave-change>-1</clef-octave-change>
</clef>'
    }
    let(:dummy_clef_xml_g) {
        '<clef>
    <sign>G</sign>
    <line>2</line>
</clef>'
    }
    describe 'create_by_xml' do
        it do
            xml = dummy_xml(dummy_clef_xml)
            clef = MusicalScore::Attribute::Clef.create_by_xml(xml.elements["clef"])
            expect(clef).to have_attributes(sign: :G, line: 2, clef_octave_change: -1 )
        end
        it do
            xml = dummy_xml(dummy_clef_xml_g)
            clef = MusicalScore::Attribute::Clef.create_by_xml(xml.elements["clef"])
            expect(clef).to have_attributes(sign: :G, line: 2, clef_octave_change: 0)
        end
    end

    describe 'export_xml' do
        it do
            xml = dummy_xml(dummy_clef_xml)
            clef = MusicalScore::Attribute::Clef.create_by_xml(xml.elements["clef"])
            expect(format_xml(clef.export_xml)).to eq format_xml(xml.elements["clef"])
        end

        it do
            xml = dummy_xml(dummy_clef_xml_g)
            clef = MusicalScore::Attribute::Clef.create_by_xml(xml.elements["clef"])
            expect(format_xml(clef.export_xml)).to eq format_xml(xml.elements["clef"])
        end
    end
end