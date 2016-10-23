require 'contracts'
module MusicalScore
    module Note
        module Notation
            class Tie
                include Contracts
                attr_accessor :type
                Contract Enum[*TYPE_START_STOP_CONTINUE] => Any
                def initialize(type)
                    @type = type.to_sym
                end
            end
        end
    end
end
