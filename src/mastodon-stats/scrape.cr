require "http/client"
require "xml"
require "json"

module Mastodon::Stats
  class Scrape
    def go
      url = "https://instances.mastodon.xyz"
      response = HTTP::Client.get url
      document = XML.parse(response.body)
      nodes = document.xpath_nodes("//tbody/tr")
      instances = [] of Instance
      nodes.map { |node| instances.push(Instance.new(node)) }
      puts "#{instances.size} instances. " +
           "#{instances.sum { |i| i.users }} users. " +
           "#{instances.sum { |i| i.statuses }} statuses. " +
           "#{instances.sum { |i| i.connections }} connections."
    end
  end
end
