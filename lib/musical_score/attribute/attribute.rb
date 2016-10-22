module MusicalScore
    module Attribute
        class Attribute
            attr_accessor :divisions, :key, :time, :instruments, :clef

            # initialize the attibute
            #
            # @example usage
            #  attribute = MusicalScore::Attribute::Attribute.new do |attr|
            #      attr.divisions = 24
            #      attr.clef = MusicalScore::Attribute::Clef.new(:G)
            #      attr.key = MusicalScore::Attribute::Key.new(4, :major)
            #      attr.time = MusicalScore::Attribute::Time.new(4, 4)
            #      attr.instruments = "piano"
            #  end
            def initialize
                @instruments = "Piano"
                yield(self) if block_given?
            end
        end
    end
end
