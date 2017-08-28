module Blog
  module Gem
    module ApplicationHelper
      def facebook_html(html)
        doc = Nokogiri::HTML(html)
        doc.search('a').each do |link|
          link.content = "#{link.content} (#{link.attributes["href"].value})"
        end
        doc.to_html
      end
    end
  end
end
