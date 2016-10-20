module MusicalScore
    module Element
        class Pitch
            include Comparable
            # pitch names
            @@key = {
                :C => 0,
                :D => 2,
                :E => 4,
                :F => 5,
                :G => 7,
                :A => 9,
                :B => 11
            }
            attr_accessor :step, :alter, :octave

            # constructor
            #
            # @example create Pitch object
            #  MusicalScore::Element::Pitch.new(:C, 0, 3) # => C3
            #
            # @param step [Symbol] The key of the pitch described as "C", "D", "E", etc.
            # @param alter [Integer] The number of sharp (positive number) or flat (negative number).
            # @param octave [Integer] The octave number
            #
            def initialize(step, alter, octave)
                # Check arguments
                unless (@@key.key?(step.to_sym))
                    raise MusicalScore::InvalidNote, "\"#{step}\" is not a kind of note key"
                end
                unless (alter.kind_of?(Integer))
                    raise TypeError, "\"#{alter}\" is not a kind of Integer"
                end
                unless ([-2, -1, 0, 1, 2].include?(alter))
                    raise ArgumentError, "\"#{alter}\" is invalid"
                end
                unless (octave.kind_of?(Integer))
                    raise TypeError, "\"#{alter}\" is not a kind of Integer"
                end
                if (octave < 0)
                    raise ArgumentError, "\"#{octave}\" must be zero or more"
                end

                @step   = step.to_sym
                @alter  = alter
                @octave = octave
            end

            # Pitch is comparable
            #
            # @example
            #  a = MusicalScore::Element::Pitch.new(:C, 0, 3)
            #  b = MusicalScore::Element::Pitch.new(:D, 0 ,3)
            #  a < b # => true
            def <=> (other)
                self.note_number <=> other.note_number
            end

            # Given a note_number like MIDI note_number, return the Pitch object with positive number of alter
            #
            # @example
            #  a = MusicalScore::Element::Pitch.new_note_sharp(70)
            #  a # => [:step => :A, :alter => 1, :octave => 5 ]
            # @param note_number [Ingteger] note_number
            # @return [MusicalScore::Element::Pitch]
            def self.new_note_sharp(note_number)
                step_key_num   = note_number % 12
                octave         = note_number / 12
                # calculate step and alter
                candidate_keys = @@key.keys.select{ |item| step_key_num >= @@key[item] }
                key            = candidate_keys.max_by{ |item| @@key[item] }

                return MusicalScore::Element::Pitch.new(key, step_key_num-@@key[key], octave)
            end

            # Given a note_number like MIDI note_number, return the Pitch object with negative number of alter
            #
            # @example
            #  a = MusicalScore::Element::Pitch.new_note_sharp(70)
            #  a # => [:step => :B, :alter => -1, :octave => 5 ]
            #
            # @param note_number [Ingteger] note_number
            # @return [MusicalScore::Element::Pitch]
            def self.new_note_flat(note_number)
                step_key_num   = note_number % 12
                octave         = note_number / 12
                # calculate step and alter
                candidate_keys = @@key.keys.select{ |item| step_key_num <= @@key[item] }
                key            = candidate_keys.min_by{ |item| @@key[item] }

                return MusicalScore::Element::Pitch.new(key, step_key_num-@@key[key], octave)
            end

            # @return [Integer] note_number
            def note_number
                result = (12 * octave) + @@key[step] + alter
                return result
            end

            # Given argument true, return note string like "D##"
            #
            # @param is_note_str [Boolean]
            # @return [String]
            def to_s(is_note_str = false)
                if is_note_str
                    result = "%s%s%d" % [@step.to_s, alter_to_s, @octave]
                    return result
                else
                    return self.to_s
                end
            end

            private

            def alter_to_s
                num = @alter.abs
                if (num == 0)
                    return ""
                elsif (@alter < 0)
                    result = ''
                    num.times do |i|
                        result += 'b'
                    end
                    return result
                else
                    result = ''
                    num.times do |i|
                        result += '#'
                    end
                    return result
                end
            end
        end
    end
end
