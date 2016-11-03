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
        end
    end
end
