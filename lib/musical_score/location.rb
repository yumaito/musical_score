require 'contracts'

module MusicalScore
    class Location
        attr_reader :measure_number, :location
        include Contracts
        Contract Nat, Rational => Any
        def initialize(measure_number, location)
            @measure_number = measure_number
            @location       = location
        end
    end
end