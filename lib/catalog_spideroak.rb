require_relative 'catalog'
require 'base32'

# Catalog with Spideroak urls
# they are formed:
#   spideroak_base_path +
#   base32_encoded_username_without_the_last_=s +
#   device_name
#   abs_path_on_device

class CatalogSpideroak < Catalog
    
  attr_accessor :username, :device
  
  def url path
    "https://web-dc2.spideroak.com/storage/" +
    Base32.encode(username).gsub(/=*/, '') +
    "/" + device + "/" + path
  end
  
end