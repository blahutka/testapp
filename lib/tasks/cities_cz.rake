namespace :cities do

  task :import => :environment do
    sql = ""
    file = File.expand_path(File.join(Rails.root, 'db/seeds/cities_rows.sql'))
    source = File.new(file, "r")
    #ActiveRecord::Base.establish_connection

    while (line = source.gets)
      record = line.match(/values\((.*)\)/im)[1].gsub("'", "").split(',')
      next if record.empty?
      city = record[1]
      district = record[2]
      country_id = record[3]
      zip = record[6]
      latitude = record[7]
      longitude = record[8]
      region_id = record[9]
      City.create(:name => city, :district => district, :country_id => country_id, :zip => zip, :latitude => latitude,
                  :longitude => longitude, :region_id => region_id)
      sleep 1
    end
    source.close


  end
end