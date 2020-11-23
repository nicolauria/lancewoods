class Blog
  include Mongoid::Document

  field :title, type: String
  field :image, type: String
  field :thumbnail, type: String
  field :excerpt, type: String
  field :content, type: String
  field :date, type: String
end
