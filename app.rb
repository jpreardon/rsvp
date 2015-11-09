require 'sinatra'
require 'newrelic_rpm'
require 'sinatra/activerecord'
require 'pony'
require './config/environments' #database configuration
require 'rack/session/moneta'
require './models/party'
require './models/person'
require './models/category'

# Create session store
use Rack::Session::Moneta, :store => Moneta.new(:ActiveRecord, :expires => true)

register do
  def auth (type)
    condition do
      redirect "/rsvp" unless send("is_#{type}?")
    end
  end
end

helpers do
  def is_party?
    @party != nil
  end

  def booleanToFA(value)
    case value
    when true
      return '<i style="color: green;" class="fa fa-check"></i>'
    when false
      return '<i style="color: red;" class="fa fa-close"></i>'
    else
      return '<i style="color: grey;" class="fa fa-question"></i>'
    end
  end

  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ENV['AUTH_USER'], ENV['AUTH_PASSWORD']]
  end

  ## This date helper formats dates the way we want without blowing up on nils
  ## I'm also doing some timezone handling here, perhaps not the right place to do
  ## it, but I don't want to futz with the models now that the app is in production
  ## and I really only care about converting from UTC for viewing.
  def format_date(dt)
    if dt.is_a?(Time)
      dt = dt.to_datetime
    end
    dt.new_offset('-0400').strftime("%B %e, %Y %H:%M") unless dt.nil?
  end
end

before do
  @party = Party.find_by(ticket_number: session[:ticket_number])
end

get '/', :auth => :party do
  @message = session[:message]
  session[:message] = nil
  erb :index
end

post '/', :auth => :party do
  begin
    # In order to update, both the ticket_number and user_id must match.
    # This will prevent someone from mischievously RSVPing with a
    # different user_id. This is why we are going through the party
    # model to update people, people.
    @party = Party.find_by(ticket_number: session[:ticket_number])

    if params[:attending].nil?
      session[:message] = "Please select yes or no."
      redirect("/")
    end

    params[:attending].each do |response|
      @party.people.find_by(id: response[0]).update(attending: response[1])
    end
    @party.update(comments: params[:comments], rsvp: TRUE, notified_at: nil)
    erb :index
  rescue
    puts $!
    session[:ticket_number] = nil
    session[:message] = "Sorry, something went wrong, please enter your ticket number again."
    redirect("/")
  end
end

# This is the main entry point for the RSVP app and serves as a login page
get '/rsvp' do
  @title = "Check-in"
  @message = session[:message]
  session[:message] = nil
  erb :rsvp
end

post "/login" do
  if (@party = Party.find_by ticket_number: params[:ticket_number].gsub(/\s+/, "").upcase)
    session[:ticket_number] = @party.ticket_number
    @party.update(viewed_at: DateTime.now)
    redirect("/")
  else
    @message = "Ticket number #{params[:ticket_number]} not found, please try again."
    session[:message] = @message
    redirect("/rsvp")
  end
end

get "/login" do
  session[:ticket_number] = nil
  redirect("/")
end

get "/logout" do
  session[:ticket_number] = nil
  redirect("/")
end

get "/reports" do
  protected!
  erb :reports
end

get "/reports_summary" do
  protected!

  @adults_attending = Person.where(attending: true, category_id: 1).count
  @adults_not_attending = Person.where(attending: false, category_id: 1).count
  @adults_unknown = Person.where(attending: nil, category_id: 1).count
  @children_attending = Person.where(attending: true, category_id: 2).count
  @children_not_attending = Person.where(attending: false, category_id: 2).count
  @children_unknown = Person.where(attending: nil, category_id: 2).count
  @total_attending = @adults_attending + @children_attending
  @total_not_attending = @adults_not_attending + @children_not_attending
  @total_unknown = @adults_unknown + @children_unknown

  erb :reports_summary

end

get "/reports_attending_full" do
  protected!
  @parties = Party.all.order('sort_name')
  erb :reports_attending_full
end

get "/reports_attending" do
  protected!
  case params['filter']
  when "attending"
    @parties = Party.attending.order('sort_name')
    @filter_name = "Attending"
  when "rsvped"
    @parties = Party.rsvped.order('sort_name')
    @filter_name = "RSVPed"
  when "viewed"
    @parties = Party.viewed.order('sort_name')
    @filter_name = "Viewed"
  when "norsvp"
    @parties = Party.norsvp.order('sort_name')
    @filter_name = "No RSVP"
  else
    @parties = Party.all.order('sort_name')
    @filter_name = "All"
  end
  erb :reports_attending
end
