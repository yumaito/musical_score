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

            def <=> (other)
                self.note_number <=> other.note_number
            end

            # Given a note_number like MIDI note_number, return the Pitch object
            def self.new_note_number(note_number)
                step_key_num   = note_number % 12
                octave         = note_number / 12
                candidate_keys = @@key.keys.select{ |item| step_key_num >= @@key[item] }
                key            = candidate_keys.max_by{ |item| @@key[item] }

                return MusicalScore::Element::Pitch.new(key, step_key_num-@@key[key], octave)
            end

            # returns note_number
            def note_number
                result = (12 * octave) + @@key[step] + alter
                return result
            end

            def alter_key_name

            end

            def to_s(sharp_flat = :default)
                if (sharp_flat == :sharp)

                elsif (sharp_flat == :flat)

                else
                    result = "%s%s%d" % [@step.to_s, self.alter_to_s, @octave]
                    return result
                end
            end

            private

            def alter_to_s
                num = @alter.abs
                if (num == 0)
                    return ""
                elsif (num < 0)
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
