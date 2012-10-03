require_relative 'lib/catalog_spideroak'

catalog = CatalogSpideroak.new
catalog.username = "test_username"
catalog.device = "test_pc"
catalog.calibre_library_local_path = "E:/Books/Literature"
catalog.to_file "j.html"
