require 'sequel'
require './db/page_arrays'
require './lib/page'

class PageStore
  include PageData

  def self.database
    if ENV["DATABASE_URL"]
      @database ||= Sequel.connect(ENV["DATABASE_URL"])
    else
      @database ||= Sequel.sqlite("db/page_#{environment}.sqlite3")
    end
  end

  def self.environment
    ENV["RACK_ENV"] || "development"
  end

  def self.destroy
    if database.tables.include?(:pages)
      database.drop_table(:pages)
    end
  end

  def self.pages
    unless database.tables.include?(:pages)
      database.run "CREATE TABLE pages (id serial primary key, slug varchar, category varchar, content varchar)"
    end
      @pages ||= database[:pages]
  end

  def self.create(data)
    pages.insert(data)
  end

  def self.all
    database.fetch('SELECT * FROM pages').all
  end

  # def self.find(id_term)
  #   if finder_method(:id, id_term) != []
  #     finder_method(:id, id_term).first[:slug]
  #   else
  #     "<h1> Page Does Not Exist </h1>" 
  #   end
  # end

  def self.find_by_slug(slug_term)
    if finder_method(:slug, slug_term) != []
      finder_method(:slug, slug_term).first[:content]
    else
      "<h1> Page Does Not Exist </h1>" 
    end
  end

  def self.finder_method(find_by, slug_term)
    all.select do |data|
      data[find_by] == slug_term
    end
  end

  def self.find_all_by_category
  end

  def self.search

  end

  #Will probably need to change all ids to

  def self.update(content_id, slug_id)
    pages.where(:slug => slug_id).update(:content => content_id)
  end

  def self.delete(id)

  end



 end



############


#   def database
#     @database ||= Sequel.sqlite('development.sqlite3')
#   end

#   def pages
#     database[:pages]
#   end

#   def all_pages
#     array = []
#     pages.each do |page|
#       array << [page[:slug], page[:content]]
#     end
#     array
#   end

#   def find_page(search_word)
#     all_pages.select do |page|
#       page.first == search_word
#     end
#   end

#   def insert
#     pages.insert(:slug => slug, :content => content)
#   end
