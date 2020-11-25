class Event
  include Mongoid::Document
  
  field :name, type: String
  validates :name, :presence => true

  field :description, type: String
  validates :description, :presence => true

  field :date, type: String
  validates :date, :presence => true
  
  field :price, type: String
  validates :price, :presence => true
  
  field :event_url, type: String
  validates :event_url, :presence => true
  
  field :city, type: String
  validates :city, :presence => true
  
  field :location, type: String
  validates :location, :presence => true
end
