require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Score
        class Score < MusicalScore::ElementBase
            include Contracts
            attr_accessor :credits, :identification, :part_list, :parts
            Contract KeywordArgs[
                :credits        => Optional[ArrayOf[String]],
                :identification => Optional[MusicalScore::Score::Identification::Identification],
                :part_list      => ArrayOf[MusicalScore::Score::Part::Part],
                :parts          => ArrayOf[MusicalScore::Part::Part],
            ] => Any
            def initialize(
                credits: nil,
                identification: nil,
                part_list:,
                parts:
                )
                @credits        = credits
                @identification = identification
                @part_list      = part_list
                @parts          = parts
            end

            Contract REXML::Document => MusicalScore::Score::Score
            def self.create_by_xml(xml_doc)
                partwise           = xml_doc.elements["//score-partwise"]
                # parts_doc          = partwise.elements["//part"]

                args = {}
                identification_doc = partwise.elements["//identification"]
                if (identification_doc)
                    identification = MusicalScore::Score::Identification::Identification.create_by_xml(identification_doc)
                    args[:identification] = identification
                end
                credits = Array.new
                partwise.elements.each("//credit/credit-words") do |element|
                    credits.push(element.text)
                end
                args[:credits] = credits

                part_list = Array.new
                partwise.elements.each("//part-list/score-part") do |element|
                    part_name         = element.elements["part-name"].text
                    part_abbreviation = element.elements["part-abbreviation"].text
                    part = MusicalScore::Score::Part::Part.new(part_name, part_abbreviation)
                    part_list.push(part)
                end
                args[:part_list] = part_list

                parts = Array.new
                partwise.elements.each("//part") do |element|
                    part = MusicalScore::Part::Part.create_by_xml(element)
                    parts.push(part)
                end
                args[:parts] = parts

                return MusicalScore::Score::Score.new(args)
            end
        end
    end
end
