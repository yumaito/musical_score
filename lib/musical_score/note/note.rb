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
            attr_accessor :duration, :tie, :dot, :lyric, :pitch, :rest, :type
            attr_reader :actual_duration
            include Contracts

            # constructor for rest note
            Contract KeywordArgs[
                :duration => Pos,
                :tie      => Maybe[Enum[*TYPE_START_STOP]],
                :dot      => Nat,
                :lyric    => Optional[nil],
                :pitch    => Optional[nil],
                :rest     => true,
                :type     => MusicalScore::Note::Type,
            ] => Any
            def initialize(
                duration:,
                tie: nil,
                dot: 0,
                lyric: nil,
                pitch: nil,
                rest: true,
                type:,
                **rest_args
                )
                @duration = duration
                @tie      = tie
                @dot      = dot
                @lyric    = lyric
                @pitch    = pitch
                @rest     = rest
                @type     = type
            end

            # constructor for pitch note
            Contract KeywordArgs[
                :duration => Pos,
                :tie      => Maybe[Enum[*TYPE_START_STOP]],
                :dot      => Nat,
                :lyric    => Maybe[MusicalScore::Note::Lyric],
                :pitch    => MusicalScore::Note::Pitch,
                :rest     => Optional[false],
                :type     => MusicalScore::Note::Type,
            ] => Any
            def initialize(
                duration:,
                tie: nil,
                dot: 0,
                lyric: nil,
                pitch:,
                rest: false,
                type:,
                **rest_args
                )
                @duration = duration
                @tie      = tie
                @dot      = dot
                @lyric    = lyric
                @pitch    = pitch
                @rest     = rest
                @type     = type
            end

        end
    end
end
