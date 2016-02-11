require File.expand_path('../../config/environment', __FILE__)

duplicates = Hash.new
mines = Mine.all
mines.each do |mine|
        key = mine.latitude.to_s + "-" + mine.longitude.to_s
        if !duplicates.key? key
                duplicates[key] = Array.new 
        end
        duplicates[key] << mine.id
end

count = 0
duplicates.each_pair do |key, value|
        if value.size > 1
                value.each do |id|
                        puts "   " + id.to_s
                end
                count += value.size
        else
                duplicates.delete key
        end
end

puts "too delete: " + count.to_s

duplicates.each_pair do |key, value|

        value.sort!
        value = value[0..value.size-2]
        value.each do |id|
                puts "Mark mine with id " + id.to_s
                mine = Mine.find(id)
                mine.deleted = true
                mine.save!
        end
end
