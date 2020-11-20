class Cart
  include Mongoid::Document
  
  field :products, type: Array, default: []
  field :total, type: String
end
