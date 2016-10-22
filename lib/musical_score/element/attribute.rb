module MusicalScore
    module Element
        class Attribute
            attr_accessor :divisions, :key, :time, :instruments, :clef

            # initialize the attibute
            #
            # @example usage
            #  attribute = MusicalScore::Element::Attribute.new do |attr|
            #      attr.divisions = 24
            #      attr.clef = MusicalScore::Element::Clef.new(:G)
            #      attr.key = MusicalScore::Element::Key.new(4, :major)
            #      attr.time = MusicalScore::Element::Time.new(4, 4)
            #      attr.instruments = "piano"
            #  end
            def initialize
                @instruments = "Piano"
                yield(self) if block_given?
            end
        end
    end
end
