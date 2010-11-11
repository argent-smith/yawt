require 'socket'

# = YAWT: Yet Another Whois Tool
# This is the library which I've started to implement some things useful to me
# which I couldn't find in neither Simone Carletti's really nice 'whois' nor any
# other whois gems already available on Gemcutter.
module YAWT

  # Whois request initiation and processing wrapper.
  class Whois
    # WHOIS server to use.
    attr_accessor :server
    # String of request
    attr_accessor :request
    # Field to store raw server's Response.
    attr_reader :response

    # Creates new Whois. Can yield a block with newlt created Whois applied.
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
        :server  => 'whois.ripe.net',
        :request => 'help'
      }.merge!(args)

      @server  = args[:server]
      @request = args[:request]

      yield self if block_given?
    end

    # Sends the request to server;
    # Returns Response;
    # Sets the @response attribute of self.
    #
    def query(request = @request)
      # TODO: implement the following:
      # - connect to the server
      # - read the response
      # - create the Response
      #   - set @response
      #   - return Response
      #
    end
  end

  # Response from WHOIS server.
  class Response
    attr_reader :raw
  end
end