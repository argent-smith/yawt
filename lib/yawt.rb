# Author:: Pavel Argentov <argentoff@gmail.com>
#
# Basic YAWT module constants, requires and utility
#

######## Utility

$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

##### Requires:

# stdlib
require 'socket'

# internals
require 'yawt/response'
require 'yawt/whois'

# = Yet Another Whois Tool
# This is the library which I've started to implement some things useful to me
# which I couldn't find in neither Simone Carletti's really nice 'whois' nor any
# other whois gems already available on Gemcutter.
module YAWT

  ####### Constants

  # YAWT version code: 0.0.0
  VERSION = "0.0.0"

  # YAWT library defaults: Hash containing:
  #   :server =>  'whois.ripe.net', # default WHOIS server
  #   :port   =>   43,              # default WHOIS TCP port
  #   :request => 'help'            # default WHOIS request
  #
  DEFAULTS = {
    :server =>  'whois.ripe.net', # default WHOIS server
    :port   =>   43,              # default WHOIS TCP port
    :request => 'help'            # default WHOIS request
  }
end

# TODO:
# - alias Whois#query -> Whois#ask
# - code YAWT::#whois on top of above
# - code bin/whoisya as CLI util
#