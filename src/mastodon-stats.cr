require "./mastodon-stats/*"
require "http/client"
require "xml"

module Mastodon::Stats
  class Scrape
    def go
      response = HTTP::Client.get "https://instances.mastodon.xyz"
      document = XML.parse(response.body)
      nodes = document.xpath_nodes("//tbody/tr")
      nodes.each do |node|
        xtoj(node)
      end
    end

    def xtoj(node)
      puts node
      host = node.xpath_node("td[@scope='row']")
      if host
        puts "host: #{host["data-value"]}"
      end
      host = node.xpath_node("td[@class='table-danger']")
      if host
        puts "up: #{host.content}"
      end
      host = node.xpath_node("td[3]")
      if host
        puts "c: #{host.content}"
      end
      host = node.xpath_node("td[4]")
      if host
        puts "c: #{host.content}"
      end
      host = node.xpath_node("td[5]")
      if host
        puts "c: #{host.content}"
      end
    end
  end
end

Mastodon::Stats::Scrape.new.go
