require "./mastodon-stats/*"

module Mastodon::Stats
end

Mastodon::Stats::Scrape.new.go
