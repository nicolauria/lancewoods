module CartUtil
    extend ActiveSupport::Concern

    def self.populate(data)
        data.map do |cart_json|
            cart = Cart.find(cart_json[:id])
            cart.assign_attributes(cart_json)
            cart
        end
    end

end