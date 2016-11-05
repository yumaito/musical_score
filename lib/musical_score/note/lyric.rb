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
        end
    end
end