class Book
  
  attr_accessor :id, # id in library
                :abs_paths, # absolute paths for all file types of the book
                :cover, # absolute path of the cover image
                :author, :title, :description
  
  def initialize
    @abs_paths = Hash.new
  end
  
end