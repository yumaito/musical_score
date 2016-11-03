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
            Contract String, Enum[*@@syllabic], Bool => Any
            def initialize(text, syllabic, is_extend = false)
                @text      = text
                @syllabic  = syllabic
                @is_extend = is_extend
            end
        end
    end
end