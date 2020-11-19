class Product
  include Mongoid::Document
  field :name, type: String
  field :price, type: String
  field :description, type: String
  field :image1, type: String
  field :image2, type: String
  field :image3, type: String
  field :thumbnail, type: String
  field :popular, type: String
  field :category, type: String
end
