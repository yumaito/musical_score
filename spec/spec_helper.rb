$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "musical_score"
require "rexml/document"
require "rexml/formatters/pretty"
require "benchmark"

# create dummy notes
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

# create dummy rests
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

# create dummy notes and rests
# (one third of num is rest note, and the order of notes and rests are shuffled)
def create_notes_with_rest(num)
    num_of_rest = num / 3
    num_of_note = num - num_of_rest
    notes = create_notes(num_of_note)
    rests = create_rests(num_of_rest)

    result = notes + rests
    result.shuffle!
    return result
end

def create_measures(num)
    result = Array.new
    num.times do |index|
        result.push(create_measure(index + 1))
    end
    return result
end

# create one dummy measure
def create_measure(num)
    note_array   = create_notes(4)
    notes        = MusicalScore::Notes.new(note_array)
    measure      = MusicalScore::Part::Measure.new(notes, num)
    return measure
end

def create_partwise_part(measure_num)
    measures = MusicalScore::Measures.new(create_measures(measure_num))
    part     = MusicalScore::Part::Part.new(measures)
    return part
end

def dummy_nomusicxml
    xml = <<EOM
<?xml version="1.0" encoding="UTF-8"?>
<items>
  <item id="123">AAA</item>
  <item id="234">BBB</item>
  <item id="345">CCC</item>
  <obj>
    <no>1</no>
    <name>abc</name>
  </obj>
  <obj>
    <no>2</no>
    <name>bcd</name>
  </obj>
</items>
EOM

    doc = REXML::Document.new(xml)
    return doc
end

def dummy_xml(str)
    xml = <<-EOM
<?xml version="1.0" encoding="UTF-8"?>
#{str}
    EOM
    doc = REXML::Document.new(xml)
    return doc
end

def format_xml(xml_doc)
    result = ''
    formatter = REXML::Formatters::Pretty.new(4)
    formatter.compact = true
    formatter.write(xml_doc, result)
    return result
end
