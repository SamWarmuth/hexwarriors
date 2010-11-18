class Battle < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER
  
  property :name
  
  property :date
  property :user_details, :cast_as => ['Detail']
  
  property :map, :default => []
  
  property :picture_url
  
  
  def colors
    self.user_details.map{|d| d.color}
  end
  
  def clear_map(width, height)
    self.map = []
    height.times do
      self.map << Array.new(width){|index| index}
    end
    self.save
  end
  
  def random_map(width, height)
    self.map = []
    colors = self.colors
    height.times do
      self.map << Array.new(width){|index| colors[rand(colors.size)]*100 + index}
    end
    self.save
  end
  
  def ajacent_to(x, y)
    if y%2 == 1
      coords = [[0,-1], [0,-2], [1,-1], [1,1], [0,2], [0, 1]]
    else
      coords = [[-1,-1], [0,-2], [0,-1], [0,1], [0,2], [-1, 1]]
    end
    coords.map{|m,n| map[m][n]}
  end
  
end

class Detail < Hash
  include CouchRest::CastedModel
  
  property :user_id
  property :color
  
end
