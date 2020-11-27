class MyMailer < ApplicationMailer
    def newsletter(options={})
        @email = options[:email]
        
        mail(:to=>"admin@ohm.solutions", :subject=>"lancewoodscomedy.com")
    end

    def contact_form(options={})
        attachments.inline["ohms-logo.png"] = File.read("#{Rails.root}/public/images/ohms-logo.png")

        @fname = options[:fname]
        @lname = options[:lname]
        @email = options[:email]
        @phone = options[:phone]
        @message = options[:message]

        mail(:to=>"admin@ohm.solutions", :subject=>"lancewoodscomedy.com")
    end

    def purchase_confirmation(options={})
        @id = options[:id]
        @products = options[:products]
        @shipping_address = options[:shipping_address]
        @total = options[:total]
        recipients = options[:email] + ",admin@ohm.solutions"
        
        mail(:to=>recipients, :subject=>"Lance Woods Comedy Purchase Confirmation")
    end
end
