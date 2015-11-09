require './app'
require 'sinatra/activerecord/rake'
require 'erb'

# Send email notifications
desc "Send email notifications"
task :email_notifications do
  Party.where(rsvp: TRUE, notified_at: nil).find_each do |party|
    begin

    template = File.read("#{settings.root}/views/email.erb")

    @party = party
      Pony.options = {
        :subject => "RSVP Update from #{@party.name}",
        :html_body => ERB.new(template).result(),
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'someone@example.com',
          :password             => ENV["SMTP_PASSWORD"],
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "example.com"
        }
      }

      Pony.mail(:to => ENV["SMTP_TO"])

      party.update(notified_at: DateTime.now)

    rescue
      puts $!
    end
  end
end
