require 'spec_helper'

describe MusicalScore::Element::Attribute do
    describe 'initialize' do
        let(:attribute) {
            MusicalScore::Element::Attribute.new do |attr|
                attr.divisions = 24
                attr.clef = MusicalScore::Element::Clef.new(:F)
                attr.key = MusicalScore::Element::Key.new(4, :major)
                attr.time = MusicalScore::Element::Time.new(4, 4)
            end
        }
        it 'success initializing' do
            expect(attribute.divisions).to eq 24
            expect(attribute.clef.sign).to eq :F
            expect(attribute.key.fifths).to eq 4
            expect(attribute.time.to_s).to eq '4/4'
            expect(attribute.instruments).to eq 'Piano'
        end
        let(:attribute_guitar) {
            MusicalScore::Element::Attribute.new do |attr|
                attr.divisions = 24
                attr.clef = MusicalScore::Element::Clef.new(:F)
                attr.key = MusicalScore::Element::Key.new(4, :major)
                attr.time = MusicalScore::Element::Time.new(4, 4)
                attr.instruments = 'Guitar'
            end
        }
        it 'instruments is guitar' do
            expect(attribute_guitar.instruments).to eq 'Guitar'
        end
    end
end