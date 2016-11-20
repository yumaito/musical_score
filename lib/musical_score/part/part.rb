require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Part
        class Part < MusicalScore::ElementBase
            include Contracts
            attr_accessor :measures
            Contract MusicalScore::Measures => Any
            def initialize(measures)
                @measures = measures
            end

            Contract REXML::Element => MusicalScore::Part::Part
            def self.create_by_xml(xml_doc)
                measure_array = Array.new
                xml_doc.elements.each("//measure") do |element|
                    measure = MusicalScore::Part::Measure.create_by_xml(element)
                    measure_array.push(measure)
                end
                measures = MusicalScore::Measures.new(measure_array)
                return MusicalScore::Part::Part.new(measures)
            end

            def self.create_by_hash(doc)
                measure_array = Array.new
                doc["measure"].each do |element|
                    measure = MusicalScore::Part::Measure.create_by_hash(element)
                    measure_array.push(measure)
                end
                measures = MusicalScore::Measures.new(measure_array)
                return MusicalScore::Part::Part.new(measures)
            end

            def export_xml(number)
                part = REXML::Element.new('part')
                part.add_attribute('id', "P" + number.to_s)

                @measures.each do |measure|
                    part.add_element(measure.export_xml)
                end

                return part
            end

            def set_location
                @measures.set_location
            end
        end
    end
end
