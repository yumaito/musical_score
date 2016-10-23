require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Note
        module Notation
            class Notation
                include Contracts
                @@articulation = %i(
                    accent
                    breath_mark
                    caesura
                    detached_legato
                    doit
                    falloff
                    plop
                    scoop
                    spiccato
                    staccatissimo
                    staccato
                    stress
                    strong_accent
                    tenuto
                    unstress
                )
                @@dynamics = %i(
                    f
                    ff
                    fff
                    ffff
                    fffff
                    fp
                    fz
                    mf
                    mp
                    p
                    pp
                    ppp
                    pppp
                    ppppp
                    rf
                    rfz
                    sf
                    sffz
                    sfpp
                    sfz
                )
                attr_accessor :articulation, :dynamics, :tie, :tuplet
                Contract KeywordArgs[
                    :articulation => Maybe[Enum[*@@articulation]],
                    :dynamics     => Maybe[Enum[*@@dynamics]],
                    :tie          => Maybe[MusicalScore::Note::Notation::Tie],
                    :tuplet       => Maybe[MusicalScore::Note::Notation::Tuplet],
                ] => Any
                def initialize(
                    articulation: nil,
                    dynamics: nil,
                    tie: nil,
                    tuplet: nil,
                    **rest_args
                    )
                    @articulation = articulation
                    @dynamics     = dynamics
                    @tie          = tie
                    @tuplet       = tuplet
                end
            end
        end
    end
end
