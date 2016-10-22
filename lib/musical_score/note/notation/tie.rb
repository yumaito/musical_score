module MusicalScore
    module Note
        module Notation
            class Tie

                attr_accessor :type
                def initialize(type)
                    @type = type.to_sym
                end
            end
        end
    end
end
