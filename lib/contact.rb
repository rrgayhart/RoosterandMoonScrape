require 'erb'
require 'pony'


class Contact
  attr_reader :name, :email, :subject, :comment

  def initialize(form)
    @name    = form[:name]
    @email   = form[:email]
    @subject = form[:subject]
    @comment = form[:comment]
  end

  def send_email
    Pony.mail({
      :to => 'denvergschool@gmail.com',
      :subject => "Contact Email From Website",
      :body => "Name: #{@name},\n Email: #{@email},\n Subject: #{@subject},\n Comment: #{@comment}",
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'denvergschool',
        :password             => 'g$chooldenver',
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
      }
    })
  end

end
