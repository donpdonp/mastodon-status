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
      instances_users = instances.sum { |i| i.users }
      instances_statuses = instances.sum { |i| i.statuses }
      instances_connections = instances.sum { |i| i.connections }
      puts "#{instances.size} instances. " +
           "#{instances_users} users. " +
           "#{instances_statuses} statuses. " +
           "#{instances_connections} connections."
      stat_url = "http://localhost:8086/write?db=mastodon"
      HTTP::Client.post(stat_url, nil, "instances_count value=#{instances.size}")
      HTTP::Client.post(stat_url, nil, "instances_users value=#{instances_users}")
      HTTP::Client.post(stat_url, nil, "instances_statuses value=#{instances_statuses}")
      HTTP::Client.post(stat_url, nil, "instances_connections value=#{instances_connections}")
    end
  end
end
