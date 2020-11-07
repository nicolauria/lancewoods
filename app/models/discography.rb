class Discography
  include Mongoid::Document
  
  field :name, type: String
  field :image, type: String
  field :googlePlay, type: String
  field :itunes, type: String
  field :year, type: String
end
