class Event
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :date, type: String
  field :price, type: String
  field :event_url, type: String
  field :city, type: String
  field :location, type: String
end
