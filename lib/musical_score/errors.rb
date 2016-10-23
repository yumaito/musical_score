module MusicalScore
    CUSTOM_VALIDATION_BETWEEN_VALUES = lambda {|arg, value1, value2,|
        arg.between?(value1, value2)
    }
end