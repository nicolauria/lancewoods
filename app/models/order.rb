class Order
  include Mongoid::Document
  
  field :products, type: Array
  field :shipping_address, type: Hash
  field :total, type: String
  field :stripe_token, type: String
end
