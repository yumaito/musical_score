require 'contracts'
Dir[File.expand_path('../', __FILE__) << '/**/*.rb'].each do |file|
    # require file except myself
    if(file != __FILE__)
        require file
    end
end
module MusicalScore
    module Note
        class Note
            attr_accessor :duration, :tie, :dot, :lyric, :note, :rest
            include Contracts
        end
    end
end
