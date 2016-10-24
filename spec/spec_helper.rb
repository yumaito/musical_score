$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "musical_score"

def create_notes(num)
    result = Array.new
    num.times do |index|
        note = MusicalScore::Note::Note.new(
            duration: 4,
            lyric: MusicalScore::Note::Lyric.new("a", :single),
            pitch: MusicalScore::Note::Pitch.new(:C, 0, 3),
            type: MusicalScore::Note::Type.new("quarter")
        )
        result.push(note)
    end
    return result
end
def create_rests(num)
    result = Array.new
    num.times do |index|
        rest = MusicalScore::Note::Note.new(
            duration: 4,
            rest: true,
            type: MusicalScore::Note::Type.new("quarter"),
        )
        result.push(rest)
    end
    return result
end
def create_notes_with_rest(num)
    num_of_rest = num / 3
    num_of_note = num - num_of_rest
    notes = create_notes(num_of_note)
    rests = create_rests(num_of_rest)

    result = notes + rests
    result.shuffle!
    return result
end
