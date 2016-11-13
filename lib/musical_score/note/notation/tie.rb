require 'contracts'
module MusicalScore
    module Note
        module Notation
            class Tie < MusicalScore::ElementBase
                include Contracts
                attr_accessor :type
                Contract Enum[*TYPE_START_STOP_CONTINUE] => Any
                def initialize(type)
                    @type = type.to_sym
                end

                def export_xml
                    tie_element = REXML::Element.new('tie')
                    tie_element.add_attribute('type',@type.to_s)

                    return tie_element
                end
            end
        end
    end
end
