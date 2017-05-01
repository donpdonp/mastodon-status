require "http/client"
require "xml"
require "json"

module Mastodon::Stats
  class Scrape
    def go
      url = "https://instances.mastodon.xyz/instances.json"
      response = HTTP::Client.get url
      instances = Array(Instance).from_json(response.body)
      instances_up = instances.reject { |i| !i.up }.size
      instances_open = instances.reject { |i| !i.openRegistrations }.size
      instances_users = instances.sum { |i| i.users || 0 }
      instances_statuses = instances.sum { |i| i.statuses || 0 }
      instances_connections = instances.sum { |i| i.connections || 0 }
      puts "#{instances.size} instances. " +
           "#{instances_up} up. " +
           "#{instances_open} open. " +
           "#{instances_users} users. " +
           "#{instances_statuses} statuses. " +
           "#{instances_connections} connections."
      stat_url = "http://localhost:8086/write?db=mastodon"
      HTTP::Client.post(stat_url, nil, "instances_count value=#{instances.size}")
      HTTP::Client.post(stat_url, nil, "instances_up value=#{instances_up}")
      HTTP::Client.post(stat_url, nil, "instances_open value=#{instances_open}")
      HTTP::Client.post(stat_url, nil, "instances_users value=#{instances_users}")
      HTTP::Client.post(stat_url, nil, "instances_statuses value=#{instances_statuses}")
      HTTP::Client.post(stat_url, nil, "instances_connections value=#{instances_connections}")
    end
  end
end
