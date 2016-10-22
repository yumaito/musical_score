Dir[File.expand_path('../musical_score', __FILE__) << '/**/*.rb'].each do |file|
    require file
end

module MusicalScore
  # Your code goes here...
end
