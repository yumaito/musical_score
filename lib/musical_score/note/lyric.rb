require 'contracts'
module MusicalScore
    module Note
        class Lyric < MusicalScore::ElementBase
            include Contracts
            @@syllabic = %i(single begin end middle)
            attr_accessor :text, :syllabic, :is_extend

            # constructor
            #
            # @param text
            # @param syllabic
            # @param is_extend
            Contract String, Maybe[Enum[*@@syllabic]], Bool => Any
            def initialize(text, syllabic, is_extend = false)
                @text      = text
                @syllabic  = syllabic
                @is_extend = is_extend
            end
            Contract REXML::Element => MusicalScore::Note::Lyric
            def self.create_by_xml(xml_doc)
                syllabic  = xml_doc.elements["syllabic"] ? xml_doc.elements["syllabic"].text.to_sym : nil
                text      = xml_doc.elements["text"].text
                is_extend = xml_doc.elements["extend"] ? true : false
                return MusicalScore::Note::Lyric.new(text, syllabic, is_extend)
            end

            def export_xml(number)
                lyric_element = REXML::Element.new('lyric')
                lyric_element.add_attribute('number', number.to_s)
                text_element  = REXML::Element.new('text').add_text(@text.to_s)

                if (@syllabic)
                    syllabic_element = REXML::Element.new('syllabic').add_text(@syllabic.to_s)
                    lyric_element.add_element(syllabic_element)
                end
                lyric_element.add_element(text_element)

                return lyric_element
            end
        end
    end
end