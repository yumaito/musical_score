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
            include Contracts

            # constructor for rest note
            Contract KeywordArgs[
                :duration => Pos,
                :tie      => Maybe[Enum[*TYPE_START_STOP]],
                :dot      => Nat,
                :lyric    => nil,
                :pitch    => nil,
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

            # constructor for pitched note
            Contract KeywordArgs[
                :duration => Pos,
                :tie      => Maybe[Enum[*TYPE_START_STOP]],
                :dot      => Nat,
                :lyric    => Maybe[MusicalScore::Note::Lyric],
                :pitch    => Maybe[MusicalScore::Note::Pitch],
                :rest     => false,
                :type     => MusicalScore::Note::Type,
            ] => Any
            def initialize(
                duration:,
                tie: nil,
                dot: 0,
                lyric: nil,
                pitch: nil,
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
