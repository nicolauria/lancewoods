class StaticPagesController < ApplicationController
    def index
        @discography = Discography.all
        @events = Event.all
        @products = Product.all 

        render :index
    end

    def newsletter
        MyMailer.newsletter(email: params[:email]).deliver
        
        render plain: 'MF000'
    end

    def shop
        @products = Product.all
        render :shop
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
        
        redirect_to :cart
    end

    def cart
        @cart = cookies[:cart] ? Cart.find(cookies[:cart]) : Cart.new
        render :cart
    end

    # update quantity of product in a cart
    def update_quantity
        cart = Cart.find(cookies[:cart])
        cart.products[params[:idx].to_i]['quantity'] = params[:quantity]
        cart.save
    end

    def checkout_page
        redirect_to root_url unless cookies[:cart]
        @cart = Cart.find(cookies[:cart])
        render :checkout
    end

    def checkout
        @cart = Cart.find(cookies[:cart])

        products = @cart.products.map do |prod|
            {
                _id: prod['_id'],
                name: prod['name'],
                price: prod['price'],
                quantity: prod['quantity']
            }
        end

        shipping_address = {
            fname: params[:fname],
            lname: params[:lname],
            company: params[:company],
            address: params[:address],
            city: params[:city],
            email: params[:email],
            phone: params[:phone],
        }

        total = 0
        @cart.products.each do |prod|
            total += prod['price'].to_i * prod['quantity'].to_i
        end

        # Set your secret key. Remember to switch to your live secret key in production.
        # See your keys here: https://dashboard.stripe.com/account/apikeys
        Stripe.api_key = ENV['STRIPE_PUBLIC_KEY']

        charge = Stripe::Charge.create({
            amount: total * 100,
            currency: 'usd',
            description: 'Example charge',
            source: params[:stripeToken],
        })

        @order = Order.new(products: products, shipping_address: shipping_address, total: total, stripe_token: params[:stripeToken])
        @order.save
        @order.stripe_token = nil

        render :purchase_confirmation
    end

    def blog
        @posts = Blog.all
        render :blog_grid
    end

    def blog_post
        @post = Blog.find(params[:id])
        @posts = Blog.all
        render :blog_post
    end

    def contact
        render :contact
    end

    def contact_submit
        MyMailer.contact_form(fname: params[:fname], lname: params[:lname], email: params[:email], phone: params[:phone], message: params[:message]).deliver
        render plain: 'MF000'
    end
end

