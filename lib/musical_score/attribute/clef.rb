require "contracts"
module MusicalScore
    module Attribute
        class Clef < MusicalScore::ElementBase
            include Contracts
            @@sign = %i(G F C percussion TAB jianpu none)
            attr_reader :sign, :line, :clef_octave_change

            # constructor
            #
            # @param sign The sign of clef, such as treble, bass. It is described by the @@sign symbols
            # @param line The number of line from the bottom of the staff, which the sign note is defined at the line.
            # @param clef_octave_change The number of clef changes, which is written either an octave higher or lower than sounding pitch
            Contract Enum[*@@sign], Pos, Num => Any
            def initialize(sign, line = 0, clef_octave_change = 0)
                @sign               = sign.to_sym
                @line               = line
                @clef_octave_change = clef_octave_change
            end

            Contract REXML::Element => MusicalScore::Attribute::Clef
            def self.create_by_xml(xml_doc)
                sign = xml_doc.elements["sign"].text.to_sym
                line = xml_doc.elements["line"] ? xml_doc.elements["line"].text.to_i : 0
                clef_octave_change = xml_doc.elements["clef-octave-change"] ? xml_doc.elements["clef-octave-change"].text.to_i : 0
                clef = MusicalScore::Attribute::Clef.new(sign, line, clef_octave_change)
                return clef
            end
        end
    end
end