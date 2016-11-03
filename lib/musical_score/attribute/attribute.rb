require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Attribute
        class Attribute < MusicalScore::ElementBase
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
