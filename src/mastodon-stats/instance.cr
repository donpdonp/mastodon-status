require "json"

module Mastodon::Stats
  class Instance
    @name = nil
    @uptime = nil
    @up = nil
    @ipv6 = nil
    @openRegistrations = nil
    @users = nil
    @statuses = nil
    @connections = nil
    property name, up, users, statuses, connections

    JSON.mapping(
      name: String?,
      uptime: Float64?,
      up: Bool?,
      ipv6: Bool?,
      openRegistrations: Bool?,
      users: Int64?,
      statuses: Int64?,
      connections: Int64?
    )

    def initialize
    end

    def to_json
      JSON.build do |json|
        json.object do
          json.field "name", @name
          json.field "up", @up
          json.field "users", @users
          json.field "statuses", @statuses
          json.field "connections", @connections
        end
      end
    end
  end
end
