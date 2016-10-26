require 'spec_helper'

describe MusicalScore::Attribute::Attribute do
    describe 'initialize' do
        it 'success initializing' do
            attribute = MusicalScore::Attribute::Attribute.new(
                divisions: 24,
                clef: MusicalScore::Attribute::Clef.new(:F),
                key: MusicalScore::Attribute::Key.new(4, :major),
                time: MusicalScore::Attribute::Time.new(6, 8),
            )
            expect(attribute.divisions).to eq 24
            expect(attribute.clef.sign).to eq :F
            expect(attribute.key.fifths).to eq 4
            expect(attribute.time.to_s).to eq '6/8'
            expect(attribute.instruments).to eq 'Piano'
        end

        it 'omit args is set default' do
            ommit_arg = MusicalScore::Attribute::Attribute.new(
                divisions: 24,
                key: MusicalScore::Attribute::Key.new(4, :major),
                time: MusicalScore::Attribute::Time.new(3, 4),
            )
            expect(ommit_arg.divisions).to eq 24
            expect(ommit_arg.clef.sign).to eq :G
            expect(ommit_arg.key.fifths).to eq 4
            expect(ommit_arg.time.to_s).to eq '3/4'
            expect(ommit_arg.instruments).to eq 'Piano'
        end

        it 'instruments is guitar' do
            attribute_guitar = MusicalScore::Attribute::Attribute.new(
                divisions: 24,
                clef: MusicalScore::Attribute::Clef.new(:F),
                key: MusicalScore::Attribute::Key.new(4, :major),
                time: MusicalScore::Attribute::Time.new(4, 4),
                instruments: 'Guitar'
            )
            expect(attribute_guitar.instruments).to eq 'Guitar'
        end
    end
end