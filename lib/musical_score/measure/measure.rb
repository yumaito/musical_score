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
            attr_reader :number,
            attr_accessor :part
            Contract Nat, MusicalScore::Measure::Part => Any
            def initialize(number, part)
                @number = number
                @part   = part
            end
        end
    end
end