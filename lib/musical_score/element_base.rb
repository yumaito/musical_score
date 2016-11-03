require 'contracts'

module MusicalScore
    class ElementBase
        def self.create_by_xml(element)
            raise "Called abstract method: create_by_xml"
        end
    end
end