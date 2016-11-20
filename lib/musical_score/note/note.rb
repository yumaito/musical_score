require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Note
        class Note < MusicalScore::ElementBase
            attr_accessor  :lyric, :location
            attr_reader :duration, :tie, :dot, :time_modification, :actual_duration, :pitch, :rest, :type, :notation
            include Contracts

            # constructor for rest note
            Contract KeywordArgs[
                :duration          => Pos,
                :tie               => Maybe[Enum[*TYPE_START_STOP]],
                :dot               => Optional[Nat],
                :lyric             => Optional[nil],
                :pitch             => Optional[nil],
                :rest              => true,
                :type              => MusicalScore::Note::Type,
                :time_modification => Maybe[MusicalScore::Note::TimeModification],
                :notation          => Maybe[MusicalScore::Note::Notation::Notation],
            ] => Any
            def initialize(
                duration:,
                tie: nil,
                dot: 0,
                lyric: nil,
                pitch: nil,
                rest: true,
                type:,
                time_modification: nil,
                notation: nil,
                **rest_args
                )
                @duration = duration
                @tie      = tie
                @dot      = dot
                @lyric    = lyric
                @pitch    = pitch
                @rest     = rest
                @type     = type
                @time_modification = time_modification
                @notation = notation

                set_actual_duration
            end

            # constructor for pitch note
            Contract KeywordArgs[
                :duration          => Pos,
                :tie               => Maybe[Enum[*TYPE_START_STOP]],
                :dot               => Optional[Nat],
                :lyric             => Maybe[MusicalScore::Note::Lyric],
                :pitch             => MusicalScore::Note::Pitch,
                :rest              => Optional[false],
                :type              => MusicalScore::Note::Type,
                :time_modification => Maybe[MusicalScore::Note::TimeModification],
                :notation          => Maybe[MusicalScore::Note::Notation::Notation],
            ] => Any
            def initialize(
                duration:,
                tie: nil,
                dot: 0,
                lyric: nil,
                pitch:,
                rest: false,
                type:,
                time_modification: nil,
                notation: nil,
                **rest_args
                )
                @duration = duration
                @tie      = tie
                @dot      = dot
                @lyric    = lyric
                @pitch    = pitch
                @rest     = rest
                @type     = type
                @time_modification = time_modification
                @notation = notation

                set_actual_duration
            end

            Contract REXML::Element => MusicalScore::Note::Note
            def self.create_by_xml(xml_doc)
                dots = 0
                xml_doc.elements.each("dot") do |elemet|
                    dots += 1
                end
                duration = xml_doc.elements["duration"].text.to_i
                type     = MusicalScore::Note::Type.new(xml_doc.elements["type"].text)

                tie = xml_doc.elements["tie"] ? xml_doc.elements["tie"].attributes["type"].to_sym : nil

                notation_doc = xml_doc.elements["notations"]
                notation     = notation_doc ? MusicalScore::Note::Notation::Notation.create_by_xml(notation_doc) : nil

                time_modification_doc = xml_doc.elements["time-modification"]
                time_modification = time_modification_doc ? MusicalScore::Note::TimeModification.create_by_xml(time_modification_doc) : nil
                rest = xml_doc.elements["rest"] ? true : false
                if (rest)
                    return MusicalScore::Note::Note.new(duration: duration, tie: tie, dot: dots, rest: rest, type: type, time_modification: time_modification, notation: notation)
                else
                    pitch = MusicalScore::Note::Pitch.create_by_xml(xml_doc.elements["pitch"])
                    lyric_doc = xml_doc.elements["lyric"]
                    lyric = lyric_doc ? MusicalScore::Note::Lyric.create_by_xml(lyric_doc) : nil
                    return MusicalScore::Note::Note.new(duration: duration, tie: tie, dot: dots, type: type, lyric: lyric, pitch: pitch, time_modification: time_modification, notation: notation)
                end
            end

            def self.create_by_hash(doc)
                dots     = doc.has_key?("dot") ? doc["dot"].size : 0
                duration = doc["duration"][0].to_i
                type     = MusicalScore::Note::Type.new(doc["type"][0])
                tie      = doc.has_key?("tie") ? doc.dig("tie", 0, "type").to_sym : nil
                notation = doc.has_key?("notations") ? MusicalScore::Note::Notation::Notation.create_by_hash(doc["notations"][0]) : nil
                time_modification = doc.has_key?("time-modification") ? MusicalScore::Note::TimeModification.create_by_hash(doc["time-modification"][0]) : nil
                rest = doc.has_key?("rest")

                if (rest)
                    return MusicalScore::Note::Note.new(duration: duration, tie: tie, dot: dots, rest: rest, type: type, time_modification: time_modification, notation: notation)
                else
                    pitch = MusicalScore::Note::Pitch.create_by_hash(doc["pitch"][0])
                    lyric = doc.has_key?("lyric") ? MusicalScore::Note::Lyric.create_by_hash(doc["lyric"][0]) : nil
                    return MusicalScore::Note::Note.new(duration: duration, tie: tie, dot: dots, type: type, lyric: lyric, pitch: pitch, time_modification: time_modification, notation: notation)
                end

            end

            def export_xml
                note_element = REXML::Element.new('note')
                note_element.add_element('rest') if @rest
                note_element.add_element(@pitch.export_xml) if @pitch
                note_element.add_element('duration').add_text(@duration.to_s)
                note_element.add_element('tie').add_attribute('type', @tie.to_s) if @tie
                note_element.add_element(@type.export_xml)
                note_element.add_element(@time_modification.export_xml) if @time_modification
                note_element.add_element(@lyric.export_xml(1)) if @lyric
                note_element.add_element(@notation.export_xml) if @notation

                return note_element
            end

            private
            def set_actual_duration
                unless(@time_modification)
                    @actual_duration = Rational(@duration, 1)
                else
                    total_duration = @duration * @time_modification.normal_notes
                    @actual_duration = Rational(total_duration, @time_modification.actual_notes)
                end
            end
        end
    end
end
