require 'contracts'
require 'musical_score/attribute/clef'
require 'musical_score/attribute/key'
require 'musical_score/attribute/time'
module MusicalScore
    module Attribute
        class Attribute
            include Contracts
            attr_accessor :divisions, :key, :time, :instruments, :clef

            # initialize the attibute
            #
            Contract KeywordArgs[
                :divisions   => Num,
                :clef        => Optional[MusicalScore::Attribute::Clef],
                :key         => Optional[MusicalScore::Attribute::Key],
                :time        => Optional[MusicalScore::Attribute::Time],
                :instruments => Optional[String],
            ] => Any
            def initialize(
                divisions:,
                clef: MusicalScore::Attribute::Clef.new(:G),
                key: MusicalScore::Attribute::Key.new(0, :major),
                time: MusicalScore::Attribute::Time.new(4, 4),
                instruments: 'Piano',
                **rest_args
            )
                @divisions   = divisions
                @clef        = clef
                @key         = key
                @time        = time
                @instruments = instruments
            end
        end
    end
end
