require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Measure
        class Measure
            include Contracts
            attr_accessor :parts
            Contract ArrayOf[MusicalScore::Measure::Part] => Any
            def initialize(parts)
                @parts = parts
            end
        end
    end
end