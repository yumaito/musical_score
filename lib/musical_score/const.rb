module MusicalScore
    SHARP = :sharp
    FLAT  = :flat

    NUMBER_OF_NOTES   = 12
    NUMBER_OF_FIFTHS  = 7
    SHARP_START_INDEX = 11
    FLAT_START_INDEX  = 6

    RELATED_KEY_SLIDE_NUMBER = 9

    AVAILABLE_NUMBERS_OF_ALTER = [-2, -1, 0, 1, 2]
    TYPE_START_STOP          = %i(start stop)
    TYPE_START_STOP_CONTINUE = %i(start stop continue)
    TYPE_CREATOR             = %i(composer lyricist arranger)
end
