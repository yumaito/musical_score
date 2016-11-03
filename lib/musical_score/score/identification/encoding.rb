require 'contracts'
module MusicalScore
    module Score
        module Identification
            class Encoding < MusicalScore::ElementBase
                include Contracts
                attr_reader :type, :encoding_date, :encoding_description, :softwares, :supports
                Contract String, Time, String, ArrayOf[String], ArrayOf[String] => Any
                def initialize(type, encoding_date, encoding_description, softwares, supports)
                    @type                 = type
                    @encoding_date        = encoding_date
                    @encoding_description = encoding_description
                    @softwares            = softwares
                    @supports             = supports
                end
            end
        end
    end
end
