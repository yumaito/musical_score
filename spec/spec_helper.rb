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
