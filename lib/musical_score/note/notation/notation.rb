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
            class Notation < MusicalScore::ElementBase
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

                Contract REXML::Element => MusicalScore::Note::Notation::Notation
                def self.create_by_xml(xml_doc)
                    articulation = xml_doc.elements["articulations"] ? xml_doc.elements["articulations"].elements[1].name.to_sym : nil
                    dynamics     = xml_doc.elements["dynamics"] ? xml_doc.elements["dynamics"].elements[1].name.to_sym : nil
                    tie_arg      = xml_doc.elements["tied"] ? xml_doc.elements["tied"].attribute["type"].text.to_sym : nil
                    tie = tie_arg ? MusicalScore::Note::Notation::Tie.new(tie_arg) : nil
                    tuplet_arg   = xml_doc.elements["tuplet"] ? xml_doc.elements["tuplet"].attribute["type"].text.to_sym : nil
                    tuplet = tuplet_arg ? MusicalScore::Note::Notation::Tuplet.new(tuplet_arg) : nil
                    return MusicalScore::Note::Notation::Notation.new(articulation: articulation, dynamics: dynamics, tie: tie, tuplet: tuplet)
                end
            end
        end
    end
end
