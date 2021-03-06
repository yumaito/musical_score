require 'spec_helper'

describe MusicalScore::Note::Note do
    describe 'initialize' do
        it 'rest note' do
            rest = MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 0,
                rest: true,
                type: MusicalScore::Note::Type.new("quarter"),
            )
            expect(rest.duration).to eq 4
            expect(rest.tie).to eq nil
            expect(rest.lyric).to eq nil
            expect(rest.pitch).to eq nil
            expect(rest.rest).to be_truthy
            expect(rest.type.size).to eq "quarter"
        end

        it 'pitch note' do
            note = MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 1,
                lyric: MusicalScore::Note::Lyric.new("all", :single),
                pitch: MusicalScore::Note::Pitch.new(:C),
                type: MusicalScore::Note::Type.new("eighth")
            )
            expect(note.duration).to eq 4
            expect(note.tie).to eq nil
            expect(note.dot).to eq 1
            expect(note.lyric.text).to eq "all"
            expect(note.rest).to be_falsey
            expect(note.type.size).to eq "eighth"
            expect(note.actual_duration).to eq Rational(4, 1)
        end

        it 'set actual duration' do
            triplet_note = MusicalScore::Note::Note.new(
                duration: 2,
                pitch: MusicalScore::Note::Pitch.new(:C),
                type: MusicalScore::Note::Type.new("eighth"),
                time_modification: MusicalScore::Note::TimeModification.new(3, 2)
            )
            expect(triplet_note.actual_duration).to eq Rational(4, 3)
        end

        let(:pitch_rest) {
            MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                pitch: MusicalScore::Note::Pitch.new(:C),
                rest: true,
                type: MusicalScore::Note::Type.new("16th"),
            )
        }
        it 'raise error' do
            expect{ pitch_rest }.to raise_error(ArgumentError)
        end

        let(:dummy) {
            '<note>
    <pitch>
        <step>B</step>
        <octave>4</octave>
    </pitch>
    <duration>16</duration>
    <type>eighth</type>
</note>'
        }

        let(:rest) {
            '<note>
    <rest/>
    <duration>4</duration>
    <type>quarter</type>
</note>'
        }

        let(:tie_note) {
            '<note>
    <pitch>
        <step>C</step>
        <octave>5</octave>
    </pitch>
    <duration>16</duration>
    <tie type="stop"/>
    <type>whole</type>
    <notations>
        <tied type="stop"/>
    </notations>
</note>'
        }

        let(:dummy_tuplet) {
            '<note>
    <pitch>
        <step>D</step>
        <octave>5</octave>
    </pitch>
    <duration>4</duration>
    <type>quarter</type>
    <time-modification>
        <actual-notes>3</actual-notes>
        <normal-notes>2</normal-notes>
    </time-modification>
    <notations>
        <tuplet type="start"/>
    </notations>
</note>'
        }

        let(:lyric) {
            '<note>
    <pitch>
        <step>F</step>
        <octave>4</octave>
    </pitch>
    <duration>1</duration>
    <type>eighth</type>
    <lyric number="1">
        <syllabic>single</syllabic>
        <text>I</text>
    </lyric>
</note>'
        }
        describe 'create_by_xml' do

            it 'normal note' do
                xml = dummy_xml(dummy)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(note.pitch.step).to eq :B
                expect(note.duration).to eq 16
                expect(note.type.size).to eq "eighth"
                expect(note.rest).to be_falsey
            end

            it 'rest' do
                xml = dummy_xml(rest)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(note.pitch).to eq nil
                expect(note.rest).to be_truthy
                expect(note.duration).to eq 4
                expect(note.type.size).to eq "quarter"
            end

            it 'tied note' do
                xml = dummy_xml(tie_note)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(note.pitch.step).to eq :C
                expect(note.tie).to eq :stop
            end

            it 'tuplet note' do
                xml = dummy_xml(dummy_tuplet)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(note.pitch.step).to eq :D
                expect(note.time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
                expect(note.notation.tuplet.type).to eq :start
            end

            it 'lyric note' do
                xml = dummy_xml(lyric)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(note.pitch.step).to eq :F
                expect(note.lyric.text).to eq "I"
            end
        end

        describe 'create_by_hash' do

            it 'normal note' do
                doc = dummy_xml_hash(dummy)
                note = MusicalScore::Note::Note.create_by_hash(doc)
                expect(note.pitch.step).to eq :B
                expect(note.duration).to eq 16
                expect(note.type.size).to eq "eighth"
                expect(note.rest).to be_falsey
            end

            it 'rest' do
                doc = dummy_xml_hash(rest)
                note = MusicalScore::Note::Note.create_by_hash(doc)
                expect(note.pitch).to eq nil
                expect(note.rest).to be_truthy
                expect(note.duration).to eq 4
                expect(note.type.size).to eq "quarter"
            end

            it 'tied note' do
                doc = dummy_xml_hash(tie_note)
                note = MusicalScore::Note::Note.create_by_hash(doc)
                expect(note.pitch.step).to eq :C
                expect(note.tie).to eq :stop
            end

            it 'tuplet note' do
                doc = dummy_xml_hash(dummy_tuplet)
                note = MusicalScore::Note::Note.create_by_hash(doc)
                expect(note.pitch.step).to eq :D
                expect(note.time_modification).to have_attributes(actual_notes: 3, normal_notes: 2)
                expect(note.notation.tuplet.type).to eq :start
            end

            it 'lyric note' do
                doc = dummy_xml_hash(lyric)
                note = MusicalScore::Note::Note.create_by_hash(doc)
                expect(note.pitch.step).to eq :F
                expect(note.lyric.text).to eq "I"
            end
        end

        describe 'export_xml' do
            it do
                xml = dummy_xml(dummy)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(format_xml(note.export_xml)).to eq format_xml(xml.elements["note"])
            end
            it 'rest' do
                xml = dummy_xml(rest)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(format_xml(note.export_xml)).to eq format_xml(xml.elements["note"])
            end
            it 'tied note' do
                xml = dummy_xml(tie_note)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(format_xml(note.export_xml)).to eq format_xml(xml.elements["note"])
            end
            it 'tuplet note' do
                xml = dummy_xml(dummy_tuplet)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(format_xml(note.export_xml)).to eq format_xml(xml.elements["note"])
            end

            it 'lyric note' do
                xml = dummy_xml(lyric)
                note = MusicalScore::Note::Note.create_by_xml(xml.elements["note"])
                expect(format_xml(note.export_xml)).to eq format_xml(xml.elements["note"])
            end
        end

        describe 'divide' do
            note = MusicalScore::Note::Note.new(
                duration: 4,
                tie: nil,
                dot: 1,
                lyric: MusicalScore::Note::Lyric.new("all", :single),
                pitch: MusicalScore::Note::Pitch.new(:C),
                type: MusicalScore::Note::Type.new("eighth")
            )
            it 'no argumrnts' do
                divided = note.divide
                expect(divided).to have_attributes(duration: note.duration, pitch: note.pitch, location: note.location)
            end
            it 'divide' do
                note.location = MusicalScore::Location.new(1, Rational(0))
                divided = note.divide(3,1)
                expect(divided[0].duration).to eq 3
                expect(divided[1].duration).to eq 1

                expect(divided[0].pitch).to eq note.pitch
                expect(divided[1].pitch).to eq note.pitch

                expect(divided[0].location).to have_attributes(measure_number: 1, location: Rational(0))
                expect(divided[1].location).to have_attributes(measure_number: 1, location: Rational(3))
                # 念のための確認
                divided[0].lyric.text = "hoge"
                expect(note.lyric).to_not eq divided[0].lyric
            end
        end
    end
end
