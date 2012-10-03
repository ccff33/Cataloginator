require_relative 'lib/catalog'

catalog = Catalog.new
catalog.calibre_library_local_path = "E:/Books/Literature"
catalog.to_file "j.html"
