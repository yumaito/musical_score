require 'contracts'
module MusicalScore
    module Note
        class TimeModification
            include Contracts
            attr_reader :actual_notes, :normal_notes

            Contract Pos, Pos => Any
            def initialize(actual_notes, normal_notes)
                @actual_notes = actual_notes
                @normal_notes = normal_notes
            end
        end
    end
end