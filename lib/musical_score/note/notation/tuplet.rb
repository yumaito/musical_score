require 'contracts'
module MusicalScore
    module Note
        module Notation
            class Tuplet < MusicalScore::ElementBase
                include Contracts
                attr_accessor :type
                Contract Enum[*TYPE_START_STOP] => Any
                def initialize(type)
                    @type = type
                end
            end
        end
    end
end