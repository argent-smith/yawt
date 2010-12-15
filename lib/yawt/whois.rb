  # Author:: Pavel Argentov <argent-smith@gmail.com>
#
# YAWT::Whois class definition.
#
module YAWT

  # Whois request initiation and processing wrapper.
  #
  class Whois
    # WHOIS server to use.
    attr_reader :server
    # TCP port number on WHOIS server.
    attr_reader :port
    # String of request
    attr_reader :request
    # Server's Response.
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
      if args.is_a? Hash
        args = {
          :server  => DEFAULTS[:server],
          :port    => DEFAULTS[:port],
          :request => DEFAULTS[:request]
        }.merge!(args)
      elsif args.is_a? String
        args = {
          :server  => DEFAULTS[:server],
          :port    => DEFAULTS[:port],
          :request => args
        }
      else 
        raise ArgumentError, "args is #{args.class} but String or Hash required"
      end

      @server  = args[:server]
      @request = args[:request]
      @port    = args[:port]

      query!
    end

    private
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
