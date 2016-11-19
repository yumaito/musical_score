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

                def export_xml
                    tuplet_element = REXML::Element.new('tuplet')
                    tuplet_element.add_attribute('type', @type.to_s)

                    return tuplet_element
                end
            end
        end
    end
end