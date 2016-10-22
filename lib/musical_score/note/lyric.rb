module MusicalScore
    module Note
        class Lyric

            @@syllabic = [ :single, :begin, :end, :middle ]

            attr_accessor :text, :syllabic, :is_extend

            # constructor
            #
            # @param text [String]
            # @param syllabic [Symbol]
            # @param is_extend [Boolean]
            def initialize(text, syllabic, is_extend)
                unless (@@syllabic.include?(syllabic.to_sym))
                    raise MusicalScore::InvalidSyllabic, "[#{syllabic}] is not a kind of syllabic"
                end

                @text      = text
                @syllabic  = syllabic
                @is_extend = is_extend
            end
        end
    end
end