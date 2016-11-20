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
                    tie_arg      = xml_doc.elements["tied"] ? xml_doc.elements["tied"].attributes["type"].to_sym : nil
                    tie = tie_arg ? MusicalScore::Note::Notation::Tie.new(tie_arg) : nil
                    tuplet_arg   = xml_doc.elements["tuplet"] ? xml_doc.elements["tuplet"].attributes["type"].to_sym : nil
                    tuplet = tuplet_arg ? MusicalScore::Note::Notation::Tuplet.new(tuplet_arg) : nil
                    return MusicalScore::Note::Notation::Notation.new(articulation: articulation, dynamics: dynamics, tie: tie, tuplet: tuplet)
                end

                def self.create_by_hash(doc)
                    articulation = doc.has_key?("articulations") ? doc["articulations"][0].keys[0].to_sym : nil
                    dynamics     = doc.has_key?("dynamics") ? doc["dynamics"][0].keys[0].to_sym : nil
                    tie_arg      = doc.has_key?("tied") ? doc.dig("tied", 0, "type").to_sym : nil
                    tie          = tie_arg ? MusicalScore::Note::Notation::Tie.new(tie_arg) : nil
                    tuplet_arg   = doc.has_key?("tuplet") ? doc.dig("tuplet", 0, "type").to_sym : nil
                    tuplet = tuplet_arg ? MusicalScore::Note::Notation::Tuplet.new(tuplet_arg) : nil
                    return MusicalScore::Note::Notation::Notation.new(articulation: articulation, dynamics: dynamics, tie: tie, tuplet: tuplet)
                end

                def export_xml
                    notations_element    = REXML::Element.new('notations')
                    articulation_element = REXML::Element.new('articulations')
                    dynamics_element     = REXML::Element.new('dynamics')

                    if (@articulation)
                        articulation_element.add_element(REXML::Element.new(@articulation.to_s))
                        notations_element.add_element(articulation_element)
                    end
                    if (@dynamics)
                        dynamics_element.add_element(REXML::Element.new(@dynamics.to_s))
                        notations_element.add_element(dynamics_element)
                    end

                    notations_element.add_element(@tie.export_xml) if @tie
                    notations_element.add_element(@tuplet.export_xml) if @tuplet

                    return notations_element
                end
            end
        end
    end
end
