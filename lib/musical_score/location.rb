require 'contracts'

module MusicalScore
    class Location
        attr_reader :measure_number, :location, :anacrusis_location
        include Contracts
        Contract Nat, Rational, Rational => Any
        def initialize(measure_number, location, anacrusis_location)
            @measure_number     = measure_number
            @location           = location
            @anacrusis_location = anacrusis_location
        end
    end
end