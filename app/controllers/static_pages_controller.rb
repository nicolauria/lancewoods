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
        @cart = Cart.find(cookies[:cart])
        redirect_to root_url unless @cart
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

        billing_address = {
            fname: params[:ba_fname],
            lname: params[:ba_lname],
            company: params[:ba_company],
            address: params[:ba_address],
            city: params[:ba_city],
            email: params[:ba_email],
            phone: params[:ba_phone],
        }

        if !params[:sa_address]
            shipping_address = billing_address
        else
            shipping_address = {
                fname: params[:sa_fname],
                lname: params[:sa_lname],
                company: params[:sa_company],
                address: params[:sa_address],
                city: params[:sa_city],
                email: params[:sa_email],
                phone: params[:sa_phone],
            }
        end

        total = 0
        @cart.products.each do |prod|
            total += prod['price'].to_i * prod['quantity'].to_i
        end

        order = Order.new(products: products, billing_address: billing_address, shipping_address: shipping_address, total: total)
        order.save

        redirect_to :checkout
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
end

