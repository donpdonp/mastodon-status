module Mastodon::Stats
  class Instance
    @name = ""
    @up = false
    @users = -1
    @statuses = -1
    @connections = -1
    property name, up, users, statuses, connections

    def initialize(@xml : XML::Node)
      from_xml(xml)
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

    def from_xml(node)
      host = node.xpath_node("td[1]")
      if host
        self.up = host.content == "UP"
      end
      host = node.xpath_node("td[3]")
      if host
        self.name = host["data-value"]
      end
      host = node.xpath_node("td[4]")
      if host && host.content && host.content.size > 0
        self.users = host.content.to_i
      end
      host = node.xpath_node("td[5]")
      if host && host.content && host.content.size > 0
        self.statuses = host.content.to_i
      end
      host = node.xpath_node("td[6]")
      if host && host.content && host.content.size > 0
        self.connections = host.content.to_i
      end
    end
  end
end
