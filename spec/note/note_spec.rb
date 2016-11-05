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

        describe 'create_by_xml' do
            let(:dummy) {
                '<note default-x="10">
        <pitch>
          <step>B</step>
          <octave>4</octave>
        </pitch>
        <duration>16</duration>
        <voice>1</voice>
        <type>eighth</type>
        <stem default-y="-55.5">down</stem>
      </note>'
            }

            let(:rest) {
                '<note>
                  <rest/>
                  <duration>4</duration>
                  <voice>1</voice>
                  <type>quarter</type>
                </note>'
            }

            let(:tie_note) {
                '<note default-x="10">
        <pitch>
          <step>C</step>
          <octave>5</octave>
        </pitch>
        <duration>16</duration>
        <tie type="stop"/>
        <voice>1</voice>
        <type>whole</type>
        <notations>
        <tied type="stop"/>
        </notations>
      </note>'
            }

            let(:dummy_tuplet) {
              '<note default-x="117">
        <pitch>
          <step>D</step>
          <octave>5</octave>
        </pitch>
        <duration>4</duration>
        <voice>1</voice>
        <type>quarter</type>
        <time-modification>
          <actual-notes>3</actual-notes>
          <normal-notes>2</normal-notes>
        </time-modification>
        <stem default-y="-45.5">down</stem>
        <notations>
          <tuplet bracket="yes" number="1" placement="above" type="start"/>
        </notations>
      </note>'
            }

            let(:lyric) {
                '<note default-x="80">
        <pitch>
          <step>F</step>
          <octave>4</octave>
        </pitch>
        <duration>1</duration>
        <voice>1</voice>
        <type>eighth</type>
        <stem default-y="15">up</stem>
        <beam number="1">begin</beam>
        <lyric default-y="-73" name="verse" number="1">
          <syllabic>single</syllabic>
          <text>I</text>
        </lyric>
      </note>'
            }

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
    end
end
