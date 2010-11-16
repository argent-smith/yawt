#!/usr/bin/env ruby
#
# Author:: Pavel Argentov <argentoff@gmail.com>
# 
# YAWT 'whois(1)' implementation

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

help = <<HELP
YAWT 'whois(1)' implementation

Command Line Usage:
  
  yawt [-s whois_server] "request"  # => response String

  Default whois server is "whois.ripe.net"

  Options:
HELP

require 'optparse'
require 'yawt'

options = {}
opts = OptionParser.new do |opts|
  opts.banner = help

  opts.on("-s [name]", "Optional server name or IP") do |addr|
    options[:server] = addr unless addr.nil?
  end
  opts.on("-h", "Display help") do
    puts opts.help
    exit 1
  end
end

# Read command line options into `options` hash
opts.parse!

case ARGV.size
when 1
  options[:request] = ARGV[0]
else
  puts "Incorrect arguments; use -h to see help."
  exit 1
end

puts YAWT.whois(options[:server], options[:request])