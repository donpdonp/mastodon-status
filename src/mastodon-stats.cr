require "./mastodon-stats/*"
require "http/client"

module Mastodon::Stats
  response = HTTP::Client.get "http://www.example.com"
end
