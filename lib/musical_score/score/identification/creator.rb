require 'contracts'
module MusicalScore
    module Score
        module Identification
            class Creator < MusicalScore::ElementBase
                attr_reader :name, :type
                include Contracts
                Contract String, Enum[*TYPE_CREATOR] => Any
                def initialize(name, type)
                    @name = name
                    @type = type
                end
            end
        end
    end
end
