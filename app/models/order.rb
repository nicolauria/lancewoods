class Order
  include Mongoid::Document
  
  field :products, type: Array
  field :billing_address, type: Hash
  field :shipping_address, type: Hash
  field :total, type: String
end
