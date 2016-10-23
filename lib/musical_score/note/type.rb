require 'spec_helper'
module MusicalScore
    module Note
        class Type
            include Contracts

            @@size = %w(
                128th
                64th
                32nd
                16th
                eighth
                quarter
                half
                whole
                breve
            )
            attr_reader :size
            Contract Enum[*@@size] => Any
            def initialize(size)
                @size = size
            end
        end
    end
end