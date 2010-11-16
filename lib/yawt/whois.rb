# Author:: Pavel Argentov <argent-smith@gmail.com>
#
# YAWT::Whois class definition.
#
module YAWT

  # Whois request initiation and processing wrapper.
  #
  class Whois
    # WHOIS server to use.
    attr_accessor :server
    # TCP port number on WHOIS server.
    attr_accessor :port
    # String of request
    attr_accessor :request
    # Field to store raw server's Response.
    attr_reader :response

    # Creates new Whois. Can yield a block with newly created Whois applied.
    #
    # Examples:
    #   new(
    #       :server  => 'my.favorite.whois.net'
    #       :request => 'foo.bar.com'
    #   )
    # or
    #   new |w|
    #     # do what appropriate with 'w' Whois object
    #   end
    #
    # Arguments are optional.
    #
    # Argument defaults:
    # [:server] 'whois.ripe.net'
    # [:request] 'help'
    #
    def initialize(args = {})
      args = {
        :server  => DEFAULTS[:server],
        :port    => DEFAULTS[:port],
        :request => DEFAULTS[:request]
      }.merge!(args)

      @server  = args[:server]
      @request = args[:request]
      @port    = args[:port]

      yield self if block_given?
    end

    # RFC 3912 implementation:
    #
    # Sends the request to server;
    # Returns Response;
    # Sets the @response attribute of self.
    #
    def query!(request = @request)
      @request = request
      buf = ""
      s = TCPSocket.new(@server, @port)
      s.write "#{request}\r\n"
      while line = s.gets
        buf << line
      end
      s.close
      @response = Response.new(buf)
    end
    
    alias :ask! :query!
  end
end
