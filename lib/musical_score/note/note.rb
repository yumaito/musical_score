require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Note
        class Note
            attr_accessor  :lyric
            attr_reader :duration, :tie, :dot, :time_modification, :actual_duration, :pitch, :rest, :type
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

                set_actual_duration
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
