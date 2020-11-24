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
end
