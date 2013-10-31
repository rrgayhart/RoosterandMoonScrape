require 'sinatra'
require 'sequel'
require './lib/page'
require './lib/page_store'
require './lib/contact'

class RestaurantApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  get '/' do
    erb :index
  end

  get '/contact' do
    erb :contact
  end

  post '/contact' do
    Contact.new(params[:contact]).send_email
    redirect '/'
  end

  get '/:slug' do |slug|
    if PageStore.find_by_slug(slug) != []
      page = PageStore.find_by_slug(slug)
    else
      page = "lecentral"
    end
    erb :page, locals: {content: page}
  end

  get '/:slug/edit' do |slug|
    if PageStore.find_by_slug(slug) != []
      page = PageStore.find_by_slug(slug)
    else
      page = "lecentral"
    end
    erb :edit, locals: {content: page, slug: slug}
  end

  post '/update' do
    # page = PageStore.find_by_slug(params[:slug])
    #formatted_page = Page.to_h(params[:slug], params[:new_content])
    PageStore.update(params[:new_content], params[:slug])
    redirect "/#{params[:slug]}"
  end

  get '/events' do
    erb :events
  end

  get '/menus' do
    erb :menus
  end

  get '/party_info' do
    erb :party_info
  end

  private

  # def menu_items_database_table
  #   database ||= Sequel.sqlite('database.sqlite3')
  #   database[:raw_menu_items]
  # end

  # def pages_table
  #   database ||= Sequel.sqlite('development.sqlite3')
  #   database[:pages]
  # end
end
