# Author:: Pavel Argentov <argentoff@gmail.com>
# 
# YAWT utility methods.
#
module YAWT
  
  class <<self
    # Simplest Whois wrapper.
    # Creates Whois and calls its \#ask! method (see Whois#ask!).
    # 
    # Parematers (optional):
    # - server:  WHOIS server name|IP String;
    # - request: request String.
    # 
    # Returns:
    # - unparsed raw WHOIS response.
    #
    def whois(server, request)
      args = {}
      args[:server]  = server  unless server.nil?
      args[:request] = request unless request.nil?
      Whois.new(args).ask!.raw
    end
  end
end