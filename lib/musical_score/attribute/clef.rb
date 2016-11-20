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

            def self.create_by_hash(doc)
                sign = doc["sign"][0].to_sym
                line = doc.has_key?("line") ? doc["line"][0].to_i : 0
                clef_octave_change = doc.has_key?("clef-octave-change") ? doc["clef-octave-change"][0].to_i : 0
                clef = MusicalScore::Attribute::Clef.new(sign, line, clef_octave_change)
                return clef
            end

            def export_xml
                clef_element  = REXML::Element.new('clef')
                sign_element = REXML::Element.new('sign').add_text(@sign.to_s)
                line_element = @line != 0 ? REXML::Element.new('line').add_text(@line.to_s) : nil
                clef_octave_change_element = @clef_octave_change != 0 ? REXML::Element.new('clef-octave-change').add_text(@clef_octave_change.to_s) : nil

                clef_element.add_element(sign_element)
                clef_element.add_element(line_element) if line_element
                clef_element.add_element(clef_octave_change_element) if clef_octave_change_element

                return clef_element
            end
        end
    end
end