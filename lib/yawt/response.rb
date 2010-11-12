# Author:: Pavel Argentov <argentoff@gmail.com>
#
# This file contains YAWT::Response class definition 
module YAWT
  # Response from WHOIS server.
  class Response
    # Unparsed raw text response from WHOIS server
    attr_reader :raw
    def initialize(raw)
      @raw = raw
    end
  end
end
