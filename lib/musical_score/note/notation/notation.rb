module MusicalScore
    module Note
        module Notation
            class Notation
                @@articulation = [
                    :accent,
                    :breath_mark,
                    :caesura,
                    :detached_legato,
                    :doit,
                    :falloff,
                    :plop,
                    :scoop,
                    :spiccato,
                    :staccatissimo,
                    :staccato,
                    :stress,
                    :strong_accent,
                    :tenuto,
                    :unstress
                ]
                @@dynamics = [
                    :f,
                    :ff,
                    :fff,
                    :ffff,
                    :fffff,
                    :fp,
                    :fz,
                    :mf,
                    :mp,
                    :p,
                    :pp,
                    :ppp,
                    :pppp,
                    :ppppp,
                    :rf,
                    :rfz,
                    :sf,
                    :sffz,
                    :sfpp,
                    :sfz,
                ]
            end
        end
    end
end
