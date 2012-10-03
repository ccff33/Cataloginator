require 'nokogiri'
require 'base64'

# Very important!
# It only serves for the purposes of this simple project
# Embeds the following content:
#   js files linked with <script src=".*">
#   css files linked with <link href=".*">
#   png files from css linked with url(.*/images/.*)


class DummyDependencyRemover
  
  def self.embed_related_files html_content, original_path
    html = Nokogiri::HTML html_content

    # js
    html.xpath('//script[@src and . = ""]').each do |script|
      embedded = Nokogiri::XML::Node.new 'script', html
      embedded.content = File.open(File.join(original_path, script['src'])).read
      script.add_next_sibling embedded
      script.remove
    end
    
    # css
    html.xpath('//link[@rel="stylesheet"]').each do |css|
      embedded = Nokogiri::XML::Node.new 'style', html
      path_to_css = File.join(original_path, css['href'])
      css_content = File.open(path_to_css).read
      # search for urls, containing "images". In the project we only have images in folders named "images"
      css_content.gsub!(/url\(['"]?([^\)'"]*images[^\)'"]*)['"]?\)/).each do |match|
        image_file = File.open(File.join(File.dirname(path_to_css), $1), 'rb').read
        match = "url(\"data:image/png;base64,#{Base64.encode64(image_file).gsub("\n", '')}\")"
      end
      embedded.content = css_content
      css.add_next_sibling embedded
      css.remove
    end
    html
  end

end