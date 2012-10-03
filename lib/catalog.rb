require_relative 'book'
require 'sqlite3'
require 'haml'

# Catalog with absolute paths

class Catalog

  attr_accessor :calibre_library_local_path
                
  @@TEMPLATE_FILE = "#{File.dirname(__FILE__)}/../template/template.haml"
  @@CALIBRE_METADATA = "metadata.db"
  @@COVER_FILE = "cover.jpg"
  
  def to_file output_file
    File.open(output_file, 'w') { |f| f << generate }
  end
  
  def generate
    books = generate_book_list
    table = Hash.new
    table[:content] = Array.new
    table[:headers] = ['ID', 'Title', 'Author', 'Formats']
    books.each do |book|
      formats = Array.new
      book.abs_paths.each do |ext, path|
        formats << { :url => url(path), :name => ext }
      end
      table[:content] <<  [book.id,
                          book.title,
                          book.author,
                          formats]
    end
    template = Haml::Engine.new File.open(@@TEMPLATE_FILE, 'r').read
    template.render Object.new,
                    :content => table[:content],
                    :headers => table[:headers]
  end
  
  def generate_book_list
    db = SQLite3::Database.new File.join calibre_library_local_path, @@CALIBRE_METADATA
    books = Array.new
    books_data = db.execute "
            select
               B.id, B.path, D.name, lower(group_concat(distinct D.format)),
               B.title, group_concat(distinct A.name), C.text
            from
              books B
              join data D on D.book = B.id
              join books_authors_link BAL on BAL.book = B.id
              join authors A on A.id = BAL.author
              left outer join comments C on C.book = B.id
            group by
              B.id, B.path, D.name, B.title, C.text"

    books_data.each do |row|
      book = Book.new
      # set id
      book.id = row[0]
      # set book cover abs path
      book.cover = [calibre_library_local_path, row[1], @@COVER_FILE] * File::SEPARATOR
      # set paths for the different formats
      row[3].split(',').each do |ext|
        book.abs_paths[ext] = [calibre_library_local_path, row[1], row[2]] * File::SEPARATOR + '.' + ext
      end
      book.author = row[5]
      book.title = row[4]
      book.description = row[6]
      books.push book
    end

    books
  end
  
  def url path
    path
  end
  
end
