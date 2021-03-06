require 'dhcp_common/record'

module Proxy::DHCP
  class Lease < Record
    attr_reader :name, :starts, :ends, :state

    def initialize(name, ip_address, mac_address, subnet, starts, ends, state, options = {})
      @name = name || "*lease*"
      @starts = starts
      @ends = ends
      @state = state
      super(ip_address, mac_address, subnet, options)
    end

    def deletable?
      false
    end

    def ==(other)
      super(other) && name == other.name && starts == other.starts && ends == other.ends && state == other.state
    end

    def to_json(*opts)
      Hash[[:name, :ip, :mac, :subnet, :starts, :ends, :state].map{|s| [s, send(s)]}].merge(options).to_json(*opts)
    end
  end
end
