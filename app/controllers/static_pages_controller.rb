class StaticPagesController < ApplicationController
    def index
        @discography = Discography.all
        @events = Event.all
        @products = Product.all 

        render :index
    end

    def newsletter
        MyMailer.send_email(name: params[:name], phone: params[:phone], email: params[:email], message: params[:message]).deliver
        
        render plain: 'MF000'
    end

    def product
        @product = Product.find(params[:id])
        @products = Product.all

        render :product
    end

    def add_to_cart
        product = Product.find(params[:id])
        product['quantity'] = params[:quantity]

        # add to existing cart
        if cookies[:cart]
            @cart = Cart.find(cookies[:cart])

            modified = false

            # check if product already in cart
            @cart.products.each_with_index do |prod, idx|
                if params[:id] == prod['_id']
                    @cart.products[idx] = product.as_json
                    @cart.save
                    modified = true
                    break
                end
            end

            if !modified
                @cart.products.push(product.as_json)
                @cart.save
            end

        else
            # add to new cart
            @cart = Cart.new
            @cart.products = [product.as_json]
            @cart.save

            cookies[:cart] = @cart._id
        end
        
        render :cart
    end

    # def cart
    #     @cart = Cart.find(cookies[:cart])
    #     render :cart
    # end

    # update quantity of product in a cart
    def update_quantity
        cart = Cart.find(cookies[:cart])
        cart.products[params[:idx].to_i]['quantity'] = params[:quantity]
        cart.save
    end
end

