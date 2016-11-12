require 'contracts'
require 'rexml/formatters/pretty'
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

            attr_reader :file_path
            attr_accessor :credits, :identification, :part_list, :parts
            Contract KeywordArgs[
                :credits        => Optional[ArrayOf[String]],
                :identification => Optional[MusicalScore::Score::Identification::Identification],
                :part_list      => ArrayOf[MusicalScore::Score::Part::Part],
                :parts          => ArrayOf[MusicalScore::Part::Part],
                :file_path      => Optional[String],
            ] => Any
            def initialize(
                credits: nil,
                identification: nil,
                part_list:,
                parts:,
                file_path: nil
                )
                @credits        = credits
                @identification = identification
                @part_list      = part_list
                @parts          = parts
                @file_path      = file_path

                set_location
            end

            Contract REXML::Document, String => MusicalScore::Score::Score
            def self.create_by_xml(xml_doc, file_path)
                partwise = xml_doc.elements["//score-partwise"]

                args = {}
                args[:file_path] = file_path
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

            def export_xml(path)
                doc = REXML::Document.new
                doc << REXML::XMLDecl.new('1.0', 'UTF-8')
                doc << REXML::Document.new(<<-EOS).doctype
                <!DOCTYPE score-partwise PUBLIC "-//Recordare//DTD MusicXML 3.0 Partwise//EN" "http://www.musicxml.org/dtds/partwise.dtd">
                EOS

                score_partwise = REXML::Element.new('score-partwise')
                if (@identification)
                    score_partwise.add_element(@identification.export_xml)
                end

                if (@credits)
                    @credits.each_with_index do |credit, index|
                        credit_element = REXML::Element.new('credit')
                        credit_element.add_attribute('page', index + 1)

                        credit_word = REXML::Element.new('credit-words')
                        credit_word.add_text(credit)

                        credit_element.add_element(credit_word)
                        score_partwise.add_element(credit_element)
                    end
                end
                # part_list = REXML::Element.new('part_list')
                # @part_list.each_with_index do |part, index|
                #     part_list.add_element(part.export_xml, index)
                # end
                # score_partwise.add_element(part_list)
                #
                # @parts.each_with_index do |part, index|
                #     score_partwise.add_element(part.export_xml, index)
                # end
                #
                doc.add_element(score_partwise)

                xml = ''
                formatter = REXML::Formatters::Pretty.new(4)
                formatter.write(doc, xml)
            end

            def set_location
                @parts.each do |part|
                    part.set_location
                end
            end
        end
    end
end
