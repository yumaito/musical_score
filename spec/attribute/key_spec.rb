require 'spec_helper'

describe MusicalScore::Attribute::Key do
    describe 'initialize' do
        it 'create key object' do
            key = MusicalScore::Attribute::Key.new(3, :major)
            expect(key).to have_attributes(fifths: 3, mode: :major)
        end

        it 'raise ArgumentError' do
            expect{ MusicalScore::Attribute::Key.new(8, :major)}.to raise_error(ArgumentError)
        end
        it 'raise InvalidKeyMode' do
            expect{ MusicalScore::Attribute::Key.new(6, :hoge)}.to raise_error(ArgumentError)
        end
    end

    describe 'altered_pitches' do
        it 'C major' do
            c_major = MusicalScore::Attribute::Key.new(0, :major)
            altered_pitches = c_major.tonic_key_and_altered_pitches
            expect(altered_pitches[:major_pitch]).to eq MusicalScore::Note::Pitch.new(:C)
            expect(altered_pitches[:minor_pitch]).to eq MusicalScore::Note::Pitch.new(:A)
            expect(altered_pitches[:altered_pitches].size).to eq 0
        end

        it 'E major' do
            e_major = MusicalScore::Attribute::Key.new(4, :major)
            altered_pitches_e = e_major.tonic_key_and_altered_pitches
            expect(altered_pitches_e[:major_pitch]).to eq MusicalScore::Note::Pitch.new(:E)
            expect(altered_pitches_e[:minor_pitch]).to eq MusicalScore::Note::Pitch.new(:C, 1)
            expect(altered_pitches_e[:altered_pitches]).to match([
                MusicalScore::Note::Pitch.new(:F),
                MusicalScore::Note::Pitch.new(:C),
                MusicalScore::Note::Pitch.new(:G),
                MusicalScore::Note::Pitch.new(:D)
            ])
        end

        it 'C sharp major' do
            c_sharp_major = MusicalScore::Attribute::Key.new(7, :major)
            altered_pitches_cs = c_sharp_major.tonic_key_and_altered_pitches
            expect(altered_pitches_cs[:major_pitch]).to eq MusicalScore::Note::Pitch.new(:C, 1)
            expect(altered_pitches_cs[:minor_pitch]).to eq MusicalScore::Note::Pitch.new(:A, 1)
            expect(altered_pitches_cs[:altered_pitches]).to match([
                MusicalScore::Note::Pitch.new(:F),
                MusicalScore::Note::Pitch.new(:C),
                MusicalScore::Note::Pitch.new(:G),
                MusicalScore::Note::Pitch.new(:D),
                MusicalScore::Note::Pitch.new(:A),
                MusicalScore::Note::Pitch.new(:E),
                MusicalScore::Note::Pitch.new(:B),
            ])
        end

        it 'E flat major' do
            e_flat_major = MusicalScore::Attribute::Key.new(-3, :major)
            altered_pitches_ef = e_flat_major.tonic_key_and_altered_pitches
            expect(altered_pitches_ef[:major_pitch]).to eq MusicalScore::Note::Pitch.new(:E, -1)
            expect(altered_pitches_ef[:minor_pitch]).to eq MusicalScore::Note::Pitch.new(:C)
            expect(altered_pitches_ef[:altered_pitches]).to match([
                MusicalScore::Note::Pitch.new(:B),
                MusicalScore::Note::Pitch.new(:E),
                MusicalScore::Note::Pitch.new(:A),
            ])
        end

        it 'G flat major' do
            g_flat_major = MusicalScore::Attribute::Key.new(-6, :major)
            altered_pitches_gf = g_flat_major.tonic_key_and_altered_pitches
            expect(altered_pitches_gf[:major_pitch]).to eq MusicalScore::Note::Pitch.new(:G, -1)
            expect(altered_pitches_gf[:minor_pitch]).to eq MusicalScore::Note::Pitch.new(:E, -1)
            expect(altered_pitches_gf[:altered_pitches]).to match([
                MusicalScore::Note::Pitch.new(:B),
                MusicalScore::Note::Pitch.new(:E),
                MusicalScore::Note::Pitch.new(:A),
                MusicalScore::Note::Pitch.new(:D),
                MusicalScore::Note::Pitch.new(:G),
                MusicalScore::Note::Pitch.new(:C),
            ])
        end
    end

    describe 'create_by_xml' do
        let(:dummy_key_xml) {
            '<key>
          <fifths>-3</fifths>
          <mode>major</mode>
        </key>'
        }
        it do
            xml = dummy_xml(dummy_key_xml)
            key = MusicalScore::Attribute::Key.create_by_xml(xml.elements["key"])
            expect(key).to have_attributes(fifths: -3, mode: :major)
        end
    end
end