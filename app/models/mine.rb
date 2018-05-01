class Mine < ActiveRecord::Base
  #acts_as_indexed fields: [:name, :description, :id]
  belongs_to :gps_file
  has_many :photos, dependent: :destroy
  belongs_to :created_by, class_name: "User", foreign_key: "created_by"
  belongs_to :locked_by, class_name: "User", foreign_key: "locked_by"
  belongs_to :updated_by, class_name: "User", foreign_key: 'updated_by'

  def fullbackup
    Mine.fullbackup
    send_file "private/fullbackup_untergrundkataster.kml", filename: "fullback_untergrundkataster.kml"
  end
  
  def documents
  	documents = []
  	photos.each do |photo|
  		documents << photo if photo.photo_type == 1
  	end
  	return documents
  end

  def images
  	images = []
  	photos.each do |photo|
  		images << photo if photo.photo_type != 1
  	end
  	return images
  end

  def self.fullbackup
    mines = self.where(deleted: false)
    #mines = self.where(id: 62854)
    kml = "<?xml version='1.0' encoding='UTF-8'?>
        <kml xmlns='http://www.opengis.net/kml/2.2'>
        <Document>
          <name>Untergrundkataster "+ DateTime.now.strftime("%Y%m%d_%H%M%S")+"</name>
          <description>Export von " + mines.count.to_s + " Eintraegen</description>
          <Folder>"
    puts "Count: " + mines.size().to_s
    f = File.new("private/fullbackup_untergrundkataster.kml","wb")
    f.write(kml)

    mines.each do |mine|
      kml =  
      "<Placemark>
        <name><![CDATA["+mine.name+"]]></name>"
      if (mine.description)
        kml = kml + "<description><![CDATA["+mine.description+"]]></description>"
      end
      kml = kml + 
        "<styleUrl>#icon-503-DB4436</styleUrl>
        <ExtendedData>
        </ExtendedData>
        <Point>
          <coordinates>"+mine.longitude.to_s+","+mine.latitude.to_s+",0.0</coordinates>
        </Point>
      </Placemark>"
      f.write(kml)
    end
    f.write("</Folder></Document></kml>")
    
    f.flush
    f.close
  end
end
