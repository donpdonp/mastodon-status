require "http/client"
require "xml"
require "json"

module Mastodon::Stats
  class Scrape
    def go
      response = HTTP::Client.get "https://instances.mastodon.xyz"
      document = XML.parse(response.body)
      nodes = document.xpath_nodes("//tbody/tr")
      nodes.each do |node|
        puts xtoj(node).to_json
      end
    end

    def xtoj(node)
      z = Instance.new
      puts node
      host = node.xpath_node("td[@scope='row']")
      if host
        z.name = "a"
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
      z
    end
  end
end
