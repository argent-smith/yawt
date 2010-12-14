# Author:: Pavel Argentov <argentoff@gmail.com>
#
# YAWT::Response class definition.
#
module YAWT
  # Response from WHOIS server.
  class Response
    # Unparsed raw text response from WHOIS server
    attr_reader :raw
    attr_reader :rpsl
    def initialize(raw)
      @raw  = raw
      @rpsl = parse raw
    end

    private

    # First level of parsing:
    # - filter out the comments;
    # - split the text into RPSL entities.
    def parse text
      text.gsub(/^%.*$/,'').split(/\n\n/).map do |s|
        s.chomp!
        s.gsub(/^#{$/}/,'') unless s.empty?
      end . compact
    end

  end
end
