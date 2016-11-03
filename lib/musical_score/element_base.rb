require 'contracts'
require 'rexml/document'

module MusicalScore
    class ElementBase
        include Contracts

        Contract Or[REXML::Document, REXML::Element] => Any
        def self.create_by_xml(element)
            raise "Called abstract method: create_by_xml"
        end
    end
end